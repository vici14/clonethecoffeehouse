import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutterclonethecoffeehouse/src/data/repository/models/product_repository.dart';
import 'package:flutterclonethecoffeehouse/src/modules/order/bloc/catalog_bloc.dart';
import 'package:flutterclonethecoffeehouse/src/theme/my_colors.dart';

enum Cost { five, ten, zero }

class ProductDetailDialog extends StatefulWidget {
  final ProductResponseRepository product;
  final CatalogBloc catalogBloc;

  const ProductDetailDialog({Key key, this.product, this.catalogBloc})
      : super(key: key);

  @override
  _ProductDetailDialogState createState() => _ProductDetailDialogState();
}

class _ProductDetailDialogState extends State<ProductDetailDialog> {
  Cost _cost = Cost.five;
  int selectedIndex = -1;
  int quantity;
  bool noProduct = false;
  bool isActive = false;

  @override
  void initState() {
    super.initState();
    quantity = 1;
  }

  void _handleIncrement() {
    setState(() {
      quantity++;
    });
    if (quantity > 1) {
      noProduct = false;
    }
  }

  void _handleDecrement() {
    if (quantity > 1) {
      setState(() {
        quantity--;
      });
    }
    if (quantity == 1) {
      noProduct = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(8.0))),
      child: Container(
        constraints:
            BoxConstraints(minHeight: 500, maxHeight: 600, maxWidth: 350),
        child: Column(
          children: <Widget>[
            buildHeader(context),
            buildBody(context),
            buildFooter(context)
          ],
        ),
      ),
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
                    style: Theme.of(context).textTheme.body1,
                  ),
                  Text(widget.product.cost.toString(),
                      style:
                          TextStyle(fontWeight: FontWeight.w600, fontSize: 16)),
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
                  style: Theme.of(context)
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
//
                  buildChooseSize("Lớn", "+ 10000đ", 1),
                  Divider(
                    height: 1,
                    color: Colors.grey.withOpacity(0.5),
                    indent: 18,
                    endIndent: 18,
                  ),
                  buildChooseSize("Vừa", "+ 5000đ", 2),
                  Divider(
                    height: 1,
                    color: Colors.grey.withOpacity(0.5),
                    indent: 18,
                    endIndent: 18,
                  ),
                  buildChooseSize("Nhỏ", "", 3),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: Container(
                margin: EdgeInsets.all(8),
                child: Text("Topping",
                    style: Theme.of(context)
                        .textTheme
                        .title
                        .copyWith(fontWeight: FontWeight.w400)),
              ),
              color: Colors.grey.withOpacity(0.3),
            ),
            Container(
              child: Column(
                children: <Widget>[
                  RadioListTile(
                    groupValue: _cost,
                    onChanged: (Cost value) {
                      setState(() {
                        _cost = value;
                      });
                    },
                    value: Cost.ten,
                    title: Text("Trân châu trắng"),
                    subtitle: Text("+10.000đ"),
                  )
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: Container(
                margin: EdgeInsets.all(8),
                child: Text("Giới thiệu món",
                    style: Theme.of(context)
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
                    color: noProduct == false ? MyColors.red : MyColors.grey,
                  ),
                  onPressed: () {
                    _handleDecrement();
                  },
                ),
              ),
              Text(quantity.toString()),
              Material(
                child: IconButton(
                  iconSize: 30,
                  icon: Icon(
                    Icons.add_circle,
                    color: Theme.of(context).buttonColor,
                  ),
                  onPressed: () {
                    _handleIncrement();
                  },
                ),
              ),
            ],
          ),
//          SizedBox(
//            width: 60,
//          ),
          InkWell(
            onTap: () {
              if (noProduct == true) {
                Navigator.of(context).pop();
              }
            },
            child: Container(
              margin: EdgeInsets.only(left: 50),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                color: Theme.of(context).buttonColor,
              ),
              height: 50,
              constraints: BoxConstraints(minWidth: 80, maxWidth: 120),
              child: Center(
                child: Text(
                  totalCost(),
                  style: Theme.of(context).textTheme.button,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  totalCost() {
    return (widget.product.cost * quantity).toString() + " đ";
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
          setState(() {
            selectedIndex == index;
            print(index);
          });
        },
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              width: 20,
              height: 20,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: Colors.grey, width: 2.5),
                color: selectedIndex == index
                    ? MyColors.yellowOrange
                    : Colors.transparent,
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
              child: Text(cost,
                  style: TextStyle(fontWeight: FontWeight.w400, fontSize: 15)),
            )
          ],
        ),
      ),
    );
  }
}
