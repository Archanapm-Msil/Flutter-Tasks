import 'dart:ffi';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:quiz_app/data/questions.dart';
import 'package:quiz_app/lauch_screen.dart';
import 'package:quiz_app/questions-screen.dart';
import 'package:quiz_app/quiz.dart';

class ResultScreen  extends StatelessWidget {
  const ResultScreen({super.key, required this.chosenAnswers, required this.onSelected});

final List<String> chosenAnswers;
final void Function() onSelected;

List<Map<String,Object>> getData() {
final List<Map<String,Object>> data = [];
for(var i = 0; i < chosenAnswers.length; i++) {
  data.add({
    'question_index' : i,
    'question' : questions[i].text,
    'correct_answer' : questions[i].answers[0],
    'chosen_answer': chosenAnswers[i]
  });
}
return data;
}

  @override
  Widget build(BuildContext context) {
     List<Map<String,Object>> finalData = getData();
     final totalCount = questions.length;
    final correctAnswerCount = finalData.where((data) {
      return data['chosen_answer'] == data['correct_answer'];
    }).length ;

    // final indexColor = finalData.where((data) {
    //   if(data[])
    // })

     Color indexColor = Colors.white;

    return SizedBox(
        width: double.infinity,
          child:  Container(
            margin: const EdgeInsets.all(30),
            child:  Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children:  [
                  Text( 'You answered $correctAnswerCount out of $totalCount questions correctly..!', 
                  style: const TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w500,),textAlign: TextAlign.center,),
                 const SizedBox(height:  20),
                 _questionSummary(finalData),
                 const  SizedBox(height:  50,),
                  TextButton(onPressed: onSelected, child: const Text(
                    'Restart Quiz',
                  ),
                  ),
              ],
            ),
          ),
          );
  }
   
 SizedBox _questionSummary(List<Map<String, Object>> data) {
  Color getBackgroundColor(Map<String, Object> result) {
    if (result['chosen_answer'] == result['correct_answer']) {
      return Colors.blueAccent;
    } else {
      return Colors.purpleAccent;
    }
  }

  return SizedBox(
    height: 300,
    child: SingleChildScrollView(
      child: Column(
        children: data.map(
          (result) {
            return Row(
              children: [
                Container(
                  height: 30,
                  width: 30,
                  margin: const EdgeInsets.all(20.0),
                  decoration: BoxDecoration(
                    color: getBackgroundColor(result),
                    shape: BoxShape.circle,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: Text(
                      ((result['question_index'] as int) + 1).toString(),
                      textAlign: TextAlign.center,
                      style: const TextStyle(),
                    ),
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        result['question'].toString(),
                        style: const TextStyle(
                          color: Colors.white,
                        ),
                        textAlign: TextAlign.left,
                      ),
                      const SizedBox(height: 5,),
                      Text(
                        result['chosen_answer'].toString(),
                        style: const TextStyle(
                          color: Colors.purpleAccent,
                        ),
                        textAlign: TextAlign.left,
                      ),
                      Text(
                        result['correct_answer'].toString(),
                        style: const TextStyle(
                          color: Colors.lightBlue,
                        ),
                      ),
                      const SizedBox(height: 20,)
                    ],
                  ),
                )
              ],
            );
          },
        ).toList(),
      ),
    ),
  );
}
}

