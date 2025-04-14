import 'package:flutter/material.dart';
import 'package:flutter_project/screen/camera_screen.dart';
import 'package:flutter_project/screen/main_screen.dart';
import 'package:flutter_project/screen/web_screen.dart';

import '../model/lnb_menu_model.dart';

class LnbScreen extends StatefulWidget {
  const LnbScreen({super.key});

  @override
  State<LnbScreen> createState() => _LnbScreenSate();
}

class _LnbScreenSate extends State<LnbScreen> {

  final List<LnbMenuItem> menuItems = [
    LnbMenuItem(
      icon: Icons.home,
      title: '홈',
      subItems: [
        LnbSubMenuItem(
          title: '카메라',
          destination: (context) => CameraScreen(),
        ),
        LnbSubMenuItem(
          title: '메인',
          destination: (context) => MainScreen(),
        ),
      ],
    ),

    LnbMenuItem(
      icon: Icons.settings,
      title: '설정',
      destination: (context) => WebScreen(), // 하위 메뉴 없이 바로 이동
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("LNB 예제"),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            if (Navigator.canPop(context)) {
              Navigator.pop(context); // ✅ 이전 화면으로
            } else {
              print("이전 화면 없음");
            }
          },
        ),

        actions: [
          Builder(
            builder: (context) => IconButton(
              icon: Icon(Icons.menu),
              onPressed: () {
                Scaffold.of(context).openDrawer(); // ✅ 왼쪽 메뉴 열기
              },
            ),
          ),
        ],
      ),

      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(color: Colors.blue),
              child: Text(
                '메뉴',
                style: TextStyle(color: Colors.white, fontSize: 24),
              ),
            ),
            ...menuItems.map((item) {
              if (item.subItems != null && item.subItems!.isNotEmpty) {
                return Theme(
                  data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
                  child: ExpansionTile(
                    leading: Icon(item.icon),
                    title: Text(item.title),
                    tilePadding: EdgeInsets.symmetric(horizontal: 16),
                    childrenPadding: EdgeInsets.only(left: 32),
                    children: item.subItems!.map((subItem) {
                      return ListTile(
                        title: Text(subItem.title),
                        onTap: () {
                          Navigator.pop(context);
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: subItem.destination),
                          );
                        },
                      );
                    }).toList(),
                  ),
                );
              } else if (item.destination != null) {
                return ListTile(
                  leading: Icon(item.icon),
                  title: Text(item.title),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: item.destination!),
                    );
                  },
                );
              } else {
                return SizedBox.shrink(); // fallback (안 쓸 일이지만 안전하게)
              }
            }).toList(),
          ],
        ),
      ),

      body: Center(
        child: Text("메인 콘텐츠"),
      ),
    );
  }
}