import 'package:flutter/material.dart';

class AccentRaisedButton extends StatelessWidget {
  final Function onPressed;
  final Widget child;
  final Color color;
  const AccentRaisedButton(
      {@required this.onPressed, @required this.child, this.color});

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      color: Colors.orange,
      textColor: Colors.white,
      onPressed: onPressed,
      child: child,
    );
  }
}
