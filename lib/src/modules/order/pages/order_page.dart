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
//  CatalogBloc catalogBloc;
//  ProductsRepository productsRepository = FirebaseProductRepository();

  _CatalogPageState() {
//    catalogBloc = CatalogBloc(productsRepository: productsRepository);
//
//    catalogBloc.getProducts();
//    catalogBloc.getDrinksProduct();
//    catalogBloc.listen((_state) {});
  }

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

//  Widget _buildTabPopular(BuildContext context) {
//    final double itemHeight =
//        (MediaQuery.of(context).size.height - kToolbarHeight) / 2 - 10;
//    final double itemWidth = MediaQuery.of(context).size.width / 2;
//    return Container(
//      color: Theme.of(context).disabledColor.withOpacity(0.3),
//      child: BlocBuilder(
//          bloc: catalogBloc,
//          builder: (BuildContext context, state) {
//            if (state.isLoading == true) {
//              return Center(child: CircularProgressIndicator());
//            }
//            return GridView.builder(
//                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
//                itemCount: state?.products?.length ?? 0,
//                shrinkWrap: false,
//                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                    crossAxisSpacing: 15,
//                    childAspectRatio: (itemWidth / itemHeight),
//                    crossAxisCount: 2),
//                itemBuilder: (BuildContext context, int index) {
//                  var product = state.products[index];
//                  print("AAA${product.name}");
//                  return GestureDetector(
//                    onTap: () {
//                      showGeneralDialog(
//                          context: context,
//                          barrierDismissible: true,
//                          barrierLabel: MaterialLocalizations.of(context)
//                              .modalBarrierDismissLabel,
//                          barrierColor: Colors.black45,
//                          transitionDuration: const Duration(milliseconds: 200),
//                          pageBuilder: (_, Animation animation,
//                              Animation secondaryAnimation) {
//                            return ProductDetailDialog(
//                              product: product,
//                            );
//                          });
//                    },
//                    child: Container(
//                      height: 303,
//                      width: 100,
//                      decoration: BoxDecoration(
//                          borderRadius: BorderRadius.all(Radius.circular(8))),
//                      child: Column(
//                        children: <Widget>[
//                          Container(
//                            child: ClipRRect(
//                              borderRadius: BorderRadius.only(
//                                  topLeft: Radius.circular(8),
//                                  topRight: Radius.circular(8)),
//                              child: Image.network(
//                                product.imgUrl,
//                                fit: BoxFit.cover,
//                              ),
//                            ),
//                            height: 250,
////
//                          ),
//                          Container(
//                            decoration: BoxDecoration(
//                                border: Border.all(
//                                    color: Colors.grey.withOpacity(0.2)),
//                                borderRadius: BorderRadius.only(
//                                    bottomLeft: Radius.circular(8),
//                                    bottomRight: Radius.circular(8)),
//                                color: Colors.white),
//                            height: 100,
//                            width: double.infinity,
//                            child: Column(
//                              crossAxisAlignment: CrossAxisAlignment.start,
//                              children: <Widget>[
//                                Padding(
//                                  padding: const EdgeInsets.only(
//                                      left: 8.0, top: 5, bottom: 10),
//                                  child: Text(
//                                    product.name,
//                                    textAlign: TextAlign.left,
//                                    overflow: TextOverflow.ellipsis,
//                                    style: TextStyle(
//                                        fontSize: 16,
//                                        fontWeight: FontWeight.w600),
//                                  ),
//                                ),
//                                Container(
//                                  height: 54,
//                                  decoration: BoxDecoration(
//                                      border: Border(
//                                          top: BorderSide(
//                                              color: Colors.grey
//                                                  .withOpacity(0.2)))),
//                                  child: Row(
//                                    mainAxisAlignment:
//                                        MainAxisAlignment.spaceBetween,
//                                    children: <Widget>[
//                                      Padding(
//                                        padding: const EdgeInsets.all(8.0),
//                                        child: Text(
//                                          product.cost.toString(),
//                                          style: TextStyle(
//                                              fontWeight: FontWeight.w600),
//                                        ),
//                                      ),
//                                      Padding(
//                                        padding: const EdgeInsets.all(8.0),
//                                        child: Icon(
//                                          Icons.add_circle_outline,
//                                          color: MyColors.yellowOrange,
//                                        ),
//                                      )
//                                    ],
//                                  ),
//                                )
//                              ],
//                            ),
//                          )
//                        ],
//                      ),
//                    ),
//                  );
//                });
//          }),
//    );
//  }
}
