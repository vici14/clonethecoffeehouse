import 'package:flutter/material.dart';
import 'package:flutterclonethecoffeehouse/src/modules/home/model/item_card.dart';
import 'package:flutterclonethecoffeehouse/src/modules/home/pages/info_detail_page.dart';

class CustomInfoSliver extends StatefulWidget {
  final String title;
  final List<ItemCard> items;

//  final itemCards;

  const CustomInfoSliver({
    Key key,
    this.title,
    this.items,
//    this.itemCards,
  }) : super(key: key);

  @override
  _CustomInfoSliverState createState() => _CustomInfoSliverState();
}

class _CustomInfoSliverState extends State<CustomInfoSliver> {
  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildListDelegate([
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                    child: Text(widget.title),
                  ),
                  PopupMenuButton<int>(
                    itemBuilder: (BuildContext context) {
                      return [
                        PopupMenuItem(
                          value: 1,
                          child: Text("Hữu ích"),
                        ),
                        PopupMenuItem(
                          value: 2,
                          child: Text("Cần cải thiện"),
                        ),
                      ];
                    },
                  )
                ],
              ),
              Container(
                height: 350,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: widget?.items?.length,
                  itemBuilder: (BuildContext context, int index) {
                    print(widget.items.length);
                    var item = widget?.items[index];
                    return _buildItem(item);
                  },
                ),
              )
            ],
          ),
        )
      ]),
    );
  }

  Widget _buildItem(item) {
    return GestureDetector(
      onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => InfoDetailPage(
                    itemCard: item,
                  ))),
      child: Container(
        margin: EdgeInsets.only(right: 10),
        width: MediaQuery.of(context).size.width * 0.6,
        child: Column(
          children: <Widget>[
            Container(
              ///top
              height: 140,
              child: ClipRRect(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10)),
                child: Image.asset(
                  item.imgAssets,
                  fit: BoxFit.cover,
                ),
              ),
              decoration: BoxDecoration(),
            ),
            Container(

                ///mid
                padding: EdgeInsets.all(10),
                height: 130,
                color: Colors.white,
                child: Column(
                  children: <Widget>[
                    Text(
                      item.body,
                      style: Theme.of(context).textTheme.body1,
                      maxLines: 2,
                      overflow: TextOverflow.clip,
                    ),
                    Text(
                      item.description,
                      style: Theme.of(context).textTheme.subtitle,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    )
                  ],
                )),
            Container(
              /// bot
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(8),
                      bottomRight: Radius.circular(8)),
                  color: Colors.white),
              height: 60,
              child: Row(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(left: 10),
                    width: 140,
                    height: 50,
                    decoration: BoxDecoration(
                        shape: BoxShape.rectangle,
                        borderRadius: BorderRadius.all(Radius.circular(50)),
                        border:
                            Border.all(color: Theme.of(context).buttonColor)),
                    child: Center(
                      child: Text(
                        item.buttonText,
                        style: TextStyle(
                            color: Theme.of(context).primaryColor,
                            fontWeight: FontWeight.w300),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
