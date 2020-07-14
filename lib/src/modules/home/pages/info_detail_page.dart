import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterclonethecoffeehouse/src/modules/dashboard/bloc/dashboard_bloc.dart';
import 'package:flutterclonethecoffeehouse/src/modules/dashboard/bloc/dashboard_state.dart';
import 'package:flutterclonethecoffeehouse/src/modules/home/model/item_card.dart';

class InfoDetailPage extends StatefulWidget {
  final ItemCard itemCard;

  const InfoDetailPage({Key key, this.itemCard}) : super(key: key);

  @override
  _InfoDetailPageState createState() => _InfoDetailPageState();
}

class _InfoDetailPageState extends State<InfoDetailPage> {
  bool _isVisible = false;

  @override
  void initState() {
    super.initState();
    if (widget.itemCard.buttonText == "Order ngay") {
      _isVisible = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          actions: <Widget>[
            IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.share,
                color: Colors.black,
              ),
            )
          ],
          backgroundColor: Colors.white,
          title: Text(
            widget.itemCard.body,
            style: Theme.of(context).textTheme.title,
            overflow: TextOverflow.clip,
            maxLines: 1,
          ),
        ),
        body: Stack(
          children: <Widget>[
            ListView(
              scrollDirection: Axis.vertical,
              children: <Widget>[
                Container(
                  height: MediaQuery.of(context).size.height * 0.3,
                  width: double.infinity,
                  child: Image.asset(
                    widget.itemCard.imgAssets,
                    fit: BoxFit.cover,
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(top: 15, bottom: 15),
                        child: Text(
                          widget.itemCard.body,
                          style: Theme.of(context).textTheme.display1,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Text(
                          widget.itemCard.description,
                          style: Theme.of(context).textTheme.subtitle,
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Visibility(
                    visible: _isVisible,
                    child: InkWell(
                      onTap: () {
                        BlocProvider.of<DashBoardBloc>(context)
                            .changePage(DashBoardTypes.ORDER);
                      },
                      child: Center(
                        child: Container(
                          width: double.infinity,
                          height: 50,
                          decoration: BoxDecoration(
                              color: Theme.of(context).primaryColor,
                              border: Border.all(
                                  color: Theme.of(context).primaryColor,
                                  width: 2),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(30))),
                          child: Center(
                              child: Text(
                            "Order Ngay",
                            style: TextStyle(color: Colors.white),
                          )),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ],
        ));
  }
}
