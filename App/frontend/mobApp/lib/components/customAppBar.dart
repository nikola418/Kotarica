import 'package:app/components/responsive_layout.dart';
import 'package:app/main.dart';
import 'package:app/screens/home/homeScreenLayout.dart';
import 'package:app/screens/notifications/notification_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'cart_icon.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  Widget build(BuildContext context) {
    // Future procitajPodatke() async {
    //   var token = await FlutterSession().get('email');
    //   return token.toString();
    // }

    // var token;
    // procitajPodatke().then((value) {
    //   token = value;
    // });

    return AppBar(
      elevation: 0,
      leading: Builder(
        builder: (BuildContext context) {
          return IconButton(
            icon: SvgPicture.asset('assets/icons/menu.svg'),
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
            tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
          );
        },
      ),
      actions: [
        Row(
          children: [
            if (!isWeb) ...[
              MaterialButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/home');
                  },
                  child: Text(
                    'Kotarica',
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontStyle: FontStyle.italic,
                      fontSize: 25,
                      color: Colors.white,
                    ),
                  )),
            ],
            //  IconButton(
            //           icon: Icon(
            //             Icons.person_outline,
            //           ),
            //           onPressed: () {
            //             if (korisnikInfo != null) {
            //               Navigator.pushNamed(context, '/profile');
            //             } else {
            //               Navigator.pushNamed(context, '/login');
            //             }
            //           })

            if (korisnikInfo != null && isWeb) ...[
              IconButton(
                  icon: Icon(
                    Icons.notifications_none_rounded,
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return NotificationScreen();
                        },
                      ),
                    );
                  }),
            ],
            // !ResponsiveLayout.isIphone(context)
            //     ? IconButton(
            //         icon: Icon(
            //           Icons.favorite_outline_rounded,
            //         ),
            //         onPressed: () {
            //           Navigator.pushNamed(context, '/favorites');
            //         })
            //     : Container(),
            if (isWeb) CartIcon(),
            if (korisnikInfo != null && !isWeb) CartIcon(),
            !ResponsiveLayout.isIphone(context)
                ? SizedBox(
                    width: 15,
                  )
                : SizedBox(
                    width: 0,
                  ),
          ],
        ),
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
