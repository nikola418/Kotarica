import 'package:app/constants.dart';
import 'package:app/model/cart.dart';
import 'package:app/screens/products/productDetail.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import '../../../main.dart';

class CartItemCard extends StatefulWidget {
  const CartItemCard({
    Key key,
    @required this.cart,
    this.rebuild,
  }) : super(key: key);
  final Function rebuild;
  final Cart cart;

  @override
  _CartItemCardState createState() => _CartItemCardState();
}

class _CartItemCardState extends State<CartItemCard> {
  @override
  Widget build(BuildContext context) {
    var cart = Provider.of<Carts>(context, listen: true);
    Size size = MediaQuery.of(context).size;
    return Tooltip(
      message: "Prevuci da izbrišeš",
      child: InkWell(
        onTap: () => {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) =>
                  ProductDetail(proizvod: widget.cart.product)))
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            SizedBox(
              width: 150,
              child: AspectRatio(
                aspectRatio: 1,
                child: Container(
                    clipBehavior: Clip.hardEdge,
                    // clipBehavior: Clip.hardEdge,
                    child: Image.network(
                      "http://147.91.204.116:11099/ipfs/" + widget.cart.product.slika[0],
                      errorBuilder: (context, error, stackTrace) {
                        return SvgPicture.asset(
                            Theme.of(context).colorScheme == ColorScheme.dark()
                                ? "assets/icons/shopping-basket-dark.svg"
                                : "assets/icons/shopping-basket.svg");
                      },
                      fit: BoxFit.cover,
                    ),
                    decoration: BoxDecoration(
                      color: Theme.of(context).scaffoldBackgroundColor,
                      borderRadius: BorderRadius.circular(20),
                    )),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.cart.product.naziv,
                  style: TextStyle(
                    fontSize: 16,
                    color: Theme.of(context).accentColor,
                    fontWeight: FontWeight.w600,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 10),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text.rich(
                        TextSpan(
                            text: "${widget.cart.product.cena} RSD",
                            style: TextStyle(
                                color: Theme.of(context).accentColor,
                                fontWeight: FontWeight.w600),
                            children: [
                              // TextSpan(
                              //   text: " x",
                              //   style: TextStyle(color: Theme.of(context).hintColor),
                              // ),
                            ]),
                      ),
                      IconButton(
                        color: widget.cart.numOfItems > 1
                            ? (Theme.of(context).colorScheme ==
                                    ColorScheme.dark()
                                ? Colors.yellow
                                : Theme.of(context).accentColor)
                            : Colors.grey,
                        icon: Icon(
                          Icons.remove_circle_outline,
                          size: 16.0,
                        ),
                        onPressed: widget.cart.numOfItems > 1
                            ? () {
                                setState(() {
                                  widget.cart.numOfItems--;
                                  widget.rebuild(() {});
                                });
                              }
                            : () {},
                      ),
                      Text.rich(
                        TextSpan(
                          text: "${widget.cart.numOfItems}",
                          style: TextStyle(
                              color: Theme.of(context).accentColor,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                      IconButton(
                        color: widget.cart.numOfItems <
                                widget.cart.product.kolicina
                            ? (Theme.of(context).colorScheme ==
                                    ColorScheme.dark()
                                ? Colors.yellow
                                : Theme.of(context).accentColor)
                            : Colors.grey,
                        icon: Icon(
                          Icons.add_circle_outline,
                          size: 16.0,
                        ),
                        onPressed: widget.cart.numOfItems <
                                widget.cart.product.kolicina
                            ? () {
                                setState(() {
                                  widget.cart.numOfItems++;
                                  widget.rebuild(() {});
                                });
                              }
                            : () {},
                      )
                    ]),
              ],
            ),
            if (isWeb) ...[
              IconButton(
                hoverColor: Theme.of(context).primaryColor,
                tooltip: 'Izbaci iz korpe',
                icon: Icon(
                  Icons.delete_outline,
                ),
                color: Theme.of(context).accentColor,
                onPressed: () => widget.rebuild(() {
                  int index = cart.demoCarts.indexOf(widget.cart);
                  Cart carty = cart.removeProduct(index);
                  ScaffoldMessenger.of(context).removeCurrentSnackBar(
                      reason: SnackBarClosedReason.remove);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      action: SnackBarAction(
                        label: "Vrati ${carty.product.naziv} u korpu!",
                        onPressed: () => widget.rebuild(
                            () => cart.insertProductAtIndex(index, carty)),
                      ),
                      content: Text("Uklonili ste ${carty.product.naziv}"),
                      duration: const Duration(milliseconds: 5000),
                      width: MediaQuery.of(context).size.width *
                          0.9, // Width of the SnackBar.
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8.0, // Inner padding for SnackBar content.
                      ),
                      behavior: SnackBarBehavior.floating,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                  );
                }),
              )
            ]
          ],
        ),
      ),
    );
  }
}
