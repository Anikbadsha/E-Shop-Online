// ignore_for_file: use_build_context_synchronously

import 'package:e_shopping_online/screen.dart/bottom_nav_controller.dart';
import 'package:e_shopping_online/screen.dart/signup_screen.dart';
import 'package:e_shopping_online/widgets/app_colors.dart';
import 'package:e_shopping_online/widgets/custom_buttom.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  void dispose() {
    _emailController.dispose();
    _passController.dispose();
    super.dispose();
  }

  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passController = TextEditingController();

  var _isobscure = true;
  signIn() async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(
              email: _emailController.text, password: _passController.text);
      var authCredential = userCredential.user;
      if (authCredential!.uid.isNotEmpty) {
        Navigator.push(
            context, CupertinoPageRoute(builder: (_) => BottomNavController()));
      } else {
        Fluttertoast.showToast(msg: "Something is wrong");
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        Fluttertoast.showToast(msg: "No user found for that email.");
      } else if (e.code == 'wrong-password') {
        Fluttertoast.showToast(msg: "Wrong password provided for that user.");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Container(
          height: ScreenUtil().screenHeight,
          margin: EdgeInsets.symmetric(horizontal: 16),
          width: ScreenUtil().screenWidth,
          child: Column(
            children: [
              SizedBox(
                height: 150.h,
                width: ScreenUtil().screenWidth,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Sign in",
                            style: TextStyle(
                                color: myred,
                                fontSize: 36.sp,
                                fontWeight: FontWeight.bold),
                          ),
                          IconButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              icon: Icon(Icons.close)),
                        ],
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      Text(
                        "Please sign in with you email and Password",
                        style: TextStyle(
                          color: myred,
                          fontSize: 16.sp,
                        ),
                      ),
                    ]),
              ),
              Form(
                  key: _formkey,
                  child: SizedBox(
                    height: 250.h,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextFormField(
                          controller: _emailController,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(25)),
                              hintStyle: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16,
                                  color: myred),
                              prefixIcon: IconButton(
                                  onPressed: () {}, icon: Icon(Icons.email)),
                              hintText: "Enter you email",
                              filled: true,
                              fillColor: mypink),
                          style: TextStyle(color: myred),
                        ),
                        SizedBox(
                          height: 16,
                        ),
                        TextFormField(
                          obscureText: _isobscure,
                          controller: _passController,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(25)),
                              hintStyle: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16,
                                  color: myred),
                              prefixIcon: IconButton(
                                  onPressed: () {
                                    setState(() {
                                      _isobscure = false;
                                    });
                                  },
                                  icon: Icon(_isobscure == true
                                      ? Icons.visibility
                                      : Icons.visibility_off)),
                              hintText: "Enter your password",
                              filled: true,
                              fillColor: mypink),
                          style: TextStyle(color: myred),
                        ),
                      ],
                    ),
                  )),
              Container(
                margin: EdgeInsets.only(bottom: 20),
                child: customButton("Sign in", () {
                  signIn();
                }),
              ),
              SizedBox(
                height: 16,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      "Remember Me",
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                          color: myred),
                    ),
                    Spacer(),
                    Text(
                      "Forget Password?",
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                          color: myred),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 32,
              ),
              Row(
                children: [
                  Text(
                    "Don't you have an account?",
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                        color: myred),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => SignUpScreen()));
                    },
                    child: Text(
                      "Sign up",
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 24,
                          color: myred),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
