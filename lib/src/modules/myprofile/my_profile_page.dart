import 'package:flutter/material.dart';

class MyProfilePage extends StatelessWidget {
  final ScrollController scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      color: Colors.grey.withOpacity(0.2),
      child: CustomScrollView(
        controller: scrollController,
        physics: AlwaysScrollableScrollPhysics(),
        slivers: <Widget>[
          SliverAppBar(
            elevation: 1,
            pinned: true,
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
          SliverList(
            delegate: SliverChildListDelegate(
              [
                Container(
                  padding: EdgeInsets.only(top: 5, bottom: 5),
                  margin: EdgeInsets.only(top: 20),
                  decoration: BoxDecoration(color: Colors.white),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        ListTile(
                          onTap: () {},
                          leading: Icon(Icons.stars),
                          title: Text("The Coffee House Rewards",
                              style: TextStyle(fontWeight: FontWeight.w500)),
                        ),
                        ListTile(
                          onTap: () {},
                          leading: Icon(Icons.person_outline),
                          title: Text("Thông tin tài khoản ",
                              style: TextStyle(fontWeight: FontWeight.w500)),
                        ),
                        ListTile(
                          onTap: () {},
                          leading: Icon(Icons.queue_music),
                          title: Text("Nhạc đang phát",
                              style: TextStyle(fontWeight: FontWeight.w500)),
                        ),
                        ListTile(
                          onTap: () {},
                          leading: Icon(Icons.stars),
                          title: Text("Lịch sử",
                              style: TextStyle(fontWeight: FontWeight.w500)),
                        ),
                        ListTile(
                          onTap: () {},
                          leading: Icon(Icons.credit_card),
                          title: Text("Thanh toán",
                              style: TextStyle(fontWeight: FontWeight.w500)),
                        ),
                        ListTile(
                          onTap: () {},
                          leading: Icon(Icons.help),
                          title: Text("Giúp đỡ",
                              style: TextStyle(fontWeight: FontWeight.w500)),
                        ),
                        ListTile(
                          onTap: () {},
                          leading: Icon(Icons.settings),
                          title: Text(
                            "Cài đặt",
                            style: TextStyle(fontWeight: FontWeight.w500),
                          ),
                        )
                      ]),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 290.0),
                  child: FlatButton(
                    child: Text(
                      "Đăng xuất",
                      style: TextStyle(fontSize: 16),
                    ),
                    onPressed: () {},
                  ),
                )
              ],
            ),
          )
        ],
      ),
    ));
  }
}
