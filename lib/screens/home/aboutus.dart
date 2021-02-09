import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:worldly/controller/auth_controller.dart';
import 'package:get/get.dart';
import '../../data/data.dart';
import 'home.dart';

class AboutUs extends StatefulWidget {
  @override
  _AboutUsState createState() => _AboutUsState();
}

class _AboutUsState extends State<AboutUs> {
  final AuthController authController = Get.put(AuthController());
  Accounts accounts = Accounts();
  String about = " ";

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => Home())),
      child: Scaffold(
        backgroundColor: Color(0xFFFAFAFA),
        appBar: AppBar(
          backgroundColor: Colors.blue,     
          brightness: Brightness.light,
          elevation: 0,
          title: Text(
            'About Us',
            style: TextStyle(
              color: Color(0xFFFFFFFF),
            ),
          ),
          actionsIconTheme: IconThemeData(color: Colors.white),
          iconTheme: IconThemeData(color: Colors.white),
          leading: (
            IconButton(icon: Icon(EvaIcons.arrowBackOutline), onPressed: () => Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Home())))
          ),
        ),
        body: SingleChildScrollView(
          child: FutureBuilder(
            future: authController.aboutus(about),
            builder: (context, snapshot) {
              if(snapshot.data == null) {
                return Center(
                  child: CircularProgressIndicator(valueColor: new AlwaysStoppedAnimation<Color>(Color(0xFF0068A5))),
                );
              }
              return Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(10.0),
                    child: Text('About US', style: TextStyle(color: Color(0xFF000000), fontSize: 18, fontWeight: FontWeight.bold)),
                  ),
                  Container(
                    padding: const EdgeInsets.all(10.0),
                    child: Text(snapshot.data['about'].substring(3).trim(), style: TextStyle(color: Color(0xFF000000), fontSize: 15, fontWeight: FontWeight.w500))
                  )
                ],
              );
            }
          ),
        ),
      ),
    );
  }
}