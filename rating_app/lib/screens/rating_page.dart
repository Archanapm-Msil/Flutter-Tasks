import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rating_app/blocs/rating_bloc.dart';
import 'package:rating_app/events/rating_events.dart';
import 'package:rating_app/screens/rating_star.dart';
import 'package:rating_app/states/rating_state.dart';
import 'package:rating_app/utils/constants.dart';

class RatingPage extends StatefulWidget {
  const RatingPage({Key? key}) : super(key: key);
  @override
  RatingPageState createState() => RatingPageState();
}

class RatingPageState extends State<RatingPage> {
  final TextEditingController _ratingController = TextEditingController();

  @override
  void dispose() {
    _ratingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          Constants.titleTxt,
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.grey,
      ),
      body: BlocBuilder<RatingBloc, RatingState>(
        builder: (context, state) {
          double rating = 0.0;
          if (state is RatingAdded) {
            rating = state.rating;
          }
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  Constants.rateTxt,
                  style: TextStyle(fontWeight: FontWeight.w700),
                  textAlign: TextAlign.center,
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: SizedBox(width: 200, child: _buildTextFiled()),
                ),
                RatingStar(rating: rating, size: 40),
              ],
            ),
          );
        },
      ),
    );
  }

  TextField _buildTextFiled() {
    return TextField(
      onChanged: (value) {
        double ratingGiven = double.tryParse(value) ?? 0.0;
        BlocProvider.of<RatingBloc>(context).add(AddRating(ratingGiven));
      },
      inputFormatters: [
        FilteringTextInputFormatter.allow(RegExp(r'^([1-5]?(\.\d{0,1})?)$')),
      ],
      decoration: const InputDecoration(
        labelText: Constants.textfieldTxt,
      ),
    );
  }
}
