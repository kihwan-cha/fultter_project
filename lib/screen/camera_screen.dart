import 'dart:io';

import 'package:flutter/material.dart';
import 'package:camera/camera.dart';

class CameraScreen extends StatefulWidget {
  const CameraScreen({super.key});

  @override
  State<CameraScreen> createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  CameraController? _controller;
  List<CameraDescription>? _cameras;
  XFile? _image;

  @override
  void initState() {
    super.initState();
    initCamera();
  }

  Future<void> initCamera() async {
    try {
      _cameras = await availableCameras();
      _controller = CameraController(_cameras![0], ResolutionPreset.medium);
      await _controller!.initialize();
      if (mounted) setState(() {});
    } catch (e) {
      print("카메라 초기화 실패: $e");
    }
  }
  
  Future<void> takePicture() async {
    if (!_controller!.value.isInitialized) return;
    final image = await _controller!.takePicture();
    setState(() {
      _image = image;
    });
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("카메라")),
      body:  _controller == null || !_controller!.value.isInitialized
          ? Center(child: CircularProgressIndicator()) // ✅ 로딩 상태
          :Column(
        children: [
          Expanded(child: CameraPreview(_controller!)),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton.icon(
              onPressed: () {
                // 촬영 함수 호출
                takePicture();
              },
              icon: Icon(Icons.camera_alt),
              label: Text("사진 찍기"),
              style: ElevatedButton.styleFrom(
                minimumSize: Size(double.infinity, 48),
              ),
            ),
          ),
          // if (_image != null) ...[
          //   SizedBox(height: 20),
          //   Text("촬영된 이미지"),
          //   Image.file(
          //     File(_image!.path),
          //     height: 200,
          //   ),
          // ]
        ],
      )
    );
  }
}