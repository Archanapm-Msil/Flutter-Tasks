import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:star_rating_app/RatingBloc/star_bloc.dart';
import 'package:star_rating_app/screens/star_indicator.dart';
import 'package:star_rating_app/utils/constants.dart';
import 'package:star_rating_app/utils/number_formatter.dart';

class StarProgressIndicator extends StatelessWidget {
  const StarProgressIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text(Constants.titleTxt)),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
              onChanged: (value) {
                final double newRating = double.tryParse(value) ?? 0;
                context
                    .read<StarRatingBloc>()
                    .add(UpdateRatingEvent(newRating));
              },
              inputFormatters: [
                NumberRangeInputFormatter(),
              ],
              decoration: const InputDecoration(
                labelText: Constants.textfieldTxt,
              ),
            ),
            const SizedBox(height: 20),
            BlocBuilder<StarRatingBloc, StarRatingState>(
              builder: (context, state) {
                if (state is StarRatingUpdatedState) {
                  return StarRatingIndicator(
                      rating: state.rating, color: Colors.amberAccent);
                }
                return const CircularProgressIndicator();
              },
            ),
          ],
        ),
      ),
    );
  }
}

