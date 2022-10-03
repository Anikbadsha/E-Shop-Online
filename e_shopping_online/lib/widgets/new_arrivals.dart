import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NewArrivals extends StatefulWidget {
  const NewArrivals({super.key});

  @override
  State<NewArrivals> createState() => _NewArrivalsState();
}

class _NewArrivalsState extends State<NewArrivals> {
  List _products = [];
  var _firestoreInstance = FirebaseFirestore.instance;

  fetchProducts() async {
    QuerySnapshot qn =
        await _firestoreInstance.collection("product-images").get();

    setState(() {
      for (int i = 0; i < qn.docs.length; i++) {
        _products.add({
          "product-name": qn.docs[i]["product-name"],
          "product-description": qn.docs[i]["product-description"],
          "product-price": qn.docs[i]["product-price"],
          "product-img": qn.docs[i]["product-img"],
        });
      }
    });
    log("Response=======> $_products");

    return qn.docs;
  }

  void initState() {
    fetchProducts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        itemCount: _products.length,
        itemBuilder: (_, index) {
          return ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Card(
              child: Container(
                  width: 130.w,
                  height: 180.h,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Expanded(
                        flex: 8,
                        child: Container(
                          height: 120.h,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: NetworkImage(
                                      "${_products[index]["product-img"][0]}"),
                                  fit: BoxFit.cover)),
                        ),
                      ),
                      Expanded(
                          flex: 4,
                          child: Container(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                    textAlign: TextAlign.center,
                                    "${_products[index]['product-name']}"),
                                Text(
                                    textAlign: TextAlign.center,
                                    "\$ ${_products[index]['product-price']}"),
                              ],
                            ),
                          )),
                    ],
                  )),
            ),
          );
        });
  }
}
