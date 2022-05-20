import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImagePickerPage extends StatefulWidget {
  ImagePickerPage({Key? key}) : super(key: key);

  _ImagePickerPageState createState() => _ImagePickerPageState();
}

class _ImagePickerPageState extends State<ImagePickerPage> {
  //记录选择的照片
  File? _image;


  //拍照
  Future _getImageFromCamera() async {
    var image =
    await ImagePicker.pickImage(source: ImageSource.camera, maxWidth: 400);
    setState(() {
      _image = image;
    });
  }

  //相册选择
  Future _getImageFromGallery() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      _image = image;
    });
  }

  //上传图片到服务器
  _uploadImage() async {
    String path = _image!.path;
    var name = path.substring(path.lastIndexOf("/") + 1, path.length);
    FormData formData = FormData.fromMap({
      //"": "", //这里写其他需要传递的参数
      "file": await MultipartFile.fromFile(path, filename: name),
    });
    // var response = await Dio().post("http://localhost/imgupload", data: formData);
    print("准备上传图片");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("选择图片并上传")),
      body: Container(
        child: ListView(
          children: <Widget>[
            RaisedButton(
              onPressed: () {
                _getImageFromCamera();
              },
              child: Text("照相机"),
            ),
            SizedBox(height: 10),
            RaisedButton(
              onPressed: () {
                _getImageFromGallery();
              },
              child: Text("相册"),
            ),
            SizedBox(height: 10),
            /**
             * 展示选择的图片
             */
            _image == null
                ? Text("no image selected")
                : Image.file(
              _image!,
              width: 20,
              fit: BoxFit.cover,
            ),
            SizedBox(height: 10),
            RaisedButton(
              onPressed: () {
                _uploadImage();
              },
              child: Text("上传图片到服务器"),
            )
          ],
        ),
      ),
    );
  }
}