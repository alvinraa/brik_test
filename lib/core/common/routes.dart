import 'package:brik_test/feature/home/presentation/page/groceries_page.dart';
import 'package:brik_test/feature/testing/presentation/page/testing_page.dart';
import 'package:flutter/material.dart';

class Routes {
  static const String testingPage = '/testing';
  static const String homePage = '/';
}

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case Routes.testingPage:
      return MaterialPageRoute(
        builder: (BuildContext context) => const TestingPage(),
        settings: settings,
      );
    case Routes.homePage:
      return MaterialPageRoute(
        builder: (BuildContext context) => const GroceriesPage(),
        settings: settings,
      );
    default:
      return MaterialPageRoute(
        builder: (BuildContext context) => const Scaffold(
          body: Center(
            child: Text('Route not defined'),
          ),
        ),
        settings: settings,
      );
  }
}
