import 'dart:developer';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:e_shopping_online/screen.dart/search_screen.dart';
import 'package:e_shopping_online/widgets/app_colors.dart';
import 'package:e_shopping_online/widgets/new_arrivals.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<String> _carouselImages = [];
  var _dotPosition = 0;
  List _products = [];
  var _firestoreInstance = FirebaseFirestore.instance;

  fetchCarouselImages() async {
    QuerySnapshot qn =
        await _firestoreInstance.collection("carousel-images").get();
    setState(() {
      for (int i = 0; i < qn.docs.length; i++) {
        _carouselImages.add(
          qn.docs[i]["img-path"],
        );
        print(qn.docs[i]["img-path"]);
      }
    });

    return qn.docs;
  }

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

  @override
  void initState() {
    fetchCarouselImages();
    fetchProducts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var index;
    return Scaffold(
        body: SafeArea(
            child: Container(
                margin: EdgeInsets.symmetric(horizontal: 16),
                padding: EdgeInsets.only(top: 20),
                child: Column(children: [
                  TextFormField(
                    readOnly: true,
                    decoration: InputDecoration(
                      fillColor: Colors.white,
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(0)),
                          borderSide: BorderSide(color: myred)),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(0)),
                          borderSide: BorderSide(color: mypink)),
                      hintText: "Search products here",
                      hintStyle: TextStyle(fontSize: 15.sp),
                      suffixIcon: Icon(
                        Icons.search,
                        size: 25.h,
                        color: myred,
                      ),
                    ),
                    onTap: () => Navigator.push(context,
                        CupertinoPageRoute(builder: (_) => SearchScreen())),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  AspectRatio(
                    aspectRatio: 3.5,
                    child: CarouselSlider(
                        items: _carouselImages
                            .map((item) => Padding(
                                  padding:
                                      const EdgeInsets.only(left: 3, right: 3),
                                  child: Container(
                                    decoration: BoxDecoration(
                                        image: DecorationImage(
                                            image: NetworkImage(item),
                                            fit: BoxFit.fitWidth)),
                                  ),
                                ))
                            .toList(),
                        options: CarouselOptions(
                            autoPlay: false,
                            enlargeCenterPage: true,
                            viewportFraction: 0.8,
                            enlargeStrategy: CenterPageEnlargeStrategy.height,
                            onPageChanged: (val, carouselPageChangedReason) {
                              setState(() {
                                _dotPosition = val;
                              });
                            })),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  DotsIndicator(
                    dotsCount: _carouselImages.length == 0
                        ? 1
                        : _carouselImages.length,
                    position: _dotPosition.toDouble(),
                    decorator: DotsDecorator(
                      activeColor: myred,
                      color: mypink,
                      spacing: EdgeInsets.all(2),
                      activeSize: Size(8, 8),
                      size: Size(6, 6),
                    ),
                  ),
                  SizedBox(
                    height: 15.h,
                  ),
                  Container(
                    height: 40,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "New Arrivals",
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: myred),
                        ),
                        GestureDetector(
                          onTap: () {},
                          child: Text(
                            "See more",
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: myred),
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 8.h,
                  ),
                  Flexible(
                    child: SizedBox(
                      height: 180,
                      child: NewArrivals(),
                    ),
                  )
                ]))));
  }
}
