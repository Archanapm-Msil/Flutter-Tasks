import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class NavigationService {
  static void navigateToMaterialRoute(BuildContext context, WidgetBuilder builder) {
    Navigator.push(context, MaterialPageRoute(builder: builder));
  }

  static void navigateToCupertinoRoute(BuildContext context, WidgetBuilder builder) {
    Navigator.push(context, CupertinoPageRoute(builder: builder));
  }

  static void navigateToNamedRoute(BuildContext context, String routeName, {Object? arguments}) {
    Navigator.pushNamed(context, routeName,arguments: arguments );
  }
}