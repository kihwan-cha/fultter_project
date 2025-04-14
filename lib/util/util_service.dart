import 'dart:math';

String getRandomImageUrl() {
  final random = Random();
  int colorValue = random.nextInt(0xFFFFFF + 1);
  String hexColor = colorValue.toRadixString(16).padLeft(6, '0');
  return "https://fakeimg.pl/200x200/$hexColor";
}