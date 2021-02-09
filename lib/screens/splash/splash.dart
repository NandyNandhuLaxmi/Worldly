import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:worldly/controller/auth_controller.dart';
import 'package:worldly/data/data.dart';
import 'package:worldly/screens/home/home.dart';
import 'package:worldly/screens/login/login.dart';

import '../home/home.dart';

class Splash extends StatefulWidget {
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  final AuthController authController = Get.put(AuthController());
  _getshare() async {
    bool aulog = await authController.autologin();
    if (aulog == true) {
      Timer((Duration(seconds: 2)), () => Get.off(Home()));
    } else {
      Timer((Duration(seconds: 2)), () => Get.off(Login()));
    }
  }

  @override
  void initState() {
    super.initState();
    _getshare();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        bottom: false,
        top: false,
        child: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/logo.png'),
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }
}
