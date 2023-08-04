import 'package:flutter/material.dart';
import 'package:first_app/dice_roller.dart';

class GradientContainer extends StatelessWidget {
  const GradientContainer(this.backgroundColor,{super.key});
  final List<Color> backgroundColor;
    
@override
 Widget build(context) {
  return Container(
          decoration:  BoxDecoration(
            gradient: LinearGradient(
              colors: backgroundColor,
              begin: Alignment.topLeft,
              end: Alignment.bottomRight
            ),
          ),
          child: Center(
             child:  Column (
              mainAxisSize: MainAxisSize.min,
              children: [
                // const TextWidget('Welcome,Roll the Dice..!'),  
                _buildText('Welcome,Roll the Dice..!'),
                const DiceRoller(), 
            ],),
          ),
        );
 }

 Text _buildText(String text) {
  return  Text(
              text,
              style: const TextStyle(
              fontSize: 20,
              color: Colors.purpleAccent,
              fontWeight: FontWeight.bold
              ),
              );
}
}
 
