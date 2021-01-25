import 'dart:async';

import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:worldly/data/data.dart';
import 'package:worldly/screens/home/my_profile.dart';
import 'package:image_pickers/image_pickers.dart';
import 'dart:io';

import 'home.dart';

class AddUser extends StatefulWidget {
  @override
  _AddUserState createState() => _AddUserState();
}

class _AddUserState extends State<AddUser> {
  TextEditingController name = TextEditingController();
  TextEditingController about = TextEditingController();
  TextEditingController skill = TextEditingController();
  TextEditingController id = TextEditingController();
  Accounts accounts = Accounts();
  File _image;
  bool isimage = false;
  String username = "";

  final RoundedLoadingButtonController _btnController =
      new RoundedLoadingButtonController();

  void _doSomething() async {
    Timer(Duration(seconds: 3), () {
      _btnController.success();
    });
  }

  initState() {
    getuser();
    super.initState();
  }

  getuser() async {
    Store store = Store();
    String id = await store.getstring("userid");
    var userdata = await accounts.getprofile(id);
    print(userdata.toString()+"gggggggggggggg");
    String user = await store.getstring("username");
    setState(() {
      about.text = userdata['about'];
      name.text = user;

    });
  }

  Future getImage() async {
    try {
      ImagePickers.pickerPaths().then((List medias) {
        print(medias[0].path.toString() + "pathis");
        setState(() {
          _image = File((medias[0]).path);
          isimage = true;
        });
      });
    } catch (e) {}
  }
bool clicked = false;
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => MyProfile())),
      child: Scaffold(
        backgroundColor: Color(0xFFFFFFFF),
        appBar: AppBar(
          backgroundColor: Colors.blue,
          brightness: Brightness.light,
          elevation: 0,
          actionsIconTheme: IconThemeData(color: Colors.white),
          iconTheme: IconThemeData(color: Colors.white),
          title: Text(
            'Edit Profile',
            style: TextStyle(
              color: Color(0xFFFFFFFF),
            ),
          ),
          leading: (IconButton(
              icon: Icon(EvaIcons.arrowBackOutline),
              onPressed: () => Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => MyProfile())))),
        ),
        body: Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            children: [
              InkWell(
                onTap: () {
                  getImage();
                },
                child: (isimage == false)
                    ? Container(
                        width: 100,
                        height: 100,
                        child: Center(
                          child: Icon(Icons.add_a_photo_outlined),
                        ),
                      )
                    : Container(
                        width: 100,
                        height: 100,
                        decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.all(Radius.circular(100)),
                            image: DecorationImage(
                                image: FileImage(_image), fit: BoxFit.cover)),
                      ),
              ),
              Container(
                height: 42.8,
                margin: const EdgeInsets.all(7.8),
                child: TextField(
                  autocorrect: true,
                  controller: name,
                  decoration: InputDecoration(
                      hintText: 'Name',
                      hintStyle: TextStyle(
                          color: Colors.grey,
                          fontSize: 14,
                          fontFamily: 'Roboto'),
                      filled: true,
                      fillColor: Colors.white,
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        borderSide:
                            BorderSide(color: Color(0xFFE7E7E7), width: 1.2),
                      ),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                          borderSide: BorderSide(
                              color: Color(0xFFE7E7E7), width: 1.2))),
                ),
              ),
              // Container(
              //   height: 42.8,
              //   margin: const EdgeInsets.all(7.8),
              //   child: TextField(
              //     autocorrect: true,
              //     controller: id,
              //     decoration: InputDecoration(
              //         hintText: 'skill id',
              //         hintStyle: TextStyle(color: Colors.grey, fontSize: 14, fontFamily: 'Roboto'),
              //         filled: true,
              //         fillColor: Colors.white,
              //         enabledBorder: OutlineInputBorder(
              //           borderRadius: BorderRadius.all(Radius.circular(10.0)),
              //           borderSide: BorderSide(color: Color(0xFFE7E7E7), width: 1.2),
              //         ),
              //         focusedBorder: OutlineInputBorder(
              //             borderRadius: BorderRadius.all(Radius.circular(10.0)),
              //             borderSide: BorderSide(color: Color(0xFFE7E7E7), width: 1.2))),
              //   ),
              // ),
              // Container(
              //   height: 42.8,
              //   margin: const EdgeInsets.all(7.8),
              //   child: TextField(
              //     autocorrect: true,
              //     controller: skill,
              //     decoration: InputDecoration(
              //         hintText: 'Skill',
              //         hintStyle: TextStyle(
              //             color: Colors.grey,
              //             fontSize: 14,
              //             fontFamily: 'Roboto'),
              //         filled: true,
              //         fillColor: Colors.white,
              //         enabledBorder: OutlineInputBorder(
              //           borderRadius: BorderRadius.all(Radius.circular(10.0)),
              //           borderSide:
              //               BorderSide(color: Color(0xFFE7E7E7), width: 1.2),
              //         ),
              //         focusedBorder: OutlineInputBorder(
              //             borderRadius: BorderRadius.all(Radius.circular(10.0)),
              //             borderSide: BorderSide(
              //                 color: Color(0xFFE7E7E7), width: 1.2))),
              //   ),
              // ),
              Container(
                margin: const EdgeInsets.all(7.8),
                child: TextField(
                  minLines: 10,
                  maxLines: 15,
                  autocorrect: false,
                  controller: about,
                  decoration: InputDecoration(
                    hintText: 'About us',
                    hintStyle: TextStyle(
                        color: Colors.grey, fontSize: 14, fontFamily: 'Roboto'),
                    filled: true,
                    fillColor: Colors.white,
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      borderSide:
                          BorderSide(color: Color(0xFFE7E7E7), width: 1.2),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      borderSide:
                          BorderSide(color: Color(0xFFE7E7E7), width: 1.2),
                    ),
                  ),
                ),
              ),

              Container(
                width: 410,
                height: 52.0,
                child: RaisedButton(
                    hoverColor: Colors.black,
                    shape: RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(30.0)),
                    child: (clicked == false)?Text(
                      "update",
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Colors.white),
                    )
                    : CircularProgressIndicator(backgroundColor: Colors.white,),
                    color: Colors.blue,
                    textColor: Colors.black,
                    splashColor: Colors.white,
                    onPressed: () async {
                      _doSomething();
                      if (name.text.isNotEmpty &&
                          about.text.isNotEmpty ) {
                        setState(() {
                          clicked = true;
                        });
                        showToastMessage("wait a few mins...");
                        accounts.asyncFileUpload(_image);
                        bool val =
                            await accounts.updateuser(name.text, about.text);
                        if (val == true) {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => MyProfile()));
                        }if (val == false) {
                          setState(() {
                            clicked = false;
                          });
                          showToastMessage("something went Wrong");
                        }

                        setState(() {});
                      }else{
                        showToastMessage("All fields are required");
                      }
                    }),
              ),
            ]),
      ),
    );
  }
}

void showToastMessage(String message) {
  Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.grey,
      textColor: Colors.white,
      fontSize: 16.0);
}
