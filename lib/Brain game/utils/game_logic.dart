import 'dart:math';

class Game {
  final String hiddenCardpath = 'assets/hidden.png';
  List<String>? gameImg;

  List<String> cards_list_1 = [
    "assets/circle.png",
    "assets/triangle.png",
    "assets/circle.png",
    "assets/heart.png",
    "assets/star.png",
    "assets/triangle.png",
    "assets/star.png",
    "assets/heart.png"
  ];

  List<String> cards_list_2 = [
    "assets/circle.png",
    "assets/triangle.png",
    "assets/circle.png",
    "assets/heart.png",
    "assets/star.png",
    "assets/triangle.png",
    "assets/star.png",
    "assets/heart.png",
    "assets/cylinder.png",
    "assets/elipse.png",
    "assets/rectangle.png",
    "assets/cylinder.png",
    "assets/rectangle.png",
    "assets/rhombus.png",
    "assets/elipse.png",
    "assets/rhombus.png",
  ];

  List<Map<int, String>> matchCheck = [];

  int cardCount = 0;

  void initGame(int level) {
    if (level == 1) {
      cards_list_1.shuffle(); // shuffle the cards_list_1
      cardCount = 8;
      gameImg = List.generate(cardCount, (index) => hiddenCardpath);
    } else if (level == 2) {
      cards_list_2.shuffle(); // shuffle the cards_list_2
      cardCount = 16;
      gameImg = List.generate(cardCount, (index) => hiddenCardpath);
    }
  }
}
