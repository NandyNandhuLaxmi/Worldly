import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:worldly/controller/auth_controller.dart';
import 'package:worldly/screens/home/home.dart';

import '../../data/data.dart';

class PrivatePolicy extends StatefulWidget {
  @override
  _PrivatePolicyState createState() => _PrivatePolicyState();
}

class _PrivatePolicyState extends State<PrivatePolicy> {
  final AuthController authController = Get.put(AuthController());
  Accounts accounts = Accounts();
  String privacy = '';
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => Home())),
      child: Scaffold(
        backgroundColor: Color(0xFFFFFFFF),
        appBar: AppBar(
          backgroundColor: Colors.blue,
          brightness: Brightness.light,
          title: Text(
            'Private Policy',
            style: TextStyle(
              color: Color(0xFFFFFFFF),
            ),
          ),
          leading: (IconButton(
              icon: Icon(EvaIcons.arrowBackOutline),
              onPressed: () => Navigator.pushReplacement(
                  context, MaterialPageRoute(builder: (context) => Home())))),
        ),
        body: SingleChildScrollView(
          child: FutureBuilder(
              future: authController.privacy(privacy),
              builder: (context, snapshot) {
                if (snapshot.data == null) {
                  return Center(
                    child: CircularProgressIndicator(
                        valueColor: new AlwaysStoppedAnimation<Color>(
                            Color(0xFF0068A5))),
                  );
                }
                return Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10.0),
                      child: Text('Privacy Policy',
                          style: TextStyle(
                              color: Color(0xFF000000),
                              fontSize: 18,
                              fontWeight: FontWeight.bold)),
                    ),
                    Container(
                        padding: const EdgeInsets.all(10.0),
                        child: Text(
                            snapshot.data['privacy']
                                .toString()
                                .substring(
                                    3,
                                    snapshot.data['privacy'].toString().length -
                                        6)
                                .trim(),
                            style: TextStyle(
                                color: Color(0xFF000000),
                                fontSize: 15,
                                fontWeight: FontWeight.w500)))
                  ],
                );
              }),
        ),
      ),
    );
  }
}
