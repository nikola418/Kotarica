import 'package:app/model/cart.dart';
import 'package:app/model/proizvodiModel.dart';
import 'package:flutter/material.dart';
import 'package:app/constants.dart';

// ignore: must_be_immutable
class NumberSelector extends StatefulWidget {
  @override
  final Proizvod proizvod;

  NumberSelector({this.proizvod});

  State<StatefulWidget> createState() {
    return TestState(proizvod: proizvod);
  }
}

class TestState extends State<NumberSelector> {
  int counter = 1;
  final Proizvod proizvod;

  TestState({
    this.proizvod,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Padding(
          padding: EdgeInsets.only(left: 5.0, right: 5.0),
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                //if (!added) ...[
                Icon(Icons.shopping_basket, color: kPrimaryColor, size: 12.0),
                MaterialButton(
                  onPressed: () {
                    dodajProizvod(proizvod, counter);
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text("Dodata " +
                            counter.toString() +
                            " proizvoda u korpu")));
                  },
                  child: Text('Dodati u korpu',
                      style: TextStyle(
                          fontFamily: 'Varela',
                          color: kPrimaryColor,
                          fontSize: 14.0)),
                ),
                //  ],
                // if (added) ...[

                // ]
              ],
            ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            IconButton(
              onPressed: () {
                setState(() {
                  counter--;
                });
              },
              icon: Icon(
                Icons.add_circle_outline,
                color: kPrimaryColor,
                size: 12.0,
              ),
            ),
            Text(
              counter.toString(),
              style: TextStyle(
                  fontFamily: 'Varela',
                  color: kPrimaryColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 12.0),
            ),
            IconButton(
              onPressed: () {
                setState(() {
                  counter++;
                });
              },
              icon: Icon(
                Icons.add_circle_outline,
                color: kPrimaryColor,
                size: 12.0,
              ),
            ),
          ],
        )
      ],
    );
  }
}