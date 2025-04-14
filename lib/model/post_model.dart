import '../util/util_service.dart';

class Post {
  final int id;
  final String title;
  final String body;
  final String imageUrl;

  Post.fromMap(Map<String, dynamic> map)
      : id = map['id'],
        title = map['title'],
        body = map['body'],
        imageUrl = getRandomImageUrl();

}