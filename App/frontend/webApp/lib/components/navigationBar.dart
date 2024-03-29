import 'package:app/screens/add_product/add_product.dart';
import 'package:app/screens/home/homeScreenLayout.dart';
import 'package:app/screens/notifications/notification_screen.dart';
import 'package:flutter/material.dart';

import '../main.dart';
import 'cart_icon.dart';

class NavigationBarWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      child: Container(
        height: 60,
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(color: Colors.grey),
          ],
          color: Theme.of(context).primaryColor,
          borderRadius: BorderRadius.circular(36),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            IconButton(
              color: Theme.of(context).bottomAppBarColor,
              onPressed: () {
                ModalRoute.of(context).settings.name == "/home"
                    ? Navigator.pushNamed(context, "/home")
                    : Navigator.popAndPushNamed(context, "/home");
              },
              icon: Icon(Icons.home_rounded),
            ),
            IconButton(
              icon: Icon(Icons.favorite_rounded),
              color: Theme.of(context).bottomAppBarColor,
              onPressed: () {
                Navigator.pushNamed(context, '/favorites');
              },
            ),
            korisnikInfo != null
                ? IconButton(
                    icon: Icon(Icons.control_point),
                    iconSize: 40,
                    color: Theme.of(context).bottomAppBarColor,
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => AddProduct()),
                      );
                    },
                  )
                : CartIcon(),
            IconButton(
                icon: Icon(Icons.notifications),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => NotificationScreen()),
                  );
                },
                color: Theme.of(context).bottomAppBarColor),
            IconButton(
                icon: Icon(Icons.person),
                onPressed: () {
                  korisnikInfo != null
                      ? ModalRoute.of(context).settings.name == "/home"
                          ? Navigator.pushNamed(context, "/profile")
                          : Navigator.popAndPushNamed(context, "/profile")
                      : Navigator.pushNamed(context, '/login');
                },
                color: Theme.of(context).bottomAppBarColor)
          ],
        ),
      ),
    );
  }
}
