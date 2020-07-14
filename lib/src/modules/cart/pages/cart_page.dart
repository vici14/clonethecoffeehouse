import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterclonethecoffeehouse/src/utils/uidata.dart';

class CartPage extends StatefulWidget {
  @override
  State<CartPage> createState() {
    return _CartPageState();
  }
}

class _CartPageState extends State<CartPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text("Giỏ hàng của bạn"),
      ),
      body: SafeArea(
        child: Container(
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
        ),
      ),
    );
  }

  Widget _buildProductRow({int quantity, String title, String size, int cost}) {
    return Container(
      width: double.infinity,
      height: 100,
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
                    quantity.toString(),
                    style: TextStyle(color: Theme.of(context).primaryColor),
                  )),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(title),
                  Text(size, style: Theme.of(context).textTheme.subtitle2),
                  Container(
                    height: 59,
                    width: 250,
                    child: TextField(
                        style: TextStyle(
                            fontSize: 13, color: Colors.grey.withOpacity(0.8)),
                        textInputAction: TextInputAction.done,
                        maxLines: 2,
                        decoration: InputDecoration(
                            hintText: "Bạn muốn dặn dò gì không?",
                            hintStyle: TextStyle(fontSize: 13),
                            icon: Icon(Icons.event_note))),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10.0),
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    '${cost.toString()} đ',
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
                          style:
                              TextStyle(color: Theme.of(context).primaryColor),
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
      color: Theme.of(context).canvasColor,
      child: Column(
        children: <Widget>[
          _buildProductRow(
              quantity: 1,
              title: "Điều vàng rang muối",
              size: "Nhỏ",
              cost: 20000),
          _buildProductRow(
              quantity: 3,
              title: "Chocolate Đá Xay",
              size: "Vừa",
              cost: 177000),
          _buildProductRow(
              quantity: 2,
              title: "Trà Oolong Hoa Atiso Đỏ",
              cost: 60000,
              size: "Lớn"),
          _buildProductRow(
              quantity: 5,
              title: "Caramel Macchiato Đá",
              cost: 50000,
              size: "Nhỏ"),
        ],
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
                Text("307.000đ"),
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
                  width: MediaQuery.of(context).size.width / 2,
                  decoration: BoxDecoration(
                      border: Border(
                          right: BorderSide(
                              width: 1, color: Colors.grey.withOpacity(0.5)))),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10.0),
                    child: Center(
                      child: Column(
                        children: <Widget>[
                          Image.asset(UIData.icVisa),
                          Text("Visa/Master/JCB"),
                          Text("307.000 đ")
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
                      "307.000 đ",
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
