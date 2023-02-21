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
    gameImg = List.generate(cardCount, (index) => hiddenCardpath);
  }
}
