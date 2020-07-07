import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterclonethecoffeehouse/src/domain/entities/store_entity.dart';
import 'package:flutterclonethecoffeehouse/src/modules/map/pages/info_detail_store_page.dart';

class ListStore extends StatefulWidget {
  final List<StoreEntity> stores;

  const ListStore({Key key, this.stores}) : super(key: key);

  @override
  State<ListStore> createState() {
    return _ListStoreState();
  }
}

class _ListStoreState extends State<ListStore> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.27,
      width: MediaQuery.of(context).size.width,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: widget.stores.length,
          itemBuilder: (BuildContext context, int index) {
            var store = widget.stores[index];
            return GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => InfoDetailStorePage(
                              store: store,
                            )));
              },
              child: Container(
                width: MediaQuery.of(context).size.width * 0.4,
                height: MediaQuery.of(context).size.height,
                margin: EdgeInsets.only(right: 8, left: 5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      height: MediaQuery.of(context).size.height * 0.15,
                      width: double.infinity,
                      child: ClipRRect(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10),
                            topRight: Radius.circular(10)),
                        child: Image.network(
                          store.imgUrl,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                          color: Theme.of(context).canvasColor,
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(15),
                              bottomRight: Radius.circular(15))),
                      padding: EdgeInsets.only(left: 5),
                      height: MediaQuery.of(context).size.height * 0.1,
                      width: double.infinity,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text("Quận ${store.district}"),
                          Text(
                            store.address,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            );
          }),
    );
  }
}
