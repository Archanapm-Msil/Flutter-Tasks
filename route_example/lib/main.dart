import 'package:flutter/material.dart';
import 'package:route_example/widgets/custom_route.dart';
import 'package:route_example/widgets/home_screen.dart';
import 'package:route_example/widgets/next_screen.dart';
import 'package:route_example/widgets/other_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      onGenerateRoute: (RouteSettings settings) {
        if (settings.name == '/next') {
          final String text = settings.arguments as String;
          return MaterialPageRoute(
              builder: (context) => NextScreen(text: text));
        }
        if(settings.name == '/custome') {
            return MyCustomPageRoute(builder: (context) => const CustomeRoute());
        }
        return null;
      },
      routes: {
        '/': (context) => const HomeScreen(),
        '/other': (context) => const OtherScreen(),
        'custome': (context) => const CustomeRoute(),
      },
    );
  }
}
