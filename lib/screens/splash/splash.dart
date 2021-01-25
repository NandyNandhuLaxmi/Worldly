import 'dart:async';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:worldly/data/data.dart';
import 'package:worldly/screens/home/home.dart';
import 'package:worldly/screens/login/login.dart';

class Splash extends StatefulWidget {
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  _getshare()async{
    Accounts accounts = Accounts();
    bool aulog = await accounts.autologin();
    if (aulog == true) {
      Timer((Duration(seconds: 2)), ()=>Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Home())));

    }else{
      Timer((Duration(seconds: 2)), ()=>Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Login())));
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getshare();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
          color: Colors.white,
          child: Center(
            child: Image.asset('assets/images/logo.png',height: 512,width: 512,),
          ),
        ),
      );
  }
}