import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterclonethecoffeehouse/src/modules/dashboard/pages/news_page.dart';
import 'package:flutterclonethecoffeehouse/src/modules/myprofile/my_profile_page.dart';
import 'package:flutterclonethecoffeehouse/src/modules/order/pages/order_page.dart';
import 'package:flutterclonethecoffeehouse/src/route/route_name.dart';

class RouteGenerator {
  static Route routeAll(RouteSettings settings) {
    switch (settings.name) {
      case RouteName.newsPage:
        return _buildRoute(settings, NewsPage());
      case RouteName.myProfilePage:
        return _buildRoute(settings, MyProfilePage());
      case RouteName.orderPage:
        return _buildRoute(settings, CatalogPage());
      default:
        return _errorRoute();
    }
  }

  static Route _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Coming soon'),
        ),
        body: const Center(
          child: Text("Page not found"),
        ),
      );
    });
  }

  static Route generalRoute(RouteSettings settings) {
    return routeAll(settings);
  }

  static MaterialPageRoute _buildRoute(RouteSettings settings, Widget builder) {
    return MaterialPageRoute(
      settings: settings,
      builder: (BuildContext context) => builder,
    );
  }
}
