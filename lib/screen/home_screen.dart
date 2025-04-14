import 'package:flutter/material.dart';
import 'package:flutter_project/model/home_screen_model.dart';
import 'package:flutter_project/screen/camera_screen.dart';
import 'package:flutter_project/screen/collection_scree.dart';
import 'package:flutter_project/screen/lnb_screen.dart';
import 'package:flutter_project/screen/push_screen.dart';
import 'package:flutter_project/screen/todaymenu/today_memu_screen.dart';
import 'package:flutter_project/screen/web_screen.dart';

import 'main_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<HomeScreenModel> homeScreenDataList = [
    HomeScreenModel(title: "API 테이블 뷰", className: MainScreen(), icon: Icons.view_headline),
    HomeScreenModel(title: "LNB", className: LnbScreen(), icon: Icons.menu),
    HomeScreenModel(title: "웹뷰", className: WebScreen(), icon: Icons.web),
    HomeScreenModel(title: "카메라", className: CameraScreen(), icon: Icons.camera_alt_rounded),

    HomeScreenModel(title: "푸시 테스트", className: PushScreen(), icon: Icons.notifications),
    HomeScreenModel(title: "컬렉션 뷰", className: CollectionScreen(), icon: Icons.grid_view),

    HomeScreenModel(title: "오늘 뭐 먹지?", className: TodayMenuScreen(), icon: Icons.restaurant),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("홈스크린")),
      body: homeScreenDataList.isEmpty
          ? Center(child: CircularProgressIndicator()) // 데이터 로딩 중
          : ListView.separated(
        itemCount: homeScreenDataList.length,
        separatorBuilder: (context, index) => Divider(),
        itemBuilder: (context, index) {
          var homeScreenData = homeScreenDataList[index];
          return ListTile(
            leading: Icon(homeScreenData.icon),
            title: Text(homeScreenData.title, style: TextStyle(fontWeight: FontWeight.bold)),
            onTap: () {
              final className = homeScreenData.className;
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => className),
              );
            },
          );
        },
      ),
    );
  }

}
