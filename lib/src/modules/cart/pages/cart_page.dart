import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterclonethecoffeehouse/src/bloc/product_detail/product_detail_state.dart';
import 'package:flutterclonethecoffeehouse/src/domain/entities/cart_entity.dart';
import 'package:flutterclonethecoffeehouse/src/modules/cart/bloc/cart_bloc.dart';
import 'package:flutterclonethecoffeehouse/src/modules/cart/bloc/cart_state.dart';
import 'package:flutterclonethecoffeehouse/src/utils/uidata.dart';

class CartPage extends StatefulWidget {
  @override
  State<CartPage> createState() {
    return _CartPageState();
  }
}

class _CartPageState extends State<CartPage> {
  CartBloc get bloc => BlocProvider.of<CartBloc>(context);

  CartState get state => bloc?.state;

  List<CartItemEntity> get listItems => state?.cart?.listCartItem;

  CartItemEntity cartItem(int index) {
    if (listItems != null && listItems.length > index) {
      return listItems[index];
    }
    return null;
  }

  int get listLength => listItems?.length ?? 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text("Giỏ hàng của bạn"),
      ),
      body: SafeArea(
          child: BlocBuilder(
        bloc: bloc,
        builder: (BuildContext context, CartState state) {
          if (state?.cart?.listCartItem?.isEmpty == true) {
            return Center(
                child: Text(
              "Empty...",
              style: Theme.of(context).textTheme.subtitle1,
            ));
          }
          return Container(
            height: MediaQuery.of(context).size.height,
            child: Column(
              children: <Widget>[
                Expanded(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    physics: AlwaysScrollableScrollPhysics(),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.all(10),
                          child: Text("Nhận tại cửa hàng (Pick-up)"),
                        ),
                        _buildPickInfo(),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Text("Thời gian nhận nước tại cửa hàng"),
                        ),
                        _buildChooseTime(),
                        Padding(
                          padding: EdgeInsets.all(10),
                          child: Text("Chi tiết đơn hàng"),
                        ),
                        _buildDetailCart(context),
                        _buildReceipt(),
                      ],
                    ),
                  ),
                ),
                _buildFooter(),
              ],
            ),
          );
        },
      )),
    );
  }

  Widget _buildProductRow(CartItemEntity item) {
    String size = "";

    switch (item?.size) {
      case Size.LARGE:
        size = "Lớn";
        break;
      case Size.SMALL:
        size = "Nhỏ";
        break;
      case Size.MEDIUM:
        size = "Vừa";
        break;
      default:
        size = "Nhỏ";
    }

    return Container(
      width: double.infinity,
      height: 122,
      child: Stack(
        children: <Widget>[
          Row(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: Container(
                  width: 30,
                  height: 30,
                  decoration: BoxDecoration(border: Border.all()),
                  child: Center(
                      child: Text(
                        item.quantity.toString(),
                        style: TextStyle(color: Theme
                            .of(context)
                            .primaryColor),
                      )),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(item?.product?.name),
                  Text(size, style: Theme
                      .of(context)
                      .textTheme
                      .subtitle2),
                  (item.topping == Topping.NONE)
                      ? SizedBox()
                      : Text(
                    "Trân châu Trắng",
                    style: Theme
                        .of(context)
                        .textTheme
                        .subtitle2,
                  ),
                  Container(
                    height: 59,
                    width: 250,
                    child: TextField(
                        style: TextStyle(fontSize: 13, color: Colors.grey.withOpacity(0.8)),
                        textInputAction: TextInputAction.done,
                        maxLines: 2,
                        decoration: InputDecoration(hintText: "Bạn muốn dặn dò gì không?", hintStyle: TextStyle(fontSize: 13), icon: Icon(Icons.event_note))),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10.0),
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    '${item.cost} đ',
                    textAlign: TextAlign.end,
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPickInfo() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      width: double.infinity,
      height: 140,
      color: Theme.of(context).canvasColor,
      child: Row(
        children: <Widget>[
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
            ),
            child: Image.asset(UIData.icShip),
          ),
          SizedBox(
            width: 10,
          ),
          Flexible(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text("19-21 Đường 22"),
                      InkWell(
                        child: Text(
                          "THAY ĐỔI",
                          style: TextStyle(color: Theme
                              .of(context)
                              .primaryColor),
                        ),
                      )
                    ],
                  ),
                ),
                Expanded(
                  child: Text(
                    "P.Bình Trị Đông B, Quận Bình Tân, Hồ Chí Minh",
                    maxLines: 2,
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildChooseTime() {
    return Container(
      color: Theme.of(context).canvasColor,
      width: double.infinity,
      height: 80,
      child: ListTile(
        leading: Padding(
          padding: const EdgeInsets.only(top: 10.0),
          child: Icon(Icons.event),
        ),
        title: Text("Hẹn giờ"),
        subtitle: Text("Trong 15-30 phút"),
      ),
    );
  }

  Widget _buildDetailCart(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
      color: Theme
          .of(context)
          .canvasColor,
      child: ListView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        itemCount: listLength,
        itemBuilder: (BuildContext context, int index) {
          var item = cartItem(index);
          if (item != null) {
            return _buildProductRow(item);
          }
          return Text("Empty...");
        },
      ),
    );
  }

  Widget _buildReceipt() {
    return Container(
      height: 80,
      decoration: BoxDecoration(
          color: Theme.of(context).canvasColor,
          border: Border(
            top: BorderSide(color: Colors.grey.withOpacity(0.2)),
            bottom: BorderSide(color: Colors.grey.withOpacity(0.2)),
          )),
      padding: EdgeInsets.symmetric(horizontal: 30),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text("Tạm tính"),
                Text("${state.totalCost} đ" ?? "0"),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text("Phí giao hàng"),
                Text("Miễn phí"),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildFooter() {
    return Column(
      children: <Widget>[
        Container(
          width: double.infinity,
          height: 104,
          child: Row(
            children: <Widget>[
              InkWell(
                onTap: () {},
                child: Container(
                  width: MediaQuery
                      .of(context)
                      .size
                      .width / 2,
                  decoration: BoxDecoration(border: Border(right: BorderSide(width: 1, color: Colors.grey.withOpacity(0.5)))),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10.0),
                    child: Center(
                      child: Column(
                        children: <Widget>[
                          Image.asset(UIData.icVisa),
                          Text("Visa/Master/JCB"),
                          Text(
                            "${state?.totalCost} đ" ?? "0",
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              InkWell(
                onTap: () {},
                child: Container(
                  width: MediaQuery.of(context).size.width / 2,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10.0),
                    child: Center(
                      child: Column(
                        children: <Widget>[
                          Image.asset(
                            UIData.icCoupon3,
                            width: 40,
                            height: 40,
                          ),
                          Text("Mã ưu đãi"),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        InkWell(
          onTap: () {},
          child: Container(
            height: 60,
            width: double.infinity,
            color: Theme.of(context).primaryColor,
            child: Padding(
              padding: const EdgeInsets.only(left: 120.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Text(
                    "Đặt hàng",
                    style: TextStyle(color: Colors.white),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 15.0),
                    child: Text(
                      "${state?.totalCost} đ" ?? "0",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
          ),
        )
      ],
    );
  }
}
