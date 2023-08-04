import 'package:flutter/material.dart';
import 'package:quiz_app/data/questions.dart';
import 'package:quiz_app/lauch_screen.dart';
import 'package:quiz_app/questions-screen.dart';
import 'package:quiz_app/result-screen.dart';

class Quiz extends StatefulWidget {
  const Quiz({super.key});
  @override
  State<Quiz> createState() {
    return _QuizState();
  }
}

class _QuizState extends State<Quiz> {
  List<String> selectedAnswer = [];

  var currentScreen = 'launch-screen';
  // void initState() {
  // currentScreen =  LaunchScreen(navigateScreen);
  // super.initState();
  // }

  void chooseAnswer(String answer) {
    selectedAnswer.add(answer);
    if (selectedAnswer.length == questions.length) {
      setState(() {
        currentScreen = 'result-screen';
      });
    }
  }

  void navigateScreen() {
    setState(() {
      currentScreen = 'questions-screen';
    });
  }

  void navigateToHome() {
    setState(() {
      selectedAnswer = [];
      currentScreen = 'launch-screen';
    });
  }

  @override
  Widget build(context) {
    Widget screenWidget = LaunchScreen(navigateScreen);

    if (currentScreen == 'launch-screen') {
      screenWidget = LaunchScreen(navigateScreen);
    }
    if (currentScreen == 'questions-screen') {
      screenWidget = QuestionScreen(onSelected: chooseAnswer);
    }

    if (currentScreen == 'result-screen') {
      screenWidget = ResultScreen(
        chosenAnswers: selectedAnswer,
        onSelected: navigateToHome,
      );
    }
    return MaterialApp(
      home: Scaffold(
        body: Container(
          decoration: const BoxDecoration(color: Colors.deepPurple),
          child: screenWidget,
        ),
      ),
    );
  }
}
