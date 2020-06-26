import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NewsPage extends StatefulWidget {
  @override
  _NewsPageState createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  final ScrollController scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
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
          backgroundColor: Colors.grey,
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
              color: Colors.grey,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      Container(
                        height: 50,
                        width: 50,
                        color: Colors.deepPurpleAccent,
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Text('Tich Diem')
                    ],
                  ),
                  Column(
                    children: <Widget>[
                      Container(
                        height: 50,
                        width: 50,
                        color: Colors.deepPurpleAccent,
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Text('Tich Diem')
                    ],
                  ),
                  Column(
                    children: <Widget>[
                      Container(
                        height: 50,
                        width: 50,
                        color: Colors.deepPurpleAccent,
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Text('Tich Diem')
                    ],
                  ),
                  Column(
                    children: <Widget>[
                      Container(
                        height: 50,
                        width: 50,
                        color: Colors.deepPurpleAccent,
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Text('Tich Diem')
                    ],
                  )
                ],
              ),
            )
          ]),
        ),
        SliverList(
          delegate: SliverChildListDelegate([
            Container(
              margin: EdgeInsets.only(top: 20),
              color: Colors.grey,
              height: 200,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: Text(
                      'Nhac dang phat tai Nha',
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(18),
                      color: Colors.purple,
                    ),
                    margin: EdgeInsets.all(
                      20,
                    ),
                    height: 130,
                    child: Row(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(left: 10.0, right: 20),
                          child: Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.yellowAccent,
                            ),
                            width: 80,
                            height: 80,
                          ),
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text('Vi sao anh co giau'),
                            Text('Huong Tram'),
                            Text('Now Playing'),
                          ],
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ]),
        ),
        SliverList(
          delegate: SliverChildListDelegate([
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Text('Whats News'),
                      ),
                      PopupMenuButton(
                        itemBuilder: (BuildContext context) {},
                      )
                    ],
                  ),
                  Container(
                    height: 300,
                    color: Colors.black,
                    child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: 10,
                        itemBuilder: (BuildContext context, int index) {
                          return Center(
                            child: Container(
                              margin: EdgeInsets.all(10),
                              height: MediaQuery.of(context).size.height * 0.7,
                              width: MediaQuery.of(context).size.width * 0.6,
                              color: Colors.teal,
                            ),
                          );
                        }),
                  ),
                ],
              ),
            )
          ]),
        )
      ],
    );
  }

  Widget buildNewsCard(BuildContext context) {}
}
