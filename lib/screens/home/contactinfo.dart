import 'package:flutter/material.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:worldly/controller/auth_controller.dart';
import 'package:worldly/screens/home/home.dart';
import '../../data/data.dart';

class ContactInfo extends StatefulWidget {
  @override
  _ContactInfoState createState() => _ContactInfoState();
}

class _ContactInfoState extends State<ContactInfo> {
  final AuthController authController = Get.put(AuthController());
  Accounts accounts = Accounts();
  String email = '', mobile = ''; 

  _launchURL() async {
  const url = 'mailto:test@gmail.com?subject=Greetings&body=Hello%20World';
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}

  _phoneURL() async {
  const url = 'tel: 9090909090';
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}

  
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () =>  Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => Home())),
      child: Scaffold(
        backgroundColor: Color(0xFFFAFAFA),
          appBar: AppBar(
            backgroundColor: Colors.blue,     
            brightness: Brightness.light,
            elevation: 0,
            title: Text(
              'Contact Info',
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
              future: authController.contactus(email, mobile),
              builder: (context, snapshot) {
                if(snapshot.data == null) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
                return Column(
                children: [
                  Container(
                    width: double.infinity,
                    height: MediaQuery.of(context).size.height * 0.3,
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      image: DecorationImage(
                        image: AssetImage('assets/images/email.png'), fit: BoxFit.contain
                      ),
                      boxShadow: [
                        BoxShadow(
                        offset: Offset(10, 10),
                        color: Colors.black45.withOpacity(0.2),
                        blurRadius: 20.0),
                        BoxShadow(
                        offset: Offset(-10, -10),
                        color: Colors.white24,
                        blurRadius: 20.0),
                      ]
                    ),

                  ),
                  SizedBox(height: 20),
                  GestureDetector(
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        children: [
                           SvgPicture.asset('assets/icons/mail.svg', height: 25, width: 25, color: Colors.black,),
                          SizedBox(height: 10),
                          Text(snapshot.data['email'], style: TextStyle(color: Color(0xFF000000), fontSize: 15, fontWeight: FontWeight.w500)),
                        ],
                      ),
                    ),
                    onTap: _launchURL,
                  ),
                  SizedBox(height: 10),
                  GestureDetector(
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        children: [
                          SvgPicture.asset('assets/icons/smartphone.svg', height: 25, width: 25, color: Colors.black,),
                          SizedBox(height: 10),
                          Text(snapshot.data['mobile'], style: TextStyle(color: Color(0xFF000000), fontSize: 15, fontWeight: FontWeight.w500)),
                        ],
                      ),
                    ),
                    onTap: _phoneURL,
                  ),
                  GestureDetector(
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        children: [
                          SvgPicture.asset('assets/icons/clock.svg', height: 25, width: 25, color: Colors.black,),
                          SizedBox(height: 10),
                          Text('Monday - Friday', style: TextStyle(color: Color(0xFF000000), fontSize: 15, fontWeight: FontWeight.w500)),
                          Text('9am - 5pm', style: TextStyle(color: Color(0xFF000000), fontSize: 15, fontWeight: FontWeight.w500)),
                           SizedBox(height: 10),
                          Text('Saturday - Sunday', style: TextStyle(color: Color(0xFF000000), fontSize: 15, fontWeight: FontWeight.w500)),
                          Text('9am - 12pm', style: TextStyle(color: Color(0xFF000000), fontSize: 15, fontWeight: FontWeight.w500)),
                        ],
                      ),
                    ),
                    onTap: _launchURL,
                  ),
                  // Container(
                  //   width: double.infinity,
                  //   padding: const EdgeInsets.all(10.0),
                  //   decoration: BoxDecoration(
                  //     color: Color(0xFFFFFFFF),
                  //     borderRadius: BorderRadius.circular(10.0),
                  //      boxShadow: [
                  //       BoxShadow(
                  //       offset: Offset(10, 10),
                  //       color: Colors.black45.withOpacity(0.2),
                  //       blurRadius: 20.0),
                  //       BoxShadow(
                  //       offset: Offset(-10, -10),
                  //       color: Colors.white24,
                  //       blurRadius: 20.0),
                  //     ]
                  //   ),
                  //   child: Row(
                  //     children: [
                  //       Icon(EvaIcons.phoneCall),
                  //       SizedBox(width: 10),
                  //       Text(snapshot.data['mobile'], style: TextStyle(color: Color(0xFF000000), fontSize: 15, fontWeight: FontWeight.w500)),
                  //     ],
                  //   ),
                  // ),
                  
                ],
              );
              },
            ),
          ),
      ),
    );
  }
}