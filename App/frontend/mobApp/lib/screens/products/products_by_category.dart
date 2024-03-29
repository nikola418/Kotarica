import 'package:app/components/customAppBar.dart';
import 'package:app/components/drawer.dart';
import 'package:app/components/responsive_layout.dart';
import 'package:app/model/proizvodiModel.dart';
import 'package:app/screens/home/components/body.dart';
import 'package:app/screens/home/homeScreenLayout.dart';
import 'package:app/screens/products/productCategoryLayout.dart';
import 'package:flutter/material.dart';

class ProductByCategory extends StatelessWidget {
  final String category;
  int categoryId;
  int potkategorijaId;
  final List<Proizvod> listaProizvoda;
  ProductByCategory(
      {this.potkategorijaId,
      //Key key,
      @required this.category,
      this.listaProizvoda,
      this.categoryId});
  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;
    return Scaffold(
      body: ResponsiveLayout(
        iphone: ProductCategoryLayout(
          category: category,
          listaProizvoda: listaProizvoda,
          categoryId: categoryId,
          potkategorijaId: potkategorijaId,
        ),
        ipad: Row(
          children: [
            // Expanded(
            // flex: 1000,
            //   child:
            ListenToDrawerEvent(),
            // ),
            Expanded(
              flex: _size.width > 1200 && _size.width < 1340 ? 6 : 3,
              child: ProductCategoryLayout(
                category: category,
                listaProizvoda: listaProizvoda,
                categoryId: categoryId,
                potkategorijaId: potkategorijaId,
              ),
            ),
          ],
        ),
        macbook: Row(
          children: [
            //   Padding(padding: EdgeInsets.symmetric(horizontal: 130.0)),
            // Expanded(
            //   // flex: _size.width > 1340 ? 1 : 100,
            //   child:
            ListenToDrawerEvent(),
            // ),
            Expanded(
              flex: _size.width > 1340 ? 6 : 3,
              child: ProductCategoryLayout(
                category: category,
                listaProizvoda: listaProizvoda,
                categoryId: categoryId,
                potkategorijaId: potkategorijaId,
              ),
            ),

            // Padding(
            //   padding: EdgeInsets.symmetric(horizontal: 130.0),
            // ),
          ],
        ),
      ),
    );
  }
}
