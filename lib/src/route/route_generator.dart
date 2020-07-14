import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterclonethecoffeehouse/src/modules/cart/pages/cart_page.dart';
import 'package:flutterclonethecoffeehouse/src/modules/dashboard/pages/dashboard_page.dart';
import 'package:flutterclonethecoffeehouse/src/modules/home/model/item_card.dart';
import 'package:flutterclonethecoffeehouse/src/modules/home/pages/home_page.dart';
import 'package:flutterclonethecoffeehouse/src/modules/home/pages/info_detail_page.dart';
import 'package:flutterclonethecoffeehouse/src/modules/map/pages/google_map_page.dart';
import 'package:flutterclonethecoffeehouse/src/modules/myprofile/my_profile_page.dart';
import 'package:flutterclonethecoffeehouse/src/modules/order/pages/order_page.dart';
import 'package:flutterclonethecoffeehouse/src/route/route_name.dart';

class RouteGenerator {
  static Route routeAll(RouteSettings settings) {
    switch (settings.name) {
      case RouteName.newsPage:
        return _buildRoute(settings, HomePage());
      case RouteName.dashBoardPage:
        return _buildRoute(settings, DashBoardPage());
      case RouteName.myProfilePage:
        return _buildRoute(settings, MyProfilePage());
      case RouteName.cartPage:
        return _buildRoute(settings, CartPage());
      case RouteName.orderPage:
        return _buildRoute(settings, CatalogPage());
      case RouteName.infoDetailPage:
        ItemCard itemCard;
        if (settings.arguments is ItemCard) {
          itemCard = settings.arguments;
          return _buildRoute(
              settings,
              InfoDetailPage(
                itemCard: itemCard,
              ));
        }
        return _errorRoute();
      case RouteName.googleMapPage:
        return _buildRoute(settings, GoogleMapPage());
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
