import 'package:flutter/material.dart';
import 'package:quiz_app/data/questions.dart';
import 'package:google_fonts/google_fonts.dart';

class QuestionScreen extends StatefulWidget {
  const QuestionScreen({required this.onSelected, super.key});
  final void Function(String answer) onSelected;
@override
State<QuestionScreen> createState() {
   return _QuestionsState();  
  }
}

class _QuestionsState extends State<QuestionScreen> {
  var currentIndex = 0;

void answerQuestion(String answer) {
  widget.onSelected(answer);
  setState(() {
      currentIndex += 1;
  });
}

@override
Widget build(context){
  final currentQuestion = questions[currentIndex];
  return  SizedBox(
        width: double.infinity,
          child:  Container(
            margin: const EdgeInsets.all(60),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
               Text(currentQuestion.text, 
               style:
                const TextStyle(color: Colors.white,),
                textAlign: TextAlign.center,
                ),
              const SizedBox(height: 30,),
              ...currentQuestion.answers.map((answer) {
                return _buildElevatedButton(answer);
              })         
             ],
            ),
          ),
      );
}

ElevatedButton _buildElevatedButton(String buttonText) {
  return ElevatedButton(onPressed: () {
    answerQuestion(buttonText);
  },
  style: ElevatedButton.styleFrom(
    padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 40),
    backgroundColor: const Color.fromARGB(255, 33, 1, 95),
    foregroundColor: Colors.white,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40))
  ), 
  child: Text(
    buttonText, 
    textAlign: TextAlign.center));
}

}


