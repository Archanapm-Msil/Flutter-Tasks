import 'package:flutter/material.dart';
import 'dart:math';

class DiceRoller extends StatefulWidget {
 const DiceRoller({super.key});
@override
State<DiceRoller> createState() {
    return _BuildDiceRoller() ;
  }

}
class _BuildDiceRoller extends State<DiceRoller> {
  var activeImage = 'assets/images/dice-2.png';
   void rollDice() {
    var diceFaceNum = Random().nextInt(6) + 1;
    setState(() {
          activeImage = 'assets/images/dice-$diceFaceNum.png';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
          mainAxisSize: MainAxisSize.min,
                children:[ 
                  Image.asset(activeImage, width: 130,height: 130,),
                  const SizedBox(height: 20,),
                  TextButton(onPressed: rollDice, style: TextButton.styleFrom(
                    padding: const EdgeInsets.only(top: 30)
                  ), child: const Text(
                    'Roll Dice',
                    style:  TextStyle(
                      fontSize: 20,
                      color: Colors.indigo,
                      fontWeight: FontWeight.bold
                    ),
                    
                  ))
            ]);
  }

}


