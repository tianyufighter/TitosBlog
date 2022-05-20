import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:image_picker/image_picker.dart';
import 'package:zefyr/zefyr.dart';


class MyAppZefyrImageDelegate implements ZefyrImageDelegate<ImageSource> {
  const MyAppZefyrImageDelegate();
  @override
  Future<String> pickImage(ImageSource source) async {
    final file = await ImagePicker.pickImage(source: source);
    if (file == null) return null;
    // Use my storage service to upload selected file. The uploadImage method
    // returns unique ID of newly uploaded image on my server.
    String path = file.path;
    var name = path.substring(path.lastIndexOf("/") + 1, path.length);
    FormData formData = FormData.fromMap({
      //"": "", //这里写其他需要传递的参数
      "file": await MultipartFile.fromFile(path, filename: name),
    });
    String filePath = "";
    var response = await Dio().post("http://192.168.242.1/article/storeArticleImage", data: formData);
    filePath = response.data["message"];
    // return file.uri.toString();
    return filePath;
  }

  @override
  Widget buildImage(BuildContext context, String key) {
    // We use custom "asset" scheme to distinguish asset images from other files.
    if (key.startsWith('asset://')) {
      final asset = AssetImage(key.replaceFirst('asset://', ''));
      return Image(image: asset);
    } else if (key.startsWith('http')) {
      return Image(image: NetworkImage(key));
    } else {
      // Otherwise assume this is a file stored locally on user's device.
      final file = File.fromUri(Uri.parse(key));
      final image = FileImage(file);
      return Image(image: image);
    }
  }

  @override
  // TODO: implement cameraSource
  ImageSource get cameraSource => ImageSource.camera;

  @override
  // TODO: implement gallerySource
  ImageSource get gallerySource => ImageSource.gallery;
}