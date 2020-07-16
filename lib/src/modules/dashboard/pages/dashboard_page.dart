import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterclonethecoffeehouse/src/modules/dashboard/bloc/dashboard_bloc.dart';
import 'package:flutterclonethecoffeehouse/src/modules/dashboard/bloc/dashboard_state.dart';
import 'package:flutterclonethecoffeehouse/src/modules/home/pages/home_page.dart';
import 'package:flutterclonethecoffeehouse/src/modules/map/pages/google_map_page.dart';
import 'package:flutterclonethecoffeehouse/src/modules/myprofile/my_profile_page.dart';
import 'package:flutterclonethecoffeehouse/src/modules/order/pages/order_page.dart';
import 'package:flutterclonethecoffeehouse/src/utils/uidata.dart';

class DashBoardPage extends StatefulWidget {
  @override
  State<DashBoardPage> createState() {
    return _DashBoardPageState();
  }
}

class _DashBoardPageState extends State<DashBoardPage> {
  int oldTab = 0;
  CupertinoTabController _tabController;
  List<Widget> listTab;

  @override
  void initState() {
    super.initState();
    _tabController = CupertinoTabController();
    listTab = [
      CupertinoTabView(
        builder: (BuildContext context) {
          return HomePage();
        },
      ),
      CupertinoTabView(
        builder: (BuildContext context) {
          return CatalogPage();
        },
      ),
      CupertinoTabView(
        builder: (BuildContext context) {
          return GoogleMapPage();
        },
      ),
      CupertinoTabView(
        builder: (BuildContext context) {
          return MyProfilePage();
        },
      )
    ];
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
      bloc: BlocProvider.of<DashBoardBloc>(context),
      builder: (BuildContext context, DashBoardState state) {
        if (state.isLoading == true) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        if (state.currentIndex != null && state.currentIndex < listTab.length) _tabController.index = state.currentIndex;
        return CupertinoTabScaffold(
          resizeToAvoidBottomInset: true,
          controller: _tabController,
          tabBuilder: (BuildContext context, int index) {
            return listTab[_tabController.index];
          },
          tabBar: _buildBottomBar(),
        );
      },
    );
  }

  Widget _buildBottomBar() {
    return CupertinoTabBar(
      onTap: onTabTap,
      backgroundColor: Theme.of(context).canvasColor,
      items: <BottomNavigationBarItem>[
        _buildBottomBarItem(UIData.icNews, "Tin tức"),
        _buildBottomBarItem(UIData.icDelivery, "Đặt hàng"),
        _buildBottomBarItem(UIData.icShop, "Cửa hàng"),
        _buildBottomBarItem(UIData.icAccount, "Tài khoản")
      ],
    );
  }

  BottomNavigationBarItem _buildBottomBarItem(String image, String title) {
    return BottomNavigationBarItem(
        icon: Padding(
          padding: const EdgeInsets.only(top: 5.0),
          child: Image.asset(
            image,
            width: 30,
            height: 30,
          ),
        ),
        title: Text(
          title,
          style: TextStyle(fontSize: 14),
        ),
        activeIcon: Image.asset(
          image,
          height: 40,
          width: 40,
          color: Theme.of(context).primaryColor,
        ));
  }

  void onTabTap(int index) {
    oldTab = index;
    switch (index) {
      case 0:
        if (index != oldTab) {
          break;
        }
        break;
      case 1:
        if (index != oldTab) {
          break;
        }
        break;
      case 2:
        if (index != oldTab) {
          break;
        }
        break;
      case 3:
        if (index != oldTab) {
          break;
        }
        break;
    }
  }
}
