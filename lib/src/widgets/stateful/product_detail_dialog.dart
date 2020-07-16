import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterclonethecoffeehouse/src/bloc/product_detail/product_detail_bloc.dart';
import 'package:flutterclonethecoffeehouse/src/bloc/product_detail/product_detail_state.dart';
import 'package:flutterclonethecoffeehouse/src/data/models/entities.dart';
import 'package:flutterclonethecoffeehouse/src/modules/cart/bloc/cart_bloc.dart';
import 'package:flutterclonethecoffeehouse/src/theme/my_colors.dart';

class ProductDetailDialog extends StatefulWidget {
  final ProductEntity product;

  const ProductDetailDialog({Key key, this.product}) : super(key: key);

  @override
  _ProductDetailDialogState createState() => _ProductDetailDialogState(
        product: product,
      );
}

class _ProductDetailDialogState extends State<ProductDetailDialog> {
  ProductDetailBloc bloc;
  Size inSize = Size.SMALL;
  Topping inTopping = Topping.NONE;

  _ProductDetailDialogState({ProductEntity product}) {
    bloc = ProductDetailBloc(product: product);
  }

  int selectedIndex = -1;
  bool isActive = false;

  CartBloc get _cartBloc => BlocProvider.of<CartBloc>(context);

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
      bloc: bloc,
      builder: (BuildContext context, ProductDetailState state) {
        if (state.product == null) {
          return Dialog(
            backgroundColor: Colors.red,
          );
        }
        return Dialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(8.0))),
          child: Container(
            constraints: BoxConstraints(minHeight: 500, maxHeight: 600, maxWidth: 350),
            child: Column(
              children: <Widget>[buildHeader(context), buildBody(context), buildFooter(context)],
            ),
          ),
        );
      },
    );
  }

  Widget buildHeader(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
        child: Row(
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(8)),
              child: Image.network(
                widget.product.imgUrl,
                width: 70,
                height: 70,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    widget.product.name,
                    style: Theme
                        .of(context)
                        .textTheme
                        .body1,
                  ),
                  Text(widget.product.cost.toString(), style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16)),
                  SizedBox(
                    height: 10,
                  ),
                  InkWell(
                    onTap: () {
                      setState(() {
                        isActive = !isActive;
                      });
                    },
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: <Widget>[
                        Icon(
                          Icons.favorite,
                          color: isActive == true ? Colors.red : Colors.grey,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          "Yêu thích",
                          style: Theme.of(context).textTheme.subhead,
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
  }

  Widget buildBody(BuildContext context) {
    return Expanded(
      child: MediaQuery.removePadding(
        context: context,
        removeTop: true,
        child: ListView(
          shrinkWrap: true,
          scrollDirection: Axis.vertical,
          children: <Widget>[
            Container(
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: Container(
                margin: EdgeInsets.all(8),
                child: Text(
                  "Size",
                  style: Theme
                      .of(context)
                      .textTheme
                      .title
                      .copyWith(fontWeight: FontWeight.w400),
                ),
              ),
              color: Colors.grey.withOpacity(0.3),
            ),
            Container(
              child: Column(
                children: <Widget>[
                  buildChooseSize("Lớn", "+ 10000đ", 0),
                  Divider(
                    height: 1,
                    color: Colors.grey.withOpacity(0.5),
                    indent: 18,
                    endIndent: 18,
                  ),
                  buildChooseSize("Vừa", "+ 5000đ", 1),
                  Divider(
                    height: 1,
                    color: Colors.grey.withOpacity(0.5),
                    indent: 18,
                    endIndent: 18,
                  ),
                  buildChooseSize("Nhỏ", "", 2),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: Container(
                margin: EdgeInsets.all(8),
                child: Text("Topping", style: Theme
                    .of(context)
                    .textTheme
                    .title
                    .copyWith(fontWeight: FontWeight.w400)),
              ),
              color: Colors.grey.withOpacity(0.3),
            ),
            Container(
              child: Column(
                children: <Widget>[buildChooseTopping(index: 0, title: "Trân châu trắng", cost: '10000 đ')],
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: Container(
                margin: EdgeInsets.all(8),
                child: Text("Giới thiệu món", style: Theme
                    .of(context)
                    .textTheme
                    .title
                    .copyWith(fontWeight: FontWeight.w400)),
              ),
              color: Colors.grey.withOpacity(0.3),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              child: Text(
                widget.product.category,
                style: Theme.of(context).textTheme.body1,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildFooter(BuildContext context) {
    return Container(
      height: 80,
      child: Row(
        children: <Widget>[
          Row(
            children: <Widget>[
              Material(
                child: IconButton(
                  iconSize: 30,
                  icon: Icon(
                    Icons.remove_circle,
                    color: (bloc.state.quantity > 1 == true) ? MyColors.red : MyColors.grey,
                  ),
                  onPressed: () {
                    bloc.decrementQuantity();
                  },
                ),
              ),
              Text(bloc.state.quantity.toString()),
              Material(
                child: IconButton(
                  iconSize: 30,
                  icon: Icon(
                    Icons.add_circle,
                    color: Theme
                        .of(context)
                        .buttonColor,
                  ),
                  onPressed: () {
                    bloc.incrementQuantity();
                  },
                ),
              ),
            ],
          ),
          InkWell(
            onTap: () {
              _cartBloc?.addProduct(
                product: bloc.state.product,
                cost: bloc.totalCost(),
                quantity: bloc.state.quantity,
                size: inSize,
                topping: inTopping,
              );
              print('aaaa${_cartBloc?.addProduct}');

              Navigator.of(context).pop();
            },
            child: Container(
              margin: EdgeInsets.only(left: 50),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                color: Theme
                    .of(context)
                    .buttonColor,
              ),
              height: 50,
              constraints: BoxConstraints(minWidth: 80, maxWidth: 120),
              child: Center(
                child: Text(
                  '${bloc.totalCost()} đ',
                  style: Theme
                      .of(context)
                      .textTheme
                      .button,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  totalCost() {
    return (widget.product.cost * bloc.state.quantity).toString() + " đ";
  }

  Widget buildChooseSize(
    String title,
    String cost,
    int index,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 17),
      child: InkWell(
        onTap: () {
          bloc.state.selectedSizeIndex = index;
          Size size = chooseSize(index);
          bloc.chooseSize(size);
          inSize = size;
        },
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              width: 20,
              height: 20,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: Theme
                    .of(context)
                    .primaryColor, width: 2.5),
                color: bloc.state.selectedSizeIndex == index ? MyColors.yellowOrange : Colors.transparent,
              ),
            ),
            SizedBox(
              width: 15,
            ),
            Text(
              title,
              style: TextStyle(fontWeight: FontWeight.w400, fontSize: 18),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 160),
              child: Text(cost, style: TextStyle(fontWeight: FontWeight.w400, fontSize: 15)),
            )
          ],
        ),
      ),
    );
  }

  Size chooseSize(int index) {
    switch (index) {
      case 0:
        return Size.LARGE;
      case 1:
        return Size.MEDIUM;
      case 2:
        return Size.SMALL;
    }
    return Size.SMALL;
  }

  Widget buildChooseTopping({
    int index,
    String title,
    String cost,
    bool isActive = false,
  }) {
    return InkWell(
      onTap: () {
        Topping topping;
        bloc.state.isActive = !bloc.state.isActive;
        print(bloc.state.isActive);
        if (bloc.state.isActive == true) {
          topping = Topping.TRANCHAUTRANG;
        } else {
          topping = Topping.NONE;
        }
        bloc.chooseTopping(topping);
        inTopping = topping;
      },
      child: Container(
        padding: EdgeInsets.only(left: 20),
        height: 70,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(left: 20),
              width: 20,
              height: 20,
              decoration: BoxDecoration(
                border: Border.all(color: Theme
                    .of(context)
                    .primaryColor, width: 2.5),
                color: (bloc.state.isActive == true) ? MyColors.yellowOrange : Colors.transparent,
              ),
            ),
            SizedBox(
              width: 15,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(title),
                Text(
                  cost,
                  style: Theme
                      .of(context)
                      .textTheme
                      .subtitle2,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
