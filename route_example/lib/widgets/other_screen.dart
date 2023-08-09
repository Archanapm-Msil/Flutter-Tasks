import 'package:flutter/material.dart';
import 'package:route_example/utils/constants.dart';
import 'package:route_example/utils/navigation_service.dart';
import 'package:route_example/widgets/custom_route.dart';

class OtherScreen extends StatelessWidget {
  const OtherScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Other Screen')),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            NavigationService.navigateToCupertinoRoute(
                context, (context) => const CustomeRoute());
          },
          child: const Text(Constants.gotoCustom),
        ),
      ),
    );
  }
}
