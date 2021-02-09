import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:worldly/controller/auth_controller.dart';
import 'package:worldly/data/data.dart';
import 'package:worldly/screens/home/aboutus.dart';
import 'package:worldly/screens/home/notification.dart';
import 'package:worldly/screens/home/details.dart';
import 'package:worldly/screens/home/my_friend.dart';
import 'package:worldly/screens/home/my_profile.dart';
import 'package:worldly/screens/home/contactinfo.dart';
import 'package:worldly/screens/home/privatepolicy.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:worldly/screens/login/login.dart';
import '../login/login.dart';
import 'adduser.dart';
import 'package:permission_handler/permission_handler.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Future<void> share() async {
    await FlutterShare.share(
        title: 'Wordly',
        text: 'Upload a playstore then will get a link',
        linkUrl: 'https://t.me/sanaapp',
        chooserTitle: 'Example Chooser Title');
  }

  String messageTitle = "Empty";
  String notificationAlert = "alert";
  final AuthController authController = Get.put(AuthController());
  FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  getpermission() async {
    var status = await Permission.storage.status;
    if (status.isUndetermined) {
      Map<Permission, PermissionStatus> statuses = await [
        Permission.storage,
      ].request();
    }
  }

  @override
  void initState() {
    super.initState();
    _firebaseMessaging.getToken().then((token) => print(token));
    _firebaseMessaging.configure(
      onMessage: (message) async {
        setState(() {
          messageTitle = message["notification"]["title"];
          notificationAlert = "New Notification Alert";
        });
        print(messageTitle);
      },
      onResume: (message) async {
        setState(() {
          messageTitle = message["data"]["title"];
          notificationAlert = "Application opened from Notification";
        });
        print(messageTitle);
      },
    );
    getpermission();
  }

  Accounts accounts = Accounts();
  Store store = Store();
  String searchvalue = "";
  GlobalKey<ScaffoldState> drawerKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFFFFFF),
      key: drawerKey,
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text('Wordly', style: TextStyle(color: Color(0xFFFFFFFF))),
        bottom: PreferredSize(
          preferredSize: Size(50, 50),
          child: Container(
            height: 42.8,
            margin: const EdgeInsets.all(7.8),
            child: TextField(
              autocorrect: true,
              decoration: InputDecoration(
                  suffixIcon: Icon(
                    EvaIcons.search,
                    color: Color(0xFF000000),
                  ),
                  hintText: 'Search people by Name and Skills',
                  hintStyle: TextStyle(
                      color: Colors.grey, fontSize: 14, fontFamily: 'Roboto'),
                  filled: true,
                  fillColor: Colors.white,
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    borderSide: BorderSide(color: Colors.blue, width: 1.2),
                  ),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      borderSide: BorderSide(color: Colors.black, width: 1.2))),
              onChanged: (value) {
                setState(() {
                  searchvalue = value;
                });
              },
            ),
          ),
        ),
        brightness: Brightness.light,
        elevation: 0,
        actionsIconTheme: IconThemeData(color: Colors.white),
        iconTheme: IconThemeData(color: Colors.white),
        leading: IconButton(
          onPressed: () {
            drawerKey.currentState.openDrawer();
          },
          icon: Icon(EvaIcons.menu, color: Color(0xFFFFFFFFF)),
        ),
        actions: [
          IconButton(
              icon: Icon(EvaIcons.bellOutline),
              onPressed: () {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => Notifications()));
              })
        ],
      ),
      drawerEdgeDragWidth: 0,
      drawer: Drawer(
        child: ListView(children: [
          UserAccountsDrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
            currentAccountPicture: ClipRRect(
              borderRadius: BorderRadius.circular(110),
              child: FutureBuilder(
                  future: authController.getprofileimages(),
                  builder: (context, snapshot) {
                    if (snapshot.data == "null") {
                      return CircleAvatar(
                        backgroundColor: Colors.white,
                        child: Center(
                            child: Icon(
                          EvaIcons.personOutline,
                          size: 50,
                        )),
                      );
                    }
                    return Image.network(
                      snapshot.data,
                      fit: BoxFit.cover,
                    );
                  }),
            ),
            accountEmail: FutureBuilder(
                future: store.getstring("email"),
                builder: (context, snapshot) {
                  if (snapshot.data == null) {
                    return Text(" ");
                  }
                  return Text(snapshot.data.toString());
                }),
            accountName: FutureBuilder(
                future: store.getstring("username"),
                builder: (context, snapshot) {
                  print("datais" + snapshot.data.toString());
                  if (snapshot.data == null) {
                    return Text(" ");
                  }
                  return Text(snapshot.data.toString());
                }),
          ),
          Container(
            color: Color(0xFFFFFFFF),
            child: ListTile(
              title: new Text(
                'Home',
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Colors.black),
              ),
              leading: SvgPicture.asset(
                'assets/icons/home.svg',
                height: 20.0,
                width: 20.0,
                color: Color(0xFF0068A5),
                allowDrawingOutsideViewBox: true,
              ),
              onTap: () {
                Navigator.of(context).pop();
                //Navigator.of(context).pushNamed('home');
              },
            ),
          ),
          Container(
            color: Color(0xFFFFFFFF),
            child: ListTile(
              title: new Text(
                'My Profile',
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Colors.black),
              ),
              leading: SvgPicture.asset(
                'assets/icons/user.svg',
                height: 20.0,
                width: 20.0,
                color: Color(0xFF0068A5),
                allowDrawingOutsideViewBox: true,
              ),
              onTap: () {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => MyProfile()));
                //Navigator.of(context).pushNamed('home');
              },
            ),
          ),
          Container(
            color: Color(0xFFFFFFFF),
            child: ListTile(
              title: new Text(
                'My Friend',
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Colors.black),
              ),
              leading: SvgPicture.asset(
                'assets/icons/verify.svg',
                height: 20.0,
                width: 20.0,
                color: Color(0xFF0068A5),
                allowDrawingOutsideViewBox: true,
              ),
              onTap: () {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => MyFriend()));
                //Navigator.of(context).pushNamed('home');
              },
            ),
          ),
          Container(
            color: Color(0xFFFFFFFF),
            child: ListTile(
              title: new Text(
                'Private policy',
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Colors.black),
              ),
              leading: SvgPicture.asset(
                'assets/icons/insurance.svg',
                height: 20.0,
                width: 20.0,
                color: Color(0xFF0068A5),
                allowDrawingOutsideViewBox: true,
              ),
              onTap: () {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => PrivatePolicy()));
                //Navigator.of(context).pushNamed('home');
              },
            ),
          ),
          Container(
            color: Color(0xFFFFFFFF),
            child: ListTile(
              title: new Text(
                'Share App',
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Colors.black),
              ),
              leading: SvgPicture.asset(
                'assets/icons/share.svg',
                height: 20.0,
                width: 20.0,
                color: Color(0xFF0068A5),
                allowDrawingOutsideViewBox: true,
              ),
              onTap: share,
            ),
          ),
          Container(
            color: Color(0xFFFFFFFF),
            child: ListTile(
              title: new Text(
                'Contact Info',
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Colors.black),
              ),
              leading: SvgPicture.asset(
                'assets/icons/contact.svg',
                height: 20.0,
                width: 20.0,
                color: Color(0xFF0068A5),
                allowDrawingOutsideViewBox: true,
              ),
              onTap: () {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => ContactInfo()));
                //Navigator.of(context).pushNamed('home');
              },
            ),
          ),
          Container(
            color: Color(0xFFFFFFFF),
            child: ListTile(
              title: new Text(
                'About Us',
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Colors.black),
              ),
              leading: SvgPicture.asset(
                'assets/icons/information.svg',
                height: 20.0,
                width: 20.0,
                color: Color(0xFF0068A5),
                allowDrawingOutsideViewBox: true,
              ),
              onTap: () {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => AboutUs()));
                //Navigator.of(context).pushNamed('home');
              },
            ),
          ),
          Container(
            color: Color(0xFFFFFFFF),
            child: ListTile(
              title: new Text(
                'Log out',
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Colors.black),
              ),
              leading: SvgPicture.asset(
                'assets/icons/log-out.svg',
                height: 20.0,
                width: 20.0,
                color: Color(0xFF0068A5),
                allowDrawingOutsideViewBox: true,
              ),
              onTap: () {
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text(
                          'Worldy',
                          style: TextStyle(
                              color: Colors.black, fontWeight: FontWeight.bold),
                        ),
                        content: Text('Thank you'),
                        actions: [
                          FlatButton(
                            onPressed: () async {
                              SharedPreferences prefs =
                                  await SharedPreferences.getInstance();
                              prefs.clear();
                              Navigator.of(context).pushAndRemoveUntil(
                                  MaterialPageRoute(
                                      builder: (context) => Login()),
                                  (Route<dynamic> route) => false);
                            },
                            child: Text('Logout'.toUpperCase(),
                                style: TextStyle(
                                    color: Colors.red,
                                    fontWeight: FontWeight.w800,
                                    fontSize: 15)),
                          ),
                          FlatButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Text('Cancel'.toUpperCase(),
                                style: TextStyle(
                                    color: Colors.red,
                                    fontWeight: FontWeight.w800,
                                    fontSize: 15)),
                          ),
                        ],
                      );
                    });
                //Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> Login()));
                //Navigator.of(context).pushNamed('home');
              },
            ),
          ),
        ]),
      ),
      body: Container(
        child: (searchvalue.isNotEmpty)
            ? FutureBuilder(
                future: authController.search(searchvalue),
                builder: (context, snapshot) {
                  if (snapshot.data == null) {
                    return Center(child: const CircularProgressIndicator());
                  }
                  if (snapshot.data.length == 0) {
                    return Center(
                        child: Text(
                      "No Results Found",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ));
                  }
                  return ListView.builder(
                      itemCount: snapshot.data.length,
                      itemBuilder: (context, idx) {
                        print(snapshot.data[idx]);
                        return InkWell(
                          onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      Details(val: snapshot.data[idx]['id']))),
                          child: Container(
                            width: double.infinity,
                            padding: const EdgeInsets.all(8.0),
                            margin: const EdgeInsets.all(8.0),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10.0),
                                boxShadow: [
                                  BoxShadow(
                                      offset: Offset(10, 10),
                                      color: Colors.black45.withOpacity(0.35),
                                      blurRadius: 20.0),
                                  BoxShadow(
                                      offset: Offset(-10, -10),
                                      color: Colors.white,
                                      blurRadius: 20.0),
                                ]),
                            child: Row(
                              children: [
                                Container(
                                    height: 60,
                                    width: 60,
                                    decoration: BoxDecoration(
                                      color:
                                          Color(0xFF0068A5).withOpacity(0.15),
                                      borderRadius: BorderRadius.circular(10.0),
                                      // image: DecorationImage(
                                      //   image: NetworkImage(snapshot.data[idx]['profileimg']),
                                      //   fit: BoxFit.cover
                                      // ),
                                    ),
                                    child: Container(
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(),
                                        child: (snapshot.data[idx]
                                                    ['profileimg'] ==
                                                "null")
                                            ? ((snapshot.data[idx]['value'] !=
                                                    null)
                                                ? Text(
                                                    snapshot.data[idx]['value']
                                                            [0]
                                                        .toString()
                                                        .toUpperCase(),
                                                    style: TextStyle(
                                                        color:
                                                            Colors.blueAccent,
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  )
                                                : Icon(EvaIcons.person))
                                            : Container(
                                                height: 60,
                                                width: 60,
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10.0),
                                                    image: DecorationImage(
                                                        image: NetworkImage(
                                                            snapshot.data[idx]
                                                                ['profileimg']),
                                                        fit: BoxFit.cover)),
                                                //child: Image.network(snapshot.data[idx]['profileimg'], fit: BoxFit.fill)
                                              ))),
                                SizedBox(width: 20.0),
                                Container(
                                  child: Row(
                                    children: [
                                      Text(
                                          (snapshot.data[idx]['value'] != null)
                                              ? snapshot.data[idx]['value']
                                              : "",
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.w500,
                                              fontSize: 16)),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      });
                })
            : Center(
                child: ClipRRect(
                  child: Image.asset('assets/images/mainimage.jpeg',
                      width: 500, height: 500, fit: BoxFit.contain),
                ),
              ),
      ),
    );
  }
}
