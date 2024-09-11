import 'package:brik_test/core/common/helper.dart';
import 'package:brik_test/core/common/navigation.dart';
import 'package:brik_test/core/common/routes.dart';
import 'package:brik_test/core/theme/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  ThemeType themeType = ThemeType.light;

  @override
  Widget build(BuildContext context) {
    // layout potrait only
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    return MaterialApp(
      navigatorKey: navigatorKey,
      debugShowCheckedModeBanner: false,
      theme: Styles.appTheme(context, themeType),
      builder: (context, child) {
        return MediaQuery(
          data: MediaQuery.of(context)
              .copyWith(textScaler: const TextScaler.linear(1.0)),
          child: GestureDetector(
              onTap: () {
                Helper.hideKeyboard(context);
              },
              child: child!),
        );
      },
      // routes: appRoutes,
      onGenerateRoute: generateRoute,
    );
  }
}
