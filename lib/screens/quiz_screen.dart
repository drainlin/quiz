import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_quiz_application/Models/aca_option.dart';
import 'package:flutter_quiz_application/Models/aca_question.dart';
import 'package:flutter_quiz_application/constants/Constants.dart';
import 'package:flutter_quiz_application/screens/home_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class QuizScreen extends StatefulWidget {
  const QuizScreen({super.key});

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  int showenQuestionIndex = 0;

  AcaQuestion? selectedQuestion;

  bool endButton = false;
  bool showAnswer = false;
  int correctAnswer = 0;

  List<AcaQuestion> questions = [];

  @override
  void initState() {
    super.initState();
    SharedPreferences.getInstance().then((prefs) {
      setState(() {
        showenQuestionIndex = prefs.getInt("index") ?? 0;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    if (questions.isEmpty) {
      rootBundle.loadString('lib/constants/aca_questions.json').then((data) {
        List<dynamic> jsonData = json.decode(data);
        List<AcaQuestion> questions =
            jsonData.map((json) => AcaQuestion.fromJson(json)).toList();
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
    selectedQuestion = questions[showenQuestionIndex];

    String getQuestiosNumber = '${showenQuestionIndex + 1}/${questions.length}';

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
                  padding: const EdgeInsets.only(left: 18, top: 18),
                  child: Row(
                    children: [
                      InkWell(
                        child: Icon(
                          Icons.cancel_outlined,
                          color: Colors.white,
                          size: 30,
                        ),
                        onTap: () {
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
                              setState(() {
                                showenQuestionIndex = 0;
                                SharedPreferences.getInstance().then((prefs) {
                                  prefs.setInt("index", showenQuestionIndex);
                                });
                              });
                            },
                            child: Text(
                              getQuestiosNumber,
                              textAlign: TextAlign.end,
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.white.withOpacity(0.4),
                              ),
                            ),
                          ),
                        ),
                      )
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
                4,
                (index) => getOptionsItem(showenQuestionIndex, index),
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
                            "正确答案：${questions[showenQuestionIndex].answer}\n解析：${questions[showenQuestionIndex].analysis ?? "无"}"
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
                              (showenQuestionIndex >= questions.length - 1)
                                  ? mainButtonBackground
                                  : nextButtonBackground,
                          minimumSize: Size(120, 40.0),
                          elevation: 35,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                        ),
                        onPressed: () {
                          if (showenQuestionIndex == 0) {
                            return;
                          }
                          if (showenQuestionIndex < questions.length - 1) {
                            setState(() {
                              showenQuestionIndex--;
                              SharedPreferences.getInstance().then((prefs) {
                                setState(() {
                                  prefs.setInt("index", showenQuestionIndex);
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
                              (showenQuestionIndex >= questions.length - 1)
                                  ? mainButtonBackground
                                  : nextButtonBackground,
                          minimumSize: Size(120, 40.0),
                          elevation: 35,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                        ),
                        onPressed: () {
                          if (showenQuestionIndex < questions.length - 1) {
                            setState(() {
                              showenQuestionIndex++;
                              SharedPreferences.getInstance().then((prefs) {
                                setState(() {
                                  prefs.setInt("index", showenQuestionIndex);
                                });
                              });
                              showAnswer = false;
                              endButton = false;
                            });

                            return;
                          }
                          if (showenQuestionIndex >= questions.length - 1) {
                            return;
                          }
                        },
                        child: Text(
                          (showenQuestionIndex >= questions.length - 1)
                              ? "结束"
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
              "${_getOptionsItem(page)[index].name} ${_getOptionsItem(page)[index].item}",
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
