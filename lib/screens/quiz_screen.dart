import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_quiz_application/Models/aca_option.dart';
import 'package:flutter_quiz_application/Models/aca_question.dart';
import 'package:flutter_quiz_application/constants/Constants.dart';
import 'package:flutter_quiz_application/global/Manager.dart';
import 'package:flutter_quiz_application/screens/home_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class QuizScreen extends StatefulWidget {
  const QuizScreen({super.key});

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  AcaQuestion? selectedQuestion;

  bool endButton = false;
  bool showAnswer = false;
  int correctAnswer = 0;
  Mode mode = Manager.getInstance().mode;
  List<AcaQuestion> questions = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (questions.isEmpty) {
      rootBundle.loadString('lib/constants/aca_questions.json').then((data) {
        List<dynamic> jsonData = json.decode(data);
        List<AcaQuestion> questions =
            jsonData.map((json) => AcaQuestion.fromJson(json)).toList();
        switch (mode) {
          case Mode.favorite:
            questions = questions
                .where((element) =>
                    Manager.getInstance().questionIds.contains(element.index))
                .toList();
            if (questions.isEmpty) {
              Navigator.pop(context);
              showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: Text("提示"),
                      content: Text("现在没有任何收藏的题目"),
                      actions: [
                        TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Text("确定"))
                      ],
                    );
                  });
            }
            break;
          default:
            break;
        }
        if (Manager.getInstance().isRamdom) {
          questions.shuffle();
        }

        setState(() {
          this.questions = questions;
        });
      });
      return Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }
    selectedQuestion = questions[Manager.getInstance().currentIndex];

    String getQuestiosNumber =
        '${Manager.getInstance().currentIndex + 1}/${questions.length}';
    bool isFavorite = Manager.getInstance()
        .questionIds
        .contains(questions[Manager.getInstance().currentIndex].index);
    return Scaffold(
      backgroundColor: welcomeMainBackground,
      body: SafeArea(
        bottom: false,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Align(
                alignment: Alignment.topLeft,
                child: Padding(
                  padding: const EdgeInsets.only(left: 18, top: 18, right: 18),
                  child: Row(
                    children: [
                      InkWell(
                        child: Icon(
                          Icons.cancel_outlined,
                          color: Colors.white,
                          size: 30,
                        ),
                        onTap: () {
                          if (Manager.getInstance().isRamdom)
                            Manager.getInstance().currentIndex = 0;
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => HomeScreen(),
                            ),
                          );
                        },
                      ),
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.only(right: 20),
                          child: GestureDetector(
                            onTap: () {
                              showDialog(
                                  context: context,
                                  builder: (context) {
                                    // 输入跳转的题
                                    TextEditingController _controller =
                                        TextEditingController();
                                    return AlertDialog(
                                      title: Text("跳转"),
                                      content: TextField(
                                        controller: _controller,
                                        decoration: InputDecoration(
                                          labelText: "请输入题号",
                                        ),
                                      ),
                                      actions: [
                                        TextButton(
                                            onPressed: () {
                                              int index =
                                                  int.parse(_controller.text);
                                              if (index > questions.length ||
                                                  index < 1) {
                                                Navigator.pop(context);
                                                showDialog(
                                                    context: context,
                                                    builder: (context) {
                                                      return AlertDialog(
                                                        title: Text("提示"),
                                                        content:
                                                            Text("题号不在范围内"),
                                                        actions: [
                                                          TextButton(
                                                              onPressed: () {
                                                                Navigator.pop(
                                                                    context);
                                                              },
                                                              child: Text("确定"))
                                                        ],
                                                      );
                                                    });
                                                return;
                                              }
                                              Manager.getInstance()
                                                  .currentIndex = index-1;
                                              SharedPreferences.getInstance().then((prefs) {
                                                setState(() {
                                                  prefs.setInt("index",
                                                      Manager.getInstance().currentIndex);
                                                });
                                              });
                                              Navigator.pop(context);
                                            },
                                            child: Text("确定")),
                                        TextButton(
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                            child: Text("取消")),
                                      ],
                                    );
                                  });
                            },
                            child: Text(
                              getQuestiosNumber,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.white.withOpacity(0.4),
                              ),
                            ),
                          ),
                        ),
                      ),
                      InkWell(
                        child: Icon(
                          isFavorite ? Icons.star : Icons.star_border_outlined,
                          color: isFavorite ? Colors.yellow : Colors.white,
                          size: 30,
                        ),
                        onTap: () {
                          var quesionList = Manager.getInstance().questionIds;
                          var currentQuestionIndex =
                              questions[Manager.getInstance().currentIndex]
                                  .index;
                          setState(() {
                            if (quesionList.contains(currentQuestionIndex)) {
                              isFavorite = false;
                              Manager.getInstance().questionIds =
                                  Manager.getInstance()
                                      .questionIds
                                      .where((element) {
                                return element !=
                                    questions[
                                            Manager.getInstance().currentIndex]
                                        .index;
                              }).toList();
                            } else {
                              isFavorite = true;
                              Manager.getInstance().questionIds.add(
                                  questions[Manager.getInstance().currentIndex]
                                          .index ??
                                      0);
                            }
                          });
                        },
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                width: double.infinity,
              ),
              SizedBox(
                height: 10,
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: EdgeInsets.all(10),
                child: Text(
                  "${selectedQuestion?.subject} ${selectedQuestion?.type == "M" ? "(多选)" : "(单选)"}",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              ...List.generate(
                _getOptionsItem(Manager.getInstance().currentIndex).length,
                (index) =>
                    getOptionsItem(Manager.getInstance().currentIndex, index),
              ),
              SizedBox(
                height: 30,
              ),
              Visibility(
                  visible: showAnswer,
                  child: ListTile(
                    title: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Container(
                        padding: EdgeInsets.all(10),
                        width: 100,
                        color: Colors.white,
                        child: Center(
                          child: Text(
                            "正确答案：${questions[Manager.getInstance().currentIndex].answer}\n解析：${(questions[Manager.getInstance().currentIndex].analysis ?? "\n\n") == "\n\n" ? "暂无解析" : questions[Manager.getInstance().currentIndex].analysis ?? ""}"
                                .replaceAll("\n\n", ""),
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: welcomeMainBackground,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  )),
              Visibility(
                visible: endButton,
                child: Padding(
                  padding: EdgeInsets.only(bottom: 30),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Spacer(),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              (Manager.getInstance().currentIndex >=
                                      questions.length - 1)
                                  ? mainButtonBackground
                                  : nextButtonBackground,
                          minimumSize: Size(120, 40.0),
                          elevation: 35,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                        ),
                        onPressed: () {
                          if (Manager.getInstance().currentIndex == 0) {
                            return;
                          }
                          if (Manager.getInstance().currentIndex <
                              questions.length - 1) {
                            setState(() {
                              Manager.getInstance().currentIndex--;
                              SharedPreferences.getInstance().then((prefs) {
                                setState(() {
                                  prefs.setInt("index",
                                      Manager.getInstance().currentIndex);
                                });
                              });
                              showAnswer = false;
                              endButton = false;
                            });

                            return;
                          }
                        },
                        child: Text(
                          "上一题",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ),
                      Spacer(),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              (Manager.getInstance().currentIndex >=
                                      questions.length - 1)
                                  ? mainButtonBackground
                                  : nextButtonBackground,
                          minimumSize: Size(120, 40.0),
                          elevation: 35,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                        ),
                        onPressed: () {
                          if (Manager.getInstance().currentIndex <
                              questions.length - 1) {
                            setState(() {
                              Manager.getInstance().currentIndex++;
                              SharedPreferences.getInstance().then((prefs) {
                                setState(() {
                                  prefs.setInt("index",
                                      Manager.getInstance().currentIndex);
                                });
                              });
                              showAnswer = false;
                              endButton = false;
                            });

                            return;
                          }
                          if (Manager.getInstance().currentIndex >=
                              questions.length - 1) {
                            return;
                          }
                        },
                        child: Text(
                          (Manager.getInstance().currentIndex >=
                                  questions.length - 1)
                              ? "没有了"
                              : "下一题",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ),
                      Spacer(),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<AcaOption> _getOptionsItem(int page) {
    List<dynamic> jsonData = json.decode(this.questions[page].option ?? "");
    List<AcaOption> options =
        jsonData.map((json) => AcaOption.fromJson(json)).toList();
    return options;
  }

  Widget getOptionsItem(int page, int index) {
    return ListTile(
      title: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Container(
          width: 100,
          color: Colors.white,
          child: Center(
            child: Text(
              "${_getOptionsItem(page)[index].name}.${_getOptionsItem(page)[index].item}",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: welcomeMainBackground,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
      onTap: () {
        // if (selectedQuestion!.correctAnswer == index) {
        //   correctAnswer++;
        // } else {
        //   print('false');
        // }

        setState(
          () {
            showAnswer = true;
            endButton = true;
          },
        );
      },
    );
  }
}
