import 'package:app/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Chooser extends StatefulWidget {
  Chooser({this.confirm = false, this.payment = false, this.shipping = false});
  bool shipping, payment, confirm;
  @override
  State<Chooser> createState() => ChooserState();
}

class ChooserState extends State<Chooser> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 10, bottom: 30),
      child: Center(
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
                padding: EdgeInsets.all(10),
                child: Container(
                  child: Icon(
                    Icons.location_on,
                    color: widget.shipping ? kPrimaryColor : Colors.grey,
                  ),
                )),
            Padding(
                padding: EdgeInsets.all(10),
                child: Container(
                  child: Icon(
                    Icons.payment,
                    color: widget.payment ? kPrimaryColor : Colors.grey,
                  ),
                )),
            Padding(
                padding: EdgeInsets.all(10),
                child: Container(
                  child: Icon(
                    Icons.check,
                    color: widget.confirm ? kPrimaryColor : Colors.grey,
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
