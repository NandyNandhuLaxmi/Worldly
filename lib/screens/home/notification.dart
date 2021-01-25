import 'dart:async';

import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:worldly/data/data.dart';
import 'package:sweetsheet/sweetsheet.dart';
import 'package:worldly/screens/home/home.dart';
import 'package:worldly/screens/home/my_friend.dart';

import 'details.dart';

class Notifications extends StatefulWidget {
  @override
  _NotificationsState createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
  final SweetSheet _sweetSheet = SweetSheet();

  StreamController _postsController;
  final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();

  int count = 1;

  Accounts accounts = Accounts();
  String id = '';

  loadPosts() async {
    accounts.requestlist().then((res) async {
      _postsController.add(res);
      return res;
    });
  }

  Future<Null> _handleRefresh() async {
    count++;
    print(count);
    accounts.requestlist().then((res) async {
      _postsController.add(res);
      //showSnack();
      return null;
    });
  }

  @override
  void initState() {
    _postsController = new StreamController();
    loadPosts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => Navigator.pushAndRemoveUntil(context,
          MaterialPageRoute(builder: (context) => Home()), (route) => false),
      child: Scaffold(
        appBar: AppBar(
          title: Text("Notifications"),
          leading: IconButton(icon: Icon(Icons.arrow_back),onPressed: ()=>Navigator.pushAndRemoveUntil(context,
              MaterialPageRoute(builder: (context) => Home()), (route) => false),),
        ),
        body: FutureBuilder(
          future: accounts.requestlist(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              return Column(
                children: [
                  Expanded(
                    child: Scrollbar(
                      child: RefreshIndicator(
                        onRefresh: _handleRefresh,
                        child: ListView.builder(
                          physics: const AlwaysScrollableScrollPhysics(),
                          itemCount: snapshot.data.length,
                          itemBuilder: (context, index) {
                            return FutureBuilder(
                                future: accounts.getprofile(
                                    snapshot.data[index].toString()),
                                builder: (context, snap) {
                                  if (snap.data != null) {
                                    if (snap.data.isNotEmpty) {
                                      print(snapshot.data.toString() +
                                          "ffffffff");
                                      return Container(
                                        width:MediaQuery.of(context).size.width*.5,
                                        padding: const EdgeInsets.all(8.0),
                                        margin: const EdgeInsets.all(8.0),
                                        decoration: BoxDecoration(
                                            color:
                                                Color.fromRGBO(43, 67, 67, 1),
                                            borderRadius:
                                                BorderRadius.circular(10.0),
                                            boxShadow: [
                                              BoxShadow(
                                                  offset: Offset(10, 10),
                                                  color: Colors.black45
                                                      .withOpacity(0.35),
                                                  blurRadius: 20.0),
                                              BoxShadow(
                                                  offset: Offset(-10, -10),
                                                  color: Colors.white,
                                                  blurRadius: 20.0),
                                            ]),
                                        child: Column(
                                          children: [
                                            InkWell(
                                              onTap: () {
                                                String id = snapshot.data[index]
                                                    ['userid'];
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            Details(val: id)));
                                              },
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Row(
                                                  children: [
                                                    Container(
                                                      height: 60,
                                                      width: 60,
                                                      decoration: BoxDecoration(
                                                        color: Color.fromRGBO(
                                                            85, 105, 104, 1),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10.0),
                                                      ),
                                                      child: Container(
                                                          alignment: Alignment
                                                              .center,
                                                          decoration: BoxDecoration(),
                                                          child: (snapshot.data[index]
                                                                      [
                                                                      'profileimg'] ==
                                                                  "null")
                                                              ? Text(
                                                                  snapshot.data[
                                                                              index]
                                                                              [
                                                                              'name']
                                                                          .toString()[
                                                                      0],
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .white,
                                                                      fontSize:
                                                                          25,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w900))
                                                              : Image.network(
                                                                  snapshot.data[
                                                                          index]
                                                                      [
                                                                      'profileimg'],
                                                                  height: 60,
                                                                  width: 60,
                                                                )),
                                                    ),
                                                    Container(
                                                      width:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width *
                                                              0.5,
                                                      padding:
                                                          const EdgeInsets.all(
                                                              10.0),
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .center,
                                                            children: [
                                                              Text(
                                                                snapshot
                                                                    .data[index]
                                                                        ['name']
                                                                    .toString(),
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .white,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600),
                                                                overflow:
                                                                    TextOverflow
                                                                        .ellipsis,
                                                              ),
                                                              // Spacer(),
                                                              // IconButton(
                                                              //     icon: Icon(EvaIcons
                                                              //         .personAddOutline),
                                                              //     onPressed: () async {
                                                              //       String id = snapshot
                                                              //               .data[index]
                                                              //           ['id'];
                                                              //       bool ret =
                                                              //           await accounts
                                                              //               .acceptrequest(
                                                              //                   id);
                                                              //       if (ret == true) {
                                                              //         print(
                                                              //             "--ACCEPTED--");
                                                              //         Navigator.pushReplacement(
                                                              //             context,
                                                              //             MaterialPageRoute(
                                                              //                 builder:
                                                              //                     (context) =>
                                                              //                         MyFriend()));
                                                              //       } else {
                                                              //         print(
                                                              //             "--NO ACCEPTED--");
                                                              //       }
                                                              //
                                                              //       // _sweetSheet.show(
                                                              //       //   context: context,
                                                              //       //   title: Text("Friend Request in wordly",
                                                              //       //       style: TextStyle(color: Color(0xFF000000))),
                                                              //       //   description: Text(
                                                              //       //       "Would you want accepted this member !or not)",
                                                              //       //       style: TextStyle(color: Color(0xff2D3748))),
                                                              //       //   color: CustomSheetColor(
                                                              //       //     main: Colors.white,
                                                              //       //     accent: Colors.blue,
                                                              //       //     icon: Colors.blue,
                                                              //       //   ),
                                                              //       //   icon: Icons.local_shipping,
                                                              //       //   positive: SweetSheetAction(
                                                              //       //     onPressed: () async {
                                                              //       //       String id =  snapshot.data[index]['id'];
                                                              //       //       bool ret = await accounts.acceptrequest(id);
                                                              //       //       if (ret == true) {
                                                              //       //         print("accepted");
                                                              //       //         Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>MyFriend()));
                                                              //       //       } else {
                                                              //       //         print("Failed");
                                                              //       //       }
                                                              //       //     },
                                                              //       //     title: 'ACCEPT',
                                                              //       //   ),
                                                              //       //   negative: SweetSheetAction(
                                                              //       //     onPressed: () async {
                                                              //       //       bool ret = await accounts.rejectrequest();
                                                              //       //       if (ret == true) {
                                                              //       //         SharedPreferences prefs = await SharedPreferences.getInstance();
                                                              //       //         //print(accounts.reject);
                                                              //       //         print(snapshot.data[index]['userid']);
                                                              //       //         setState(() {
                                                              //       //           accounts.reject.add(snapshot.data[index]['userid']);
                                                              //       //         });
                                                              //       //         prefs.setStringList("reject", accounts.reject);
                                                              //       //         print(accounts.reject.toString() + "dataisss");
                                                              //       //         Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => MyFriend()));
                                                              //       //       }
                                                              //       //     },
                                                              //       //     title: 'REJECT',
                                                              //       //   ),
                                                              //       // );
                                                              //     }),
                                                            ],
                                                          ),
                                                          SizedBox(height: 5),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Row(
                                                children: [
                                                  Expanded(
                                                      child: InkWell(
                                                    onTap: () async {
                                                      String id = snapshot
                                                          .data[index]['id'];
                                                      bool ret = await accounts
                                                          .acceptrequest(id);
                                                      if (ret == true) {
                                                        print("--ACCEPTED--");
                                                        Navigator.pushReplacement(
                                                            context,
                                                            MaterialPageRoute(
                                                                builder:
                                                                    (context) =>
                                                                        MyFriend()));
                                                      } else {
                                                        print(
                                                            "--NO ACCEPTED--");
                                                      }
                                                    },
                                                    child: Container(
                                                      height: 50,
                                                      color: Color.fromRGBO(
                                                          85, 105, 104, 1),
                                                      child: Center(
                                                        child: Text(
                                                          "Accept",
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontSize: 20),
                                                        ),
                                                      ),
                                                    ),
                                                  )),
                                                  SizedBox(
                                                    width: 20,
                                                  ),
                                                  Expanded(
                                                      child: InkWell(
                                                    onTap: () async {
                                                      String id = snapshot
                                                          .data[index]['id'];
                                                      bool ret = await accounts
                                                          .rejectrequest(id);
                                                      if (ret == true) {
                                                        print("--ACCEPTED--");
                                                        Navigator.pushReplacement(
                                                            context,
                                                            MaterialPageRoute(
                                                                builder:
                                                                    (context) =>
                                                                        MyFriend()));
                                                      } else {
                                                        print(
                                                            "--NO ACCEPTED--");
                                                      }
                                                    },
                                                    child: Container(
                                                      height: 50,
                                                      color: Color.fromRGBO(
                                                          85, 105, 104, 1),
                                                      child: Center(
                                                        child: Text(
                                                          "Reject",
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontSize: 20),
                                                        ),
                                                      ),
                                                    ),
                                                  )),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      );
                                    }
                                  }
                                  return Align(
                                    alignment: Alignment.topCenter,
                                    child: ClipRRect(
                                      child: Image.asset(
                                        'assets/images/empty.png',
                                        width: 500,
                                        height: 500,
                                        fit: BoxFit.contain,
                                      ),
                                    ),
                                  );
                                });
                          },
                        ),
                      ),
                    ),
                  ),
                ],
              );
            }
            return Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }
}
