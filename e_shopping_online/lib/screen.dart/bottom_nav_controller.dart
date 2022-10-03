import 'package:e_shopping_online/screen.dart/navigator_pages/cart_screen.dart';
import 'package:e_shopping_online/screen.dart/navigator_pages/favourites_screen.dart';
import 'package:e_shopping_online/screen.dart/navigator_pages/home_screen.dart';
import 'package:e_shopping_online/screen.dart/navigator_pages/profile_screen.dart';
import 'package:e_shopping_online/widgets/app_colors.dart';
import 'package:flutter/material.dart';

class BottomNavController extends StatefulWidget {
  const BottomNavController({super.key});

  @override
  State<BottomNavController> createState() => _BottomNavControllerState();
}

class _BottomNavControllerState extends State<BottomNavController> {
  final _pages = [
    const HomeScreen(),
    const CartScreen(),
    const Favourites(),
    const ProfileScreen()
  ];
  var _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("Healthy Bites",
                style: TextStyle(color: myred, letterSpacing: 1, fontSize: 24)),
            Icon(
              Icons.food_bank_outlined,
              color: myred,
              size: 30,
            )
          ],
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      bottomNavigationBar: BottomNavigationBar(
        elevation: 5,
        selectedItemColor: myred,
        backgroundColor: Colors.white,
        unselectedItemColor: Colors.grey,
        currentIndex: _currentIndex,
        selectedLabelStyle:
            const TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Home",
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.favorite_outline), label: "Favourite"),
          BottomNavigationBarItem(
            icon: Icon(Icons.add_shopping_cart),
            label: "Cart",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: "Person",
          ),
        ],
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
      body: _pages[_currentIndex],
    );
  }
}
