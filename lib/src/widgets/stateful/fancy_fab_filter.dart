import 'package:flutter/material.dart';
import 'package:flutterclonethecoffeehouse/src/theme/my_colors.dart';

class FancyFABFilter extends StatefulWidget {
  final Function() onPressed;
  final String tooltip;
  final IconData icon;
  final Widget child;
  final TabController tabController;

  FancyFABFilter(
      {this.onPressed,
      this.tooltip,
      this.icon,
      this.child,
      this.tabController});

  @override
  State<FancyFABFilter> createState() {
    return _FancyFABFilterState();
  }
}

class _FancyFABFilterState extends State<FancyFABFilter>
    with SingleTickerProviderStateMixin {
  bool isOpened = false;
  AnimationController _animationController;
  Animation<Color> _animateButtonColor;
  Animation<double> _animateIcon;
  Animation<double> _translateButton;
  double _fabHeight = 70.0;
  Curve _curve = Curves.easeOut;

  @override
  void initState() {
    // TODO: implement initState
    _animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 250))
          ..addListener(() {
            setState(() {});
          });
    _animateIcon =
        Tween<double>(begin: 0.0, end: 1.0).animate(_animationController);
    _animateButtonColor =
        ColorTween(begin: MyColors.yellowOrange, end: Colors.red).animate(
            CurvedAnimation(
                parent: _animationController,
                curve: Interval(0.00, 1.00, curve: _curve)));
    _translateButton = Tween<double>(begin: _fabHeight, end: -10).animate(
        CurvedAnimation(
            parent: _animationController,
            curve: Interval(0.0, 0.75, curve: _curve)));

    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  animate() {
    if (!isOpened) {
      _animationController.forward();
    } else {
      _animationController.reverse();
    }
    isOpened = !isOpened;
  }

  Widget toggle() {
    return FloatingActionButton(
      mini: true,
      elevation: 1,
      backgroundColor: _animateButtonColor.value,
      onPressed: animate,
      tooltip: 'Toggle',
      child: AnimatedIcon(
        icon: AnimatedIcons.menu_close,
        progress: _animateIcon,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Align(
        alignment: Alignment.bottomLeft,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Transform(
                transform: Matrix4.translationValues(
                    50, _translateButton.value * 5, 0),
                child: filterList(context)),
            Padding(
              padding: const EdgeInsets.only(right: 100),
              child: toggle(),
            ),
          ],
        ),
      ),
    );
  }

  Widget filterList(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          color: Theme.of(context).canvasColor,
          borderRadius: BorderRadius.all(Radius.circular(8))),
      height: 250,
      width: 200,
      child: Column(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(8), topLeft: Radius.circular(8))),
            padding: EdgeInsets.all(10),
            height: 45,
            width: double.infinity,
            child: Text("Danh mục món"),
          ),
          Expanded(
            child: MediaQuery.removePadding(
              context: context,
              child: ListView(
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                children: <Widget>[
                  ListTile(
                    title: Text(
                      "Yêu thích",
                      style: Theme.of(context).textTheme.subtitle,
                    ),
                    onTap: () {
                      _handleChangeTab(0);
                    },
                  ),
                  Divider(
                    height: 1,
                  ),
                  ListTile(
                    title: Text(
                      "Cà phê",
                      style: Theme.of(context).textTheme.subtitle,
                    ),
                    onTap: () {
                      _handleChangeTab(1);
                    },
                  ),
                  Divider(
                    height: 1,
                  ),
                  ListTile(
                    title: Text(
                      "Thức uống đá xay",
                      style: Theme.of(context).textTheme.subtitle,
                    ),
                    onTap: () {
                      _handleChangeTab(1);
                    },
                  ),
                  Divider(
                    height: 1,
                  ),
                  ListTile(
                    title: Text(
                      "Thức uống trái cây",
                      style: Theme.of(context).textTheme.subtitle,
                    ),
                    onTap: () {
                      _handleChangeTab(1);
                    },
                  ),
                  Divider(
                    height: 1,
                  ),
                  ListTile(
                    title: Text(
                      "Macchiato",
                      style: Theme.of(context).textTheme.subtitle,
                    ),
                    onTap: () {
                      _handleChangeTab(1);
                    },
                  ),
                  Divider(
                    height: 1,
                  ),
                  ListTile(
                    title: Text(
                      "Bánh",
                      style: Theme.of(context).textTheme.subtitle,
                    ),
                    onTap: () {
                      _handleChangeTab(2);
                    },
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  _handleChangeTab(int index) {
    if (widget.tabController.index != index) {
      widget.tabController.animateTo(index,
          duration: Duration(milliseconds: 300), curve: Curves.ease);
    } else {
      animate();
    }
  }
}
