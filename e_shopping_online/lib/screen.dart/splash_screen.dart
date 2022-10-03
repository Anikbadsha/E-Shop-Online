import 'package:e_shopping_online/screen.dart/login_screen.dart';
import 'package:e_shopping_online/widgets/app_colors.dart';
import 'package:e_shopping_online/widgets/custom_buttom.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: mywhite,
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 16),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "E-Shopping\nOnline",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 42, color: myred, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 16,
              ),
              customButton("Get Started", () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => LoginScreen()));
              })
            ],
          ),
        ),
      ),
    );
  }
}
