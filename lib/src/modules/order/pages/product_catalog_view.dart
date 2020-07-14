import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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

  @override
  Widget build(BuildContext context) {
    final double itemHeight =
        (MediaQuery.of(context).size.height - kToolbarHeight) / 2 - 10;
    final double itemWidth = MediaQuery.of(context).size.width / 2;
    return Scaffold(
      floatingActionButton: FancyFABFilter(
        tabController: widget.tabController,
      ),
      body: Container(
        color: Theme.of(context).disabledColor.withOpacity(0.3),
        child: BlocBuilder(
            bloc: bloc,
            builder: (BuildContext context, CatalogState state) {
              if (state.isLoading == true) {
                return Center(child: CircularProgressIndicator());
              }
              return GridView.builder(
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                  itemCount: state?.products?.length ?? 0,
                  shrinkWrap: false,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisSpacing: 15,
                      childAspectRatio: (itemWidth / itemHeight),
                      crossAxisCount: 2),
                  itemBuilder: (BuildContext context, int index) {
                    var product = state.products[index];
                    return GestureDetector(
                      onTap: () {
                        showGeneralDialog(
                            context: context,
                            barrierDismissible: true,
                            barrierLabel: MaterialLocalizations.of(context)
                                .modalBarrierDismissLabel,
                            barrierColor: Colors.black45,
                            transitionDuration:
                                const Duration(milliseconds: 200),
                            pageBuilder: (_, Animation animation,
                                Animation secondaryAnimation) {
                              return ProductDetailDialog(
                                product: product,
                              );
                            });
                      },
                      child: Container(
                        height: 303,
                        width: 100,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(8))),
                        child: Column(
                          children: <Widget>[
                            Container(
                              child: ClipRRect(
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(8),
                                    topRight: Radius.circular(8)),
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
                                  border: Border.all(
                                      color: Colors.grey.withOpacity(0.2)),
                                  borderRadius: BorderRadius.only(
                                      bottomLeft: Radius.circular(8),
                                      bottomRight: Radius.circular(8)),
                                  color: Colors.white),
                              height: 100,
                              width: double.infinity,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 8.0, top: 5, bottom: 10),
                                    child: Text(
                                      product.name,
                                      textAlign: TextAlign.left,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ),
                                  Container(
                                    height: 54,
                                    decoration: BoxDecoration(
                                        border: Border(
                                            top: BorderSide(
                                                color: Colors.grey
                                                    .withOpacity(0.2)))),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(
                                            product.priceValue,
                                            style: TextStyle(
                                                fontWeight: FontWeight.w600),
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
      ),
    );
  }
}
