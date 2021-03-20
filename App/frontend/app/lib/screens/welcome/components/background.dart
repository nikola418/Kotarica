<<<<<<< HEAD
import 'package:flutter/material.dart';

class Background extends StatelessWidget {
  final Widget child;
  const Background({
    Key key,
    @required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size; //razmere ekrana
    return Container(
      height: size.height,
      width: double.infinity,
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Positioned(
            top: 0.0,
            left: 0.0,
            child: Image.asset(
              "assets/images/main_top.png",
              alignment: Alignment.topLeft,
              width: size.width * 0.35,
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            child: Image.asset(
              "assets/images/main_bottom.png",
              alignment: Alignment.bottomLeft,
              width: size.width * 0.35,
            ),
          ),
          child,
        ],
      ),
    );
  }
}
=======
import 'package:flutter/material.dart';

class Background extends StatelessWidget {
  final Widget child;
  const Background({
    Key key,
    @required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size; //razmere ekrana
    return Container(
      height: size.height,
      width: double.infinity,
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Positioned(
            top: 0.0,
            left: 0.0,
            child: Image.asset(
              "assets/images/main_top.png",
              alignment: Alignment.topLeft,
              width: size.width * 0.35,
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            child: Image.asset(
              "assets/images/main_bottom.png",
              alignment: Alignment.bottomLeft,
              width: size.width * 0.35,
            ),
          ),
          child,
        ],
      ),
    );
  }
}
>>>>>>> 2ef4c09f107e2e28241f6bbd5d22ff5e1f235d19
