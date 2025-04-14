import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_fortune_wheel/flutter_fortune_wheel.dart';

import '../../util/today_menu_storage.dart';
import 'today_menu_input_screen.dart';

class TodayMenuScreen extends StatefulWidget {
  const TodayMenuScreen({super.key});

  @override
  _TodayMenuScreenState createState() => _TodayMenuScreenState();
}

class _TodayMenuScreenState extends State<TodayMenuScreen> {
  final StreamController<int> controller = StreamController<int>();
  String? selectedMenu;
  String? pendingSelectedMenu;
  List<String> menuList = [];
  bool isSpinning = false;

  @override
  void initState() {
    super.initState();
    _loadMenuList();
  }

  Future<void> _loadMenuList() async {
    final loadedList = await TodayMenuStorage.loadMenuList();
    setState(() {
      menuList = loadedList;
      menuList.shuffle(); // 무작위 순서
    });

    print('불러온 메뉴: $menuList');
    print('개수: ${menuList.length}');
  }

  void spinRoulette() {
    setState(() {
      isSpinning = true;
      selectedMenu = null; // 이전 결과 숨기기
    });

    final selected = Random().nextInt(menuList.length);
    controller.add(selected);
    pendingSelectedMenu = menuList[selected];
  }

  @override
  void dispose() {
    controller.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(title: const Text('오늘 뭐 먹지?')),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const SizedBox(height: 30),
          if (menuList.length >= 2)
            Center(
              child: SizedBox(
                width: screenWidth,
                height: screenWidth,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Transform.rotate(
                      angle: pi / 2,
                      child: FortuneWheel(
                        selected: controller.stream,
                        items: [
                          for (var menu in menuList)
                            FortuneItem(
                              child: Text(menu, style: const TextStyle(fontSize: 14)),
                            ),
                        ],
                        indicators: const <FortuneIndicator>[],
                        onAnimationEnd: () {
                          setState(() {
                            selectedMenu = pendingSelectedMenu;
                            isSpinning = false;
                          });
                        },
                      ),
                    ),
                    Positioned(
                      right: 0,
                      child: Container(
                        width: 20,
                        height: 5,
                        color: Colors.red,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          const SizedBox(height: 50),
          if (menuList.length >= 2)
            ElevatedButton(
              onPressed: isSpinning ? null : spinRoulette,
              child: const Text('🎯 메뉴 추천받기'),
            ),
          const SizedBox(height: 20),
          if (selectedMenu != null)
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                '오늘은 "$selectedMenu" 어때요?',
                style: const TextStyle(fontSize: 20),
                textAlign: TextAlign.center,
              ),
            ),
          const SizedBox(height: 10),
        ],
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(bottom: 30, left: 16, right: 16),
        child: Row(
          children: [
            Expanded(
              child: ElevatedButton.icon(
                onPressed: () async {
                  await Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const TodayMenuInputScreen()),
                  );
                  _loadMenuList(); // 돌아오면 다시 로딩
                },
                icon: const Icon(Icons.add),
                label: const Text('메뉴 입력'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
