import 'package:app/components/rounded_button.dart';
import 'package:app/constants.dart';
import 'package:app/main.dart';
import 'package:app/model/cart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import 'components/cart_item_card.dart';

class CartScreen extends StatefulWidget {
  //static String routeName = "/cart";

  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    var cart = Provider.of<Carts>(context, listen: true);
    return Scaffold(
      appBar: buildAppBar(context),
      body: Padding(
        padding: EdgeInsets.all(10),
        child: ListView.builder(
          itemCount: cart.demoCarts.length,
          itemBuilder: (context, index) => Padding(
            padding: const EdgeInsets.symmetric(vertical: 10.0),
            child: !isWeb
                ? Dismissible(
                    direction: DismissDirection.endToStart,
                    key: Key(cart.demoCarts[index].product.id.toString()),
                    background: Container(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      decoration: BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.circular(15)),
                      child: Row(
                        children: [
                          Spacer(),
                          SvgPicture.asset(
                            "assets/icons/trash-solid.svg",
                            width: MediaQuery.of(context).size.width * 0.05,
                          )
                        ],
                      ),
                    ),
                    onDismissed: (direction) {
                      setState(() {
                        Cart carty = cart.removeProduct(index);
                        ScaffoldMessenger.of(context).removeCurrentSnackBar(
                            reason: SnackBarClosedReason.remove);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            action: SnackBarAction(
                              label: "Vrati ${carty.product.naziv} u korpu!",
                              onPressed: () => setState(() =>
                                  cart.insertProductAtIndex(index, carty)),
                            ),
                            content:
                                Text("Uklonili ste ${carty.product.naziv}"),
                            duration: const Duration(milliseconds: 5000),
                            width: MediaQuery.of(context).size.width *
                                0.9, // Width of the SnackBar.
                            padding: const EdgeInsets.symmetric(
                              horizontal:
                                  8.0, // Inner padding for SnackBar content.
                            ),
                            behavior: SnackBarBehavior.floating,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                        );
                      });
                    },
                    child: CartItemCard(
                      cart: cart.demoCarts[index],
                      rebuild: setState,
                    ),
                  )
                : CartItemCard(
                    cart: cart.demoCarts[index],
                    rebuild: setState,
                  ),
          ),
        ),
      ),
      extendBody: true,
      bottomNavigationBar: CheckOutCard(),
    );
  }

  AppBar buildAppBar(BuildContext context) {
    var cart = Provider.of<Carts>(context, listen: true);
    return AppBar(
      automaticallyImplyLeading: true,
      leading: IconButton(
          onPressed: () {
            ScaffoldMessenger.of(context)
                .removeCurrentSnackBar(reason: SnackBarClosedReason.remove);
            Navigator.pop(
              context,
            );
          },
          icon: Icon(Icons.arrow_back)),
      centerTitle: true,
      title: Column(
        children: [
          Text(
            "KORPA",
            style: TextStyle(color: kPrimaryLightColor),
          ),
          if (cart.demoCarts.length == 1) ...[
            Text(
              "${cart.demoCarts.length} proizvod",
              style: TextStyle(inherit: false, color: kPrimaryLightColor),
            ),
          ] else ...[
            Text(
              "${cart.demoCarts.length} proizvoda",
              style: TextStyle(inherit: false, color: kPrimaryLightColor),
            )
          ]
        ],
      ),
    );
  }
}

class CheckOutCard extends StatelessWidget {
  const CheckOutCard({
    Key key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    var cart = Provider.of<Carts>(context, listen: true);
    Size size = MediaQuery.of(context).size;
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: 15,
        horizontal: 30,
      ),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme == ColorScheme.dark()
            ? Theme.of(context).primaryColor
            : Theme.of(context).primaryColor,
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30), topRight: Radius.circular(30)),
        boxShadow: [
          BoxShadow(
              offset: Offset(0, -15),
              blurRadius: 20,
              color: Color(0xFFDADADA).withOpacity(0.15)),
        ],
      ),
      child: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                // Container(
                //   height: 40,
                //   width: 40,
                //   decoration: BoxDecoration(
                //     color: Colors.teal.shade400,
                //     borderRadius: BorderRadius.circular(10),
                //   ),
                //   // child: SvgPicture.asset("assets/icons/bill.svg"),
                // ),
                Spacer(),
                Row(
                  children: [
                    Text.rich(
                      TextSpan(
                        text: "Ukupno:   ",
                        style: TextStyle(fontWeight: FontWeight.bold),
                        children: [
                          TextSpan(
                              text: "${cart.sumTotal(cart.demoCarts)} RSD",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              )),
                        ],
                      ),
                    ),
                  ],
                )
              ],
            ),
            SizedBox(
              height: 30,
              width: size.width,
            ),
            RoundedButton(
              text: "KUPI",
              press: () {
                korisnikInfo == null
                    ? Navigator.of(context).pushNamed('/login')
                    : cart.demoCarts.length == 0
                        ? ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text("Nemate proizvode u korpi!"),
                              duration: const Duration(milliseconds: 5000),
                              width: MediaQuery.of(context).size.width *
                                  0.9, // Width of the SnackBar.
                              padding: const EdgeInsets.symmetric(
                                horizontal:
                                    8.0, // Inner padding for SnackBar content.
                              ),
                              behavior: SnackBarBehavior.floating,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                            ),
                          )
                        : filter(context, cart);
              },
              textColor: kPrimaryColor,
              color: Colors.white,
            ),
          ],
        ),
      ),
    );
  }

  filter(BuildContext context, var cart) {
    List<Cart> uklonjeni;
    uklonjeni = cart.filter();
    if (uklonjeni.length != 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Iz korpe su automatski uklonjeni vaši proizvodi!"),
          duration: const Duration(milliseconds: 5000),
          width:
              MediaQuery.of(context).size.width * 0.9, // Width of the SnackBar.
          padding: const EdgeInsets.symmetric(
            horizontal: 8.0, // Inner padding for SnackBar content.
          ),
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
      );
    }
    Navigator.popAndPushNamed(context, '/checkout', arguments: {});
  }
}
