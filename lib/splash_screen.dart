import 'package:flutter/material.dart';
import 'screen/home_screen.dart';
import 'dart:async';
import 'screen/main_screen.dart'; // MainScreen 가져오기

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // 5초 후 MainScreen으로 이동
    Timer(Duration(seconds: 5), () {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => HomeScreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: SizedBox.expand(  // 화면 전체 크기로 설정
          child: Image.asset(
            'assets/splash_image.png',
            fit: BoxFit.cover,  // 화면에 꽉 차게 표시
          ),
        ),
      ),
    );
  }
}
