import 'package:flutter/material.dart';
import 'package:route_example/utils/constants.dart';
import 'package:route_example/utils/navigation_service.dart';
import 'package:route_example/widgets/next_screen.dart';
import 'package:route_example/widgets/other_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text(Constants.titleText)),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                NavigationService.navigateToMaterialRoute(
                    context,
                    (context) => const NextScreen(
                          text: 'the text from home screen',
                        ));
              },
              child: const Text(Constants.materialRouteText),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                NavigationService.navigateToCupertinoRoute(
                    context, (context) => const OtherScreen());
              },
              child: const Text(Constants.cupertinoPageRouteText),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                NavigationService.navigateToNamedRoute(context, '/next',
                    arguments: 'data from previous screen');
              },
              child: const Text(Constants.namedRouteText),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                NavigationService.navigateToNamedRoute(context, '/custome',
                    arguments: 'data from previous screen');
              },
              child: const Text('Custome Route'),
            ),
          ],
        ),
      ),
    );
  }
}
