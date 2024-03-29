import 'package:flutter/material.dart';
import 'package:flutter_quiz_application/constants/Constants.dart';
import 'package:flutter_quiz_application/global/Manager.dart';
import 'package:flutter_quiz_application/screens/quiz_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: welcomeMainBackground,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: const EdgeInsets.all(18.0),
                child: SizedBox(
                  width: 30,
                  height: 30,
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Image(
                image: AssetImage('images/airbollon.png'),
              ),
            ),
            SizedBox(
              height: 50,
            ),
            Padding(
              padding: const EdgeInsets.only(right: 30, bottom: 10),
              child: Align(
                alignment: Alignment.topRight,
                child: Container(
                  child: Text(
                    "阿里云",
                    textAlign: TextAlign.end,
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 30,
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 30, left: 25),
              child: Align(
                alignment: Alignment.topRight,
                child: Container(
                  child: Text(
                    "阿里云ACA云计算助理工程师",
                    textAlign: TextAlign.end,
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 50,
            ),
            RandomCheckBox(),
            SizedBox(
              height: 20,
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                minimumSize: Size(300, 40.0),
                elevation: 35,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
              onPressed: () {
                Manager.getInstance().mode = Mode.normol;
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => QuizScreen(),
                  ),
                );
              },
              child: Text(
                '开始练习',
                style: TextStyle(
                  color: welcomeMainBackground,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                minimumSize: Size(300, 40.0),
                elevation: 35,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
              onPressed: () {
                Manager.getInstance().mode = Mode.favorite;
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => QuizScreen(),
                  ),
                );
              },
              child: Text(
                '重做收藏',
                style: TextStyle(
                  color: welcomeMainBackground,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class RandomCheckBox extends StatefulWidget {
  const RandomCheckBox({super.key});

  @override
  State<RandomCheckBox> createState() => _RandomCheckBoxState();
}

class _RandomCheckBoxState extends State<RandomCheckBox> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Checkbox(
          value: Manager.getInstance().isRamdom,
          checkColor: Colors.white,
          onChanged: (bool? value) {
            setState(() {
              Manager.getInstance().isRamdom = value!;
            });
          },
        ),
        Text(
          "乱序练习",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ],
    );
  }
}
