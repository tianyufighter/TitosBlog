import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
/*
* 首页的轮播图片
* */
class SwiperPage extends StatefulWidget {
  const SwiperPage({Key? key}) : super(key: key);

  @override
  _SwiperPageState createState() => _SwiperPageState();
}

class _SwiperPageState extends State<SwiperPage> {
  // 轮播图片
  List<Map> imageList = [
    {
      "url":"assets/swiper/1.jpeg"
    },
    {
      "url":"assets/swiper/2.jpeg"
    },
    {
      "url":"assets/swiper/3.jpeg"
    },
    {
      "url":"assets/swiper/4.jpeg"
    }
  ];
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: AspectRatio(
        // 配置宽高比
        // aspectRatio: 16/9,
        aspectRatio: 16/7,
        child: new Swiper(
          itemBuilder: (BuildContext context,int index){
            // 配置图片地址
            return new Image.asset(imageList[index]["url"],fit: BoxFit.fill,);
          },
          // 配置图片数量
          itemCount: imageList.length ,
          // 底部分页器
          pagination: new SwiperPagination(),
          // 左右箭头
          control: new SwiperControl(),
          // 无限循环
          loop: true,
          // 自动轮播
          autoplay: true,
        ),
      ),
    );
  }
}
