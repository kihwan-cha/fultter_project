import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../util/today_menu_storage.dart';

class TodayMenuInputScreen extends StatefulWidget {
  const TodayMenuInputScreen({super.key});

  @override
  State<TodayMenuInputScreen> createState() => _TodayMenuInputScreenState();
}

class _TodayMenuInputScreenState extends State<TodayMenuInputScreen> {
  final TextEditingController _controller = TextEditingController();
  List<String> menuList = [];

  @override
  void initState() {
    super.initState();
    _loadMenuList();
  }

  Future<void> _loadMenuList() async {
    final loadedList = await TodayMenuStorage.loadMenuList();
    setState(() {
      menuList = loadedList;
    });
    print('불러온 메뉴: $menuList');
  }

  Future<void> addMenu() async {
    final text = _controller.text.trim();
    if (text.isNotEmpty) {
      setState(() {
        menuList.add(text);
        _controller.clear();
      });

      await TodayMenuStorage.saveMenuList(menuList);

      print(menuList);
    }
  }

  Future<void> removeMenu(int index) async {
    setState(() {
      menuList.removeAt(index);
    });
    await TodayMenuStorage.saveMenuList(menuList);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('🍽️ 메뉴 입력')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: const InputDecoration(
                      hintText: '메뉴 이름을 입력하세요',
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                ElevatedButton(
                  onPressed: addMenu,
                  child: const Text('추가'),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                itemCount: menuList.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(menuList[index]),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () => removeMenu(index),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
