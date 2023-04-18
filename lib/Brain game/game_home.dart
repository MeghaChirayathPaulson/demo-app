import 'package:dementia_app/Brain%20game/level_two.dart';
import 'package:dementia_app/Brain%20game/utils/game_logic.dart';
import 'package:dementia_app/Brain%20game/widgets/score_board.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class GameHome extends StatefulWidget {
  const GameHome({super.key});

  @override
  State<GameHome> createState() => _GameHomeState();
}

class _GameHomeState extends State<GameHome> {
  Game _game = Game();
  int tries = 0;
  int score = 0;
  @override
  void initState() {
    super.initState();
    _game.initGame(1);
  }

  @override
  Widget build(BuildContext context) {
    double screen_width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.deepPurple,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: Text(
              "Memory Game",
              style: TextStyle(
                  fontSize: 48.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
          ),
          SizedBox(
            height: 24.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              scoreBoard("Tries", "${tries}"),
              scoreBoard("Score", "${score}")
            ],
          ),
          SizedBox(
            height: screen_width,
            width: screen_width,
            child: GridView.builder(
                itemCount: _game.gameImg!.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 16.0,
                  mainAxisSpacing: 16.0,
                ),
                padding: EdgeInsets.all(16.0),
                itemBuilder: (context, index) {
                  return GestureDetector(
                      onTap: () {
                        print(_game.cards_list_1[index]);
                        setState(() {
                          _game.gameImg![index] = _game.cards_list_1[index];
                          _game.matchCheck
                              .add({index: _game.cards_list_1[index]});
                          if (_game.matchCheck.length % 2 == 0) {
                            tries++;
                          }
                        });
                        if (_game.matchCheck.length == 2) {
                          if (_game.matchCheck[0].values.first ==
                              _game.matchCheck[1].values.first) {
                            print(true);
                            score += 100;
                            _game.matchCheck.clear();
                          } else {
                            print(false);
                            Future.delayed(Duration(milliseconds: 500), () {
                              print(_game.gameImg);
                              setState(() {
                                _game.gameImg![_game.matchCheck[0].keys.first] =
                                    _game.hiddenCardpath;
                                _game.gameImg![_game.matchCheck[1].keys.first] =
                                    _game.hiddenCardpath;
                                _game.matchCheck.clear();
                              });
                            });
                          }
                        }
                        if (_game.gameImg!.every(
                            (element) => element != _game.hiddenCardpath)) {
                          if (tries <= 6) {
                            // Code to go to the next level
                            showDialog(
                              context: context,
                              builder: (_) => AlertDialog(
                                title: Text("Congratulations!"),
                                content: Text(
                                    "You won this level. Click the button to go to the next level."),
                                actions: [
                                  ElevatedButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (_) => LevelTwo(),
                                          ));
                                    },
                                    child: Text("Next Level"),
                                  ),
                                ],
                              ),
                            );
                          } else {
                            // Code to show game over dialog
                            showDialog(
                              context: context,
                              builder: (_) => AlertDialog(
                                title: Text("Game Over"),
                                content:
                                    Text("Try again to go to the next level"),
                                actions: [
                                  ElevatedButton(
                                    onPressed: () {
                                      setState(() {
                                        tries = 0;
                                        score = 0;
                                        _game.initGame(1);
                                        Navigator.pop(context);
                                      });
                                    },
                                    child: Text("Try Again"),
                                  ),
                                ],
                              ),
                            );
                          }
                        }
                      },
                      child: Container(
                        padding: EdgeInsets.all(16.0),
                        decoration: BoxDecoration(
                            color: Color.fromARGB(255, 225, 119, 38),
                            borderRadius: BorderRadius.circular(8.0),
                            image: DecorationImage(
                              image: AssetImage(_game.gameImg![index]),
                              fit: BoxFit.cover,
                            )),
                      ));
                }),
          ),
        ],
      ),
    );
  }
}
