import 'package:flutter/material.dart';
import 'package:flutterclonethecoffeehouse/src/route/route_name.dart';
import 'package:flutterclonethecoffeehouse/src/theme/my_colors.dart';
import 'package:flutterclonethecoffeehouse/src/widgets/stateless/accent_raised_button.dart';

class DevPage extends StatefulWidget {
  @override
  State<DevPage> createState() {
    return _DevPageState();
  }
}

class _DevPageState extends State<DevPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('DEV MODE'),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(vertical: 8),
        children: <Widget>[
          ItemDevPage(
            title: 'News Page',
            routeName: RouteName.newsPage,
          ),
          ItemDevPage(
            title: 'My Profile Page',
            routeName: RouteName.myProfilePage,
          ),
          ItemDevPage(
            title: 'Order Page',
            routeName: RouteName.orderPage,
          ),
          ItemDevPage(
            title: 'Dashboard Page',
            routeName: RouteName.dashBoardPage,
          ),
          ItemDevPage(
            title: 'GoogleMap Page',
            routeName: RouteName.googleMapPage,
          ),
          ItemDevPage(
            title: 'Cart Page',
            routeName: RouteName.cartPage,
          )
        ],
      ),
    );
  }
}

class ItemDevPage extends StatelessWidget {
  final String routeName;
  final String title;

  const ItemDevPage({Key key, @required this.routeName, @required this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: AccentRaisedButton(
        color: MyColors.yellowOrange,
        onPressed: () => Navigator.pushNamed(context, routeName),
        child: Text(
          title,
        ),
      ),
    );
  }
}
