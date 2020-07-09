import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterclonethecoffeehouse/src/domain/entities/store_entity.dart';
import 'package:flutterclonethecoffeehouse/src/utils/map_util.dart';

class InfoDetailStorePage extends StatefulWidget {
  final StoreEntity store;

  const InfoDetailStorePage({Key key, this.store}) : super(key: key);

  @override
  State<InfoDetailStorePage> createState() {
    return _InfoDetailStorePageState();
  }
}

class _InfoDetailStorePageState extends State<InfoDetailStorePage> {
  @override
  Widget build(BuildContext context) {
    var store = widget.store;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).canvasColor,
        title: Text(store.address),
      ),
      body: SingleChildScrollView(
        physics: AlwaysScrollableScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              width: double.infinity,
              height: MediaQuery.of(context).size.height * 0.35,
              child: Image.network(
                store.imgUrl,
                fit: BoxFit.cover,
              ),
            ),
            Container(
              color: Theme.of(context).canvasColor,
              padding: EdgeInsets.symmetric(horizontal: 8),
              child: Column(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.all(15),
                    color: Colors.grey.withOpacity(0.5),
                    width: double.infinity,
                    height: 100,
                  ),
                  ListTile(
                    leading: Icon(
                      Icons.location_on,
                      color: Theme.of(context).primaryColor,
                    ),
                    title: Text(store.fullAddress),
                  ),
                  Divider(
                    height: 1,
                    color: Colors.grey.withOpacity(0.2),
                    endIndent: 20,
                    indent: 20,
                  ),
                  Container(
                    height: 60,
                    width: double.infinity,
                    child: Center(
                      child: Padding(
                        padding: EdgeInsets.only(left: 180),
                        child: InkWell(
                          onTap: () {
                            return MapUtils.openMap(store.coordinate.latitude,
                                store.coordinate.longtitude);
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(50)),
                                border: Border.all(
                                    width: 1,
                                    color: Theme.of(context).primaryColor)),
                            width: 180,
                            height: 40,
                            child: Center(
                                child: Text(
                              "Chỉ đường đến đây",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText1
                                  .copyWith(
                                      color: Theme.of(context).primaryColor),
                            )),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Chi tiết",
              ),
            ),
            Container(
              color: Theme.of(context).canvasColor,
              child: ListTile(
                leading: Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Icon(Icons.access_time),
                ),
                title: Text("Giờ mở cửa "),
                subtitle: Text("7:00 - 22:30"),
              ),
            ),
            Container(
              color: Theme.of(context).canvasColor,
              child: ListTile(
                leading: Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Icon(Icons.phone),
                ),
                title: Text("Liên hệ "),
                subtitle: Text("02871087008"),
              ),
            )
          ],
        ),
      ),
    );
  }
}
