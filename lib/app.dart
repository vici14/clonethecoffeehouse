import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterclonethecoffeehouse/src/modules/dashboard/bloc/dashboard_bloc.dart';
import 'package:flutterclonethecoffeehouse/src/modules/dashboard/bloc/dashboard_state.dart';
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
  final _dashBoardBloc = DashBoardBloc(DashBoardTypes.ACCOUNT);

  _MyAppState() {
//    _dashBoardBloc.
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeApp.kLightTheme,
        onGenerateRoute: RouteGenerator.routeAll,
        navigatorKey: MyApp.navigatorKey,
        debugShowCheckedModeBanner: false,
        home: BlocProvider<DashBoardBloc>(
          create: (context) => _dashBoardBloc,
          child: DevPage(),
        ));
  }
}
