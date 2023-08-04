import 'package:flutter/material.dart';
class LaunchScreen extends StatelessWidget {
const LaunchScreen(this.startrQuiz,{super.key});
  final void Function() startrQuiz;
  @override
  Widget build(BuildContext context) {
   return Container(
        color: Colors.deepPurple,
        child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset('assets/images/quiz-logo.png',width: 200, color: const Color.fromARGB(104, 238, 237, 237),),
                 const Padding(
                   padding: EdgeInsets.only(top: 50),
                   child: Text(
                        'Learn Flutter the fun way!',
                        style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,      
                        ),
                   ),
                 ),
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: OutlinedButton.icon(onPressed: startrQuiz,
                style: OutlinedButton.styleFrom(
                backgroundColor: Colors.deepPurple, foregroundColor: Colors.white),
                icon: const Icon(Icons.arrow_right_alt),
                 label: const Text('Start Quiz', selectionColor: Colors.white,),
                 ),
              )],
            ),
        ),
   );
   
  }
}