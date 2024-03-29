import 'package:app/components/cart_icon.dart';
import 'package:app/components/customAppBar.dart';
import 'package:app/components/navigationBar.dart';
import 'package:app/components/responsive_layout.dart';
import 'package:app/main.dart';
import 'package:app/model/proizvodiModel.dart';
import 'package:app/screens/home/components/body.dart';
import 'package:flutter/material.dart';

import '../../components/drawer.dart';

class HomeScreenLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    if (ResponsiveLayout.isIphone(context)) {
      return Scaffold(
        appBar: CustomAppBar(),
        body: Body(),
        drawer: ListenToDrawerEvent(),
        extendBody: true,
        bottomNavigationBar:
            ResponsiveLayout.isIphone(context) ? NavigationBarWidget() : null,
      );
    } else {
      return Scaffold(
        appBar: CustomAppBar(),
        body: Body(),
      );
    }
  }
}
