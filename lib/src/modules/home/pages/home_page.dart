import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterclonethecoffeehouse/src/modules/home/model/mock_data.dart';
import 'package:flutterclonethecoffeehouse/src/utils/uidata.dart';
import 'package:flutterclonethecoffeehouse/src/widgets/stateless/custom_info_sliver.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    Key key,
  }) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        physics: AlwaysScrollableScrollPhysics(),
        controller: scrollController,
        slivers: <Widget>[
          SliverAppBar(
            elevation: 1,
            floating: true,
            forceElevated: true,
            actions: <Widget>[
              IconButton(
                onPressed: () {},
                icon: Icon(Icons.notifications),
              ),
            ],
            backgroundColor: Colors.white,
            flexibleSpace: Padding(
              padding: const EdgeInsets.fromLTRB(15, 30, 0, 10),
              child: Row(
                children: <Widget>[
                  CircleAvatar(
                    backgroundColor: Colors.black.withOpacity(0.5),
                    child: Icon(Icons.person),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10, left: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text('Việt Cường'),
                        Text('Thành viên vàng')
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
          CupertinoSliverRefreshControl(),
          SliverList(
            delegate: SliverChildListDelegate([
              Container(
                padding: EdgeInsets.only(top: 20, bottom: 20),
                margin: EdgeInsets.only(top: 20),
                color: Theme.of(context).canvasColor,
                child: _buildNavigateRow(),
              )
            ]),
          ),
          CustomInfoSliver(
            title: "Ưu đãi đặc biệt",
            items: itemCards,
          ),
          CustomInfoSliver(
            title: "Cập nhật từ nhà",
            items: updateFromHouse,
          ),
          CustomInfoSliver(
            title: "#CoffeeLover",
            items: coffeeLovers,
          ),
        ],
      ),
    );
  }

  Widget _buildNavigateRow() {
    return Container(
      width: double.infinity,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          _buildColumnItem("Tích điểm", UIData.icPoint),
          _buildColumnItem("Đặt hàng", UIData.icShip),
          _buildColumnItem("Coupon", UIData.icCoupon),
          _buildColumnItem("Rewards", UIData.icRewards),
        ],
      ),
    );
  }

  Widget _buildColumnItem(String text, String icon) {
    return Column(
      children: <Widget>[
        Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
          ),
          child: Image.asset(
            icon,
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Text(text)
      ],
    );
  }
}
