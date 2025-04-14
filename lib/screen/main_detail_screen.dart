import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../model/post_model.dart';

class MainDetailScreen extends StatelessWidget {
  const MainDetailScreen({super.key, required this.post});

  final Post post;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Post 상세")),
      body: SingleChildScrollView( // ✅ 여기 추가!
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (post.imageUrl.isNotEmpty)
              Center(
                child:CachedNetworkImage(
                  imageUrl: post.imageUrl,
                  width: 200,
                  // placeholder: (context, url) => CircularProgressIndicator(), // 로딩 중
                  // errorWidget: (context, url, error) => Icon(Icons.error),    // 에러 발생 시
                ),
              ),
            SizedBox(height: 16),
            Text(
              "제목: ${post.title}",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              "본문: ${post.body}${post.body}${post.body}${post.body}${post.body}${post.body}${post.body}${post.body}",
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}

