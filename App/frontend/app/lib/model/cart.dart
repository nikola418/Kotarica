import 'package:app/model/proizvodiModel.dart';
import 'package:flutter/cupertino.dart';

class Cart {
  final Proizvod product;
  int numOfItems;

  Cart({@required this.product, @required this.numOfItems});
}

List<Cart> demoCarts = [];

void dodajJedanProizvodUKorpu(Proizvod proizvod) {
  bool ind = true;
  for (int i = 0; i < demoCarts.length; i++) {
    if (demoCarts[i].product.id == proizvod.id) {
      demoCarts[i].numOfItems++;
      ind = false;
      break;
    }
    if (ind) {
      demoCarts.add(Cart(numOfItems: 1, product: proizvod));
    }
  }
}
