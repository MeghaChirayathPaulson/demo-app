import 'dart:math';

class Game {
  final String hiddenCardpath = 'assets/hidden.png';
  List<String>? gameImg;

  final List<String> cards_list = [
    "assets/circle.png",
    "assets/triangle.png",
    "assets/circle.png",
    "assets/heart.png",
    "assets/star.png",
    "assets/triangle.png",
    "assets/star.png",
    "assets/heart.png"
  ];

  List<Map<int, String>> matchCheck = [];

  final int cardCount = 8;

  void initGame() {
    cards_list.shuffle(); // shuffle the cards_list
    gameImg = List.generate(cardCount, (index) => hiddenCardpath);
  }
}
