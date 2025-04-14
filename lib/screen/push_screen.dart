import 'package:flutter/material.dart';

class PushScreen extends StatelessWidget {
  const PushScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('텍스트 박스 예제'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            // 여기에 푸시 전송 로직 작성
            print('푸시 전송 버튼 클릭됨');
          },
          child: Text('푸시전송'),
        ),
      ),
    );
  }
  
}