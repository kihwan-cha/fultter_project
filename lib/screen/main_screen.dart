import 'package:flutter/material.dart';
import 'package:flutter_project/model/post_model.dart';
import 'package:flutter_project/util/api_service.dart';
import 'package:cached_network_image/cached_network_image.dart';

import 'main_detail_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  List<Post> posts = [];


  @override
  void initState() {
    super.initState();
    fetchData();
  }

  void fetchData() async {
    final apiService = ApiService();
    var data = await apiService.get("/posts"); // API 호출
    setState(() {
      posts = List<Map<String, dynamic>>.from(data)  // 1. Map 변환
          .map((e) => Post.fromMap(e))               // 2. Post 변환
          .toList();                                 // 3. 리스트로
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("API 테이블뷰"),
      leading: IconButton(
          onPressed: () {
              if (Navigator.canPop(context)) {
                Navigator.pop(context);
              } else {
                print("뒤로 갈 화면이 없습니다");
              }
            },
          icon: const Icon(Icons.arrow_back)),
      ),
      body: posts.isEmpty
          ? Center(child: CircularProgressIndicator()) // 데이터 로딩 중
          : ListView.separated(
        itemCount: posts.length,
        separatorBuilder: (context, index) => Divider(),
        itemBuilder: (context, index) {
          var post = posts[index];
          return GestureDetector(
            onTap: () {
              print("선택된 ID: ${post.id}");
              print("이미지 주소: ${post.imageUrl}");
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => MainDetailScreen(post: post),
                ),
              );
            },
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 🟣 이미지 + 제목 + ID (가로 정렬)
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // 🟡 이미지
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.blueAccent),
                          shape: BoxShape.circle,
                        ),
                        padding: EdgeInsets.all(2),
                        child: CircleAvatar(
                          backgroundImage: CachedNetworkImageProvider(post.imageUrl),
                          radius: 30,
                        ),
                      ),

                      SizedBox(width: 12),

                      // 🟢 제목
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.green),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            "${post.title}",
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                          ),
                        ),
                      ),

                      SizedBox(width: 12),

                      // 🔵 ID
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.deepPurple),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          "ID: ${post.id}",
                          style: TextStyle(fontSize: 12, color: Colors.deepPurple),
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 12),

                  // 🟠 본문 (Row 아래)
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.orange),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      post.body,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(color: Colors.grey[700]),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

}