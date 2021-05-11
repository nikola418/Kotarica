import 'package:app/model/cart.dart';
import 'package:app/model/personal_data.dart';
import 'package:flutter/material.dart';

class ConfirmConfiguration extends StatelessWidget {
  ConfirmConfiguration({
    this.personalData,
  });
  PersonalData personalData;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.fromLTRB(20, 0, 20, 100),
      child: Column(
        children: [
          // Divider(
          //   thickness: 3,
          //   color: Theme.of(context).colorScheme == ColorScheme.dark()
          //       ? Colors.black
          //       : kPrimaryColor,
          // ),
          // Container(
          //   height: 60,
          //   child: Row(
          //     children: [
          //       _Atribut(text: "Ime: "),
          //       _Vrednost(text: personalData.ime)
          //     ],
          //   ),
          // ),
          // Divider(
          //   color: Theme.of(context).colorScheme == ColorScheme.dark()
          //       ? Colors.black
          //       : kPrimaryColor,
          // ),
          // Container(
          //   height: 60,
          //   child: Row(
          //     children: [
          //       _Atribut(text: "Kontakt: "),
          //       _Vrednost(text: personalData.kontakt)
          //     ],
          //   ),
          // ),
          // Divider(
          //   color: Theme.of(context).colorScheme == ColorScheme.dark()
          //       ? Colors.black
          //       : kPrimaryColor,
          // ),
          // Container(
          //   height: 60,
          //   child: Row(
          //     children: [
          //       _Atribut(text: "Postanski broj: "),
          //       _Vrednost(text: personalData.postanskiBroj),
          //     ],
          //   ),
          // ),
          // Divider(
          //   color: Theme.of(context).colorScheme == ColorScheme.dark()
          //       ? Colors.black
          //       : kPrimaryColor,
          // ),
          // Container(
          //   height: 60,
          //   child: Row(
          //     children: [
          //       _Atribut(text: "Adresa: "),
          //       _Vrednost(text: personalData.adresa)
          //     ],
          //   ),
          // ),
          // Divider(
          //   color: Theme.of(context).colorScheme == ColorScheme.dark()
          //       ? Colors.black
          //       : kPrimaryColor,
          // ),
          // // Container(
          // //   height: 60,
          // //   child: Row(
          // //     children: [
          // //       _Atribut(text: "opis: "),
          // //       _Vrednost(text: personalData.opis)
          // //     ],
          // //   ),
          // // ),
          // // Divider(
          // //   color: Theme.of(context).colorScheme == ColorScheme.dark()
          // //       ? Colors.black
          // //       : kPrimaryColor,
          // // ),
          // Container(
          //   height: 60,
          //   child: Row(
          //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //     children: [
          //       _Atribut(text: "Privatni kljuc: "),
          //       _Vrednost(
          //           text:
          //               "${personalData.privateKey.substring(0, 4) + personalData.privateKey.replaceRange(0, personalData.privateKey.length, '*' * (personalData.privateKey.length - 4))}")
          //     ],
          //   ),
          // ),
          // Divider(
          //   thickness: 3,
          //   color: Theme.of(context).colorScheme == ColorScheme.dark()
          //       ? Colors.black
          //       : kPrimaryColor,
          // ),

          for (Cart item in demoCarts) ...{
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _Atribut(
                    text:
                        "${demoCarts.indexOf(item) + 1}. ${item.product.naziv}: "),
                _Vrednost(text: "${item.numOfItems} x ${item.product.cena} RSD")
              ],
            )
          },
          SizedBox(
            height: 10,
          ),
          _Atribut(
            text: "Ukupno: ${sumTotal(demoCarts)} RSD",
          ),
          // Divider(
          //   thickness: 3,
          //   color: Theme.of(context).colorScheme == ColorScheme.dark()
          //       ? Colors.black
          //       : kPrimaryColor,
          // ),
        ],
      ),
    );
  }
}

class _Atribut extends StatelessWidget {
  _Atribut({@required this.text});
  final text;
  Widget build(BuildContext context) {
    return Text(
      "${text}",
      style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800),
      maxLines: 2,
    );
  }
}

class _Vrednost extends StatelessWidget {
  _Vrednost({@required this.text});

  final text;
  Widget build(BuildContext context) {
    return Expanded(
      child: Text(
        text != '' ? "${text}" : '-',
        style: TextStyle(
          fontSize: 16,
        ),
        maxLines: 2,
        textDirection: TextDirection.ltr,
      ),
    );
  }
}
