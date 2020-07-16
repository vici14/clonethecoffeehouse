import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterclonethecoffeehouse/src/modules/cart/bloc/cart_bloc.dart';
import 'package:flutterclonethecoffeehouse/src/modules/cart/bloc/cart_state.dart';
import 'package:flutterclonethecoffeehouse/src/modules/cart/pages/cart_page.dart';
import 'package:flutterclonethecoffeehouse/src/modules/order/bloc/catalog_bloc.dart';
import 'package:flutterclonethecoffeehouse/src/modules/order/bloc/catalog_state.dart';
import 'package:flutterclonethecoffeehouse/src/theme/my_colors.dart';
import 'package:flutterclonethecoffeehouse/src/widgets/stateful/fancy_fab_filter.dart';
import 'package:flutterclonethecoffeehouse/src/widgets/stateful/product_detail_dialog.dart';

class ProductCategoryScreen extends StatefulWidget {
  final CatalogTypes type;
  final TabController tabController;

  ProductCategoryScreen({this.type, this.tabController});

  @override
  State<ProductCategoryScreen> createState() {
    return _ProductCategoryScreenState(type: type);
  }
}

class _ProductCategoryScreenState extends State<ProductCategoryScreen> {
  CatalogBloc bloc;

  _ProductCategoryScreenState({CatalogTypes type}) {
    bloc = CatalogBloc(type: type);
    bloc.getProducts();
  }

  CartBloc get _cartBloc => BlocProvider.of<CartBloc>(context);

  @override
  Widget build(BuildContext context) {
    final double itemHeight = (MediaQuery.of(context).size.height - kToolbarHeight) / 2 - 10;
    final double itemWidth = MediaQuery.of(context).size.width / 2;

    return SafeArea(
      child: Scaffold(
          floatingActionButton: Padding(
            padding: const EdgeInsets.only(bottom: 35.0),
            child: FancyFABFilter(
              tabController: widget.tabController,
            ),
          ),
          body: Container(
            color: Theme.of(context).disabledColor.withOpacity(0.3),
            child: Stack(children: <Widget>[
              BlocBuilder(
                  bloc: bloc,
                  builder: (BuildContext context, CatalogState state) {
                    if (state.isLoading == true) {
                      return Center(child: CircularProgressIndicator());
                    }
                    return GridView.builder(
                        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                        itemCount: state?.products?.length ?? 0,
                        shrinkWrap: false,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisSpacing: 15, childAspectRatio: (itemWidth / (itemHeight)), crossAxisCount: 2),
                        itemBuilder: (BuildContext context, int index) {
                          var product = state.products[index];
                          return GestureDetector(
                            onTap: () {
                              showGeneralDialog(
                                context: context,
                                barrierDismissible: true,
                                barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
                                barrierColor: Colors.black45,
                                useRootNavigator: true,
                                transitionDuration: const Duration(milliseconds: 200),
                                pageBuilder: (_, Animation animation, Animation secondaryAnimation) {
                                  return BlocProvider<CartBloc>.value(
                                    value: _cartBloc,
                                    child: ProductDetailDialog(
                                      product: product,
                                    ),
                                  );
                                },
                              );
                            },
                            child: Container(
                              height: MediaQuery.of(context).size.height * 0.3,
                              width: 100,
                              decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(8))),
                              child: Column(
                                children: <Widget>[
                                  Container(
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.only(topLeft: Radius.circular(8), topRight: Radius.circular(8)),
                                      child: Image.network(
                                        product.imgUrl,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    height: 250,
//
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                        border: Border.all(color: Colors.grey.withOpacity(0.2)),
                                        borderRadius: BorderRadius.only(bottomLeft: Radius.circular(8), bottomRight: Radius.circular(8)),
                                        color: Colors.white),
                                    height: MediaQuery.of(context).size.height * 0.1 + 4,
                                    width: double.infinity,
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Padding(
                                          padding: const EdgeInsets.only(left: 8.0, top: 5, bottom: 10),
                                          child: Text(
                                            product.name,
                                            textAlign: TextAlign.left,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                                          ),
                                        ),
                                        Container(
                                          height: 54,
                                          decoration: BoxDecoration(border: Border(top: BorderSide(color: Colors.grey.withOpacity(0.2)))),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: <Widget>[
                                              Padding(
                                                padding: const EdgeInsets.all(8.0),
                                                child: Text(
                                                  product.priceValue,
                                                  style: TextStyle(fontWeight: FontWeight.w600),
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.all(8.0),
                                                child: Icon(
                                                  Icons.add_circle_outline,
                                                  color: MyColors.yellowOrange,
                                                ),
                                              )
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          );
                        });
                  }),
              BlocBuilder(
                bloc: _cartBloc,
                builder: (context, CartState state) {
                  if (_cartBloc.state.cart.listCartItem.length == 0) {
                    Container();
                  }
                  return Align(
                    alignment: Alignment.bottomCenter,
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => CartPage(),
                          ),
                        );
                      },
                      child: Container(
                        width: double.infinity,
                        height: 50,
                        color: Theme.of(context).primaryColor,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Container(
                              width: 30,
                              height: 30,
                              decoration: BoxDecoration(border: Border.all(color: Colors.white)),
                              child: Center(
                                  child: Text(
                                "${_cartBloc.state.totalQuantity}",
                                style: TextStyle(color: Colors.white),
                              )),
                            ),
                            Text(
                              "Xem giỏ hàng",
                              style: TextStyle(color: Colors.white),
                            ),
                            Text(
                              '${_cartBloc.state.totalCost} đ',
                              style: TextStyle(color: Colors.white),
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ]),
          )),
    );
  }
}
