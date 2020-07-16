import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterclonethecoffeehouse/src/modules/cart/bloc/cart_bloc.dart';
import 'package:flutterclonethecoffeehouse/src/modules/dashboard/bloc/dashboard_bloc.dart';
import 'package:flutterclonethecoffeehouse/src/modules/dashboard/pages/dashboard_page.dart';
import 'package:flutterclonethecoffeehouse/src/route/route_generator.dart';
import 'package:flutterclonethecoffeehouse/src/theme/theme_app.dart';

class MyApp extends StatefulWidget {
  static final GlobalKey<NavigatorState> navigatorKey = GlobalKey();

  const MyApp({Key key}) : super(key: key);

  @override
  State<MyApp> createState() {
    return _MyAppState();
  }
}

class _MyAppState extends State<MyApp> {
  final _dashBoardBloc = DashBoardBloc();
  final _cartBloc = CartBloc();

  @override
  void dispose() {
    super.dispose();
//    _cartBloc?.drain();
    _dashBoardBloc?.drain();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeApp.kLightTheme,
      onGenerateRoute: RouteGenerator.routeAll,
      navigatorKey: MyApp.navigatorKey,
      debugShowCheckedModeBanner: false,
      home: MultiBlocProvider(
        providers: [
          BlocProvider<DashBoardBloc>(
            create: (context) => _dashBoardBloc,
          ),
          BlocProvider<CartBloc>(
            create: (context) => _cartBloc,
          )
        ],
        child: DashBoardPage(),
      ),
    );
  }
}
