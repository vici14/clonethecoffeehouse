import 'package:flutter/material.dart';
import 'package:flutterclonethecoffeehouse/src/route/route_generator.dart';
import 'package:flutterclonethecoffeehouse/src/theme/theme_app.dart';

import 'dev_page.dart';

class MyApp extends StatefulWidget {
  static final GlobalKey<NavigatorState> navigatorKey = GlobalKey();
  @override
  State<MyApp> createState() {
    return _MyAppState();
  }
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeApp.kLightTheme,
      onGenerateRoute: RouteGenerator.routeAll,
      navigatorKey: MyApp.navigatorKey,
      debugShowCheckedModeBanner: false,
      home: DevPage(),
    );
  }
}
