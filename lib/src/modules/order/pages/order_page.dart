import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutterclonethecoffeehouse/src/modules/order/bloc/catalog_state.dart';
import 'package:flutterclonethecoffeehouse/src/modules/order/pages/product_catalog_view.dart';
import 'package:flutterclonethecoffeehouse/src/theme/my_colors.dart';

class CatalogPage extends StatefulWidget {
  final myTabbedPageKey = new GlobalKey<_CatalogPageState>();

  @override
  State<CatalogPage> createState() {
    return _CatalogPageState();
  }
}

class _CatalogPageState extends State<CatalogPage>
    with SingleTickerProviderStateMixin {
  bool loading = true;
  TabController tabController;
  final ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 3, vsync: this, initialIndex: 0);
  }

  @override
  void dispose() {
    super.dispose();
    tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(kToolbarHeight),
          child: Container(
            color: Colors.white,
            child: SafeArea(
              child: TabBar(
                indicatorColor: Theme.of(context).primaryColor,
                labelStyle: Theme.of(context).textTheme.title,
                controller: tabController,
                unselectedLabelStyle: TextStyle(color: MyColors.grey),
                tabs: <Widget>[
                  Tab(
                    child: Text(
                      "Phổ biến",
                      style: Theme.of(context).textTheme.title,
                    ),
                  ),
                  Tab(
                      child: Text("Thức uống",
                          style: Theme.of(context).textTheme.title)),
                  Tab(
                      child: Text("Đồ ăn",
                          style: Theme.of(context).textTheme.title))
                ],
              ),
            ),
          ),
        ),
        body: TabBarView(
          controller: tabController,
          children: <Widget>[
            ProductCategoryScreen(
              tabController: tabController,
              type: CatalogTypes.POPULAR,
            ),
            ProductCategoryScreen(
              tabController: tabController,
              type: CatalogTypes.DRINK,
            ),
            ProductCategoryScreen(
              tabController: tabController,
              type: CatalogTypes.FOOD,
            ),
          ],
        ));
  }
}
