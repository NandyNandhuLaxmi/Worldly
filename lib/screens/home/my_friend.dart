import 'dart:async';

import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:worldly/controller/auth_controller.dart';
import 'package:worldly/data/data.dart';
import 'package:worldly/screens/home/details.dart';
import 'package:worldly/screens/home/home.dart';
import 'package:sweetsheet/sweetsheet.dart';
import 'package:worldly/screens/home/my_friend.dart';

class MyFriend extends StatefulWidget {
  @override
  _MyFriendState createState() => _MyFriendState();
}

class _MyFriendState extends State<MyFriend>
    with SingleTickerProviderStateMixin {
  TabController _tabController;
  final AuthController authController = Get.put(AuthController());
  @override
  void initState() {
    _tabController = new TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: WillPopScope(
        onWillPop: () => Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => Home())),
        child: Scaffold(
          backgroundColor: Color(0xFFFFFFFF),
          appBar: AppBar(
            backgroundColor: Colors.blue,
            title: Text(
              'My Friends',
              style: TextStyle(color: Colors.white),
            ),
            brightness: Brightness.light,
            elevation: 0,
            actionsIconTheme: IconThemeData(color: Colors.white),
            iconTheme: IconThemeData(color: Colors.white),
            actions: [
              IconButton(
                  icon: Icon(EvaIcons.personAdd),
                  onPressed: () => Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => SendFriend_Request())))
            ],
            leading: (IconButton(
                icon: Icon(EvaIcons.arrowBackOutline),
                onPressed: () => Navigator.pushReplacement(
                    context, MaterialPageRoute(builder: (context) => Home())))),
            bottom: TabBar(
              unselectedLabelColor: Colors.white,
              labelColor: Colors.amber,
              tabs: [
                Tab(
                  child: Text('My Connection',
                      style: TextStyle(color: Colors.white)),
                ),
                Tab(
                  child: Text('Connection Request',
                      style: TextStyle(color: Colors.white)),
                ),

                // Tab(
                //   child: Text('Reject Requests',
                //       style: TextStyle(color: Colors.white)),
                // ),
              ],
              controller: _tabController,
              indicatorColor: Colors.white,
              indicatorSize: TabBarIndicatorSize.tab,
            ),
          ),
          body: Stack(
            children: [
              TabBarView(
                controller: _tabController,
                children: [
                  Accept_Requests(),
                  Friendlist_Requests(),

                  // Reject_Requests(),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Friendlist_Requests extends StatefulWidget {
  @override
  _Friendlist_RequestsState createState() => _Friendlist_RequestsState();
}

class _Friendlist_RequestsState extends State<Friendlist_Requests> {
  final SweetSheet _sweetSheet = SweetSheet();
  final AuthController authController = Get.put(AuthController());
  StreamController _postsController;
  final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();

  int count = 1;

  Accounts accounts = Accounts();
  String id = '';

  loadPosts() async {
    authController.requestlist().then((res) async {
      _postsController.add(res);
      return res;
    });
  }

  showSnack() {
    return scaffoldKey.currentState.showSnackBar(
      SnackBar(
        content: Text('New content loaded'),
      ),
    );
  }

  Future<Null> _handleRefresh() async {
    count++;
    print(count);
    authController.requestlist().then((res) async {
      _postsController.add(res);
      showSnack();
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
    return FutureBuilder(
      future: authController.requestlist(),
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
                            future: authController
                                .getprofile(snapshot.data[index].toString()),
                            builder: (context, snap) {
                              if (snap.data != null) {
                                if (snap.data.isNotEmpty) {
                                  print(snapshot.data.toString() + "ffffffff");
                                  return Container(
                                    width: double.infinity,
                                    padding: const EdgeInsets.all(8.0),
                                    margin: const EdgeInsets.all(8.0),
                                    decoration: BoxDecoration(
                                       color: Colors.white,
                                       borderRadius: BorderRadius.circular(10.0),
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
                                          onTap: (){
                                            String id =
                                            snapshot.data[index]['userid'];
                                            Navigator.push(context, MaterialPageRoute(builder: (context)=>Details(val: id)));
                                          },
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Row(
                                              children: [
                                                Container(
                                                  height: 60,
                                                  width: 60,
                                                  decoration: BoxDecoration(
                                                    color: Color.fromRGBO(
                                                        85, 105, 104, 1),
                                                    borderRadius:
                                                        BorderRadius.circular(10.0),
                                                  ),
                                                  child: Container(
                                                      alignment: Alignment.center,
                                                      decoration: BoxDecoration(),
                                                      child: (snapshot.data[index]['profileimg'] == "null")
                                                          ? Text(snapshot.data[index]['name'].toString()[0],
                                                              style: TextStyle(color: Colors.white, fontSize: 25, fontWeight: FontWeight.w900))
                                                          : Container(
                                                              height: 60,
                                                              width: 60,
                                                              decoration: BoxDecoration(
                                                                borderRadius: BorderRadius.circular(10.0),
                                                                image: DecorationImage(
                                                                  image: NetworkImage(snapshot.data[index]['profileimg']),
                                                                  fit: BoxFit.cover
                                                                )
                                                              ),
                                                            //child: Image.network(snapshot.data[idx]['profileimg'], fit: BoxFit.fill)
                                                          )),
                                                ),
                                                SizedBox(width: 20.0),
                                                Container(
                                                  child: Row(
                                                    children: [
                                                      Text(snapshot.data[index]['name'].toString(), style: TextStyle(color: Colors.black, fontWeight: FontWeight.w500, fontSize: 16)),
                                                      //Icon(EvaIcons.moreHorizotnalOutline)
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                                            children: [
                                              Container(
                                                width: 150,
                                                child: MaterialButton(
                                                  hoverColor: Colors.black,
                                                  shape: RoundedRectangleBorder(borderRadius: new BorderRadius.circular(30.0)),
                                                    child: Text(
                                                      "Accept",
                                                      style: TextStyle(
                                                        fontSize: 16,
                                                        fontWeight: FontWeight.w500,
                                                        color: Colors.white),
                                                    ),
                                                    color: Colors.blue,
                                                    onPressed: () async {
                                                      String id = snapshot.data[index]['id'];
                                                      bool ret = await authController.acceptrequest(id);
                                                      if (ret == true) {
                                                        Navigator.pushReplacement(
                                                          context,
                                                          MaterialPageRoute(
                                                            builder: (context) =>
                                                              MyFriend()));
                                                      } else {
                                                        print('--NO ACCEPTED--');
                                                      }
                                                    },
                                                ),
                                              ),
                                              SizedBox(width: 20),
                                               Container(
                                                width: 150,
                                                child: MaterialButton(
                                                  hoverColor: Colors.black,
                                                  shape: RoundedRectangleBorder(borderRadius: new BorderRadius.circular(30.0)),
                                                    child: Text(
                                                      "Reject",
                                                      style: TextStyle(
                                                        fontSize: 16,
                                                        fontWeight: FontWeight.w500,
                                                        color: Colors.white),
                                                    ),
                                                    color: Color(0xFF95989A),
                                                    onPressed: () async {
                                                      String id = snapshot.data[index]['id'];
                                                      bool ret = await authController.rejectrequest(id);
                                                      if (ret == true) {
                                                        Navigator.pushReplacement(
                                                          context,
                                                          MaterialPageRoute(
                                                            builder: (context) =>
                                                              MyFriend()));
                                                      } else {
                                                        print('--NO ACCEPTED--');
                                                      }
                                                    },
                                                ),
                                              ),
                                              // Expanded(
                                              //     child: InkWell(
                                              //       onTap: ()async{
                                              //         String id =
                                              //         snapshot.data[index]['id'];
                                              //         bool ret = await accounts
                                              //             .rejectrequest(id);
                                              //         if (ret == true) {
                                              //           print("--ACCEPTED--");
                                              //           Navigator.pushReplacement(
                                              //               context,
                                              //               MaterialPageRoute(
                                              //                   builder: (context) =>
                                              //                       MyFriend()));
                                              //         } else {
                                              //           print("--NO ACCEPTED--");
                                              //         }
                                              //       },
                                              //       child: Container(
                                              //   height: 50,
                                              //   color: Color.fromRGBO(
                                              //         85, 105, 104, 1),
                                              //   child: Center(
                                              //       child: Text("Reject",style: TextStyle(color: Colors.white,fontSize: 20),),
                                              //   ),
                                              // ),
                                              //     )),
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
    );
  }
}

class Accept_Requests extends StatefulWidget {
  @override
  _Accept_RequestsState createState() => _Accept_RequestsState();
}

class _Accept_RequestsState extends State<Accept_Requests> {
  StreamController _postsController;
  final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();
  final AuthController authController = Get.put(AuthController());
  int count = 1;

  Accounts accounts = Accounts();
  String id = '';

  loadPosts() async {
    authController.acceptrequest(id).then((res) async {
      _postsController.add(res);
      return res;
    });
  }

  showSnack() {
    return scaffoldKey.currentState.showSnackBar(
      SnackBar(
        content: Text('New content loaded'),
      ),
    );
  }

  Future<Null> _handleRefresh() async {
    count++;
    print(count);
    authController.acceptrequest(count * 5).then((res) async {
      _postsController.add(res);
      showSnack();
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
    return FutureBuilder(
      future: authController.connection(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          return Column(
            children: <Widget>[
              Expanded(
                child: Scrollbar(
                  child: RefreshIndicator(
                    onRefresh: _handleRefresh,
                    child: ListView.builder(
                      physics: const AlwaysScrollableScrollPhysics(),
                      itemCount: snapshot.data.length,
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: (){
                            print(snapshot.data[index]['id']);
                            String id = snapshot.data[index]['id'];
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>Details(val: id)));
                          },
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
                                  color: Colors.black45
                                    .withOpacity(0.35),
                                  blurRadius: 20.0),
                                BoxShadow(
                                  offset: Offset(-10, -10),
                                  color: Colors.white,
                                  blurRadius: 20.0),
                              ]
                            ),
                            child: Row(
                              children: [
                                Container(
                                    height: 60,
                                    width: 60,
                                    decoration: BoxDecoration(
                                      color: Color(0xFF0068A5).withOpacity(0.15),
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                    child: Container(
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(),
                                  child: (snapshot.data[index]['profileimg'] == "null")
                                    ? ((snapshot.data[index]['value'] != null)
                                    ? Text(snapshot.data[index]['value'][0]
                                      .toString()
                                      .toUpperCase(), style: TextStyle(color: Colors.blueAccent, fontSize: 15, fontWeight: FontWeight.bold),)
                                    : Icon(EvaIcons.person))
                                    : Container(
                                        height: 60,
                                        width: 60,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(10.0),
                                          image: DecorationImage(
                                            image: NetworkImage(snapshot.data[index]['profileimg']),
                                            fit: BoxFit.cover
                                          )
                                        ),
                                        //child: Image.network(snapshot.data[idx]['profileimg'], fit: BoxFit.fill)
                                      )
                                  )     
                                ),
                                SizedBox(width: 20.0),
                                Container(
                                  width: MediaQuery.of(context).size.width * 0.5,
                                  padding: const EdgeInsets.all(10.0),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(snapshot.data[index]['name'].toString(),
                                           style: TextStyle(color: Colors.black, fontWeight: FontWeight.w500, fontSize: 16)
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 5),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),
            ],
          );
        }
        // else {
        //   return Text("no data");
        // }

        if (snapshot.connectionState != ConnectionState.done) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else {
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
        }
      },
    );
  }
}

class Reject_Requests extends StatefulWidget {
  @override
  _Reject_RequestsState createState() => _Reject_RequestsState();
}

class _Reject_RequestsState extends State<Reject_Requests> {
  Accounts accounts = Accounts();
  String id = '';
  final AuthController authController = Get.put(AuthController());
  StreamController _postsController;
  final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();

  int count = 1;

  loadPosts() async {
    authController.requestlist().then((res) async {
      _postsController.add(res);
      return res;
    });
  }

  showSnack() {
    return scaffoldKey.currentState.showSnackBar(
      SnackBar(
        content: Text('New content loaded'),
      ),
    );
  }

  Future<Null> _handleRefresh() async {
    count++;
    print(count);
    authController.requestlist().then((res) async {
      _postsController.add(res);
      showSnack();
      return null;
    });
  }

  getshare() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    print(prefs.getStringList("reject").toString() + "datais");
    if (prefs.getStringList("reject") != null) {
      return prefs.getStringList("reject");
    }
  }

  @override
  void initState() {
    _postsController = new StreamController();
    // loadPosts();
    getshare();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      child: FutureBuilder(
          future: getshare(),
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
                                future:
                                    authController.getprofile(snapshot.data[index]),
                                builder: (context, snap) {
                                  if (snap.data != null) {
                                    return Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        children: [
                                          Container(
                                            height: 40,
                                            width: 40,
                                            decoration: BoxDecoration(
                                                color: Color(0xFF0068A5)
                                                    .withOpacity(0.15),
                                                shape: BoxShape.circle),
                                            child: Center(
                                                child: Text(
                                                    snap.data['name']
                                                        .toString()[0]
                                                        .toUpperCase(),
                                                    style: TextStyle(
                                                        color:
                                                            Color(0xFF0068A5),
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.w900))),
                                          ),
                                          Container(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.2,
                                            padding: const EdgeInsets.all(10.0),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Text(
                                                      snap.data['name']
                                                          .toString(),
                                                      style: TextStyle(
                                                          color:
                                                              Color(0xFF000000),
                                                          fontWeight:
                                                              FontWeight.w600),
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(height: 5),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  }
                                  return ClipRRect(
                                    child: Image.asset('assets/images/empty.png',  width: 500,  height: 500, fit: BoxFit.contain),
                                  );
                                }
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                ],
              );
            }

            if (snapshot.connectionState != ConnectionState.done) {
              return Center(child: CircularProgressIndicator());
            } else {
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
            }
          }),
    );
  }
}

//Send a Friend Request
class SendFriend_Request extends StatefulWidget {
  @override
  _SendFriend_RequestState createState() => _SendFriend_RequestState();
}

class _SendFriend_RequestState extends State<SendFriend_Request> {
  Accounts accounts = Accounts();
  String searchvalue = "";
  final AuthController authController = Get.put(AuthController());
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => MyFriend())),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue,
          title: Text('Send a Friend Requests',
              style: TextStyle(color: Colors.white)),
          brightness: Brightness.light,
          elevation: 0,
          actionsIconTheme: IconThemeData(color: Colors.white),
          iconTheme: IconThemeData(color: Colors.white),
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
                    hintText: 'Search friends, peoples and more ...',
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
                        borderSide:
                            BorderSide(color: Colors.black, width: 1.2))),
                onChanged: (value) {
                  setState(() {
                    searchvalue = value;
                  });
                },
              ),
            ),
          ),
          leading: (IconButton(
              icon: Icon(EvaIcons.arrowBackOutline),
              onPressed: () => Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => MyFriend())))),
        ),
        body:(searchvalue.isNotEmpty)? FutureBuilder(
            future: authController.search(searchvalue),
            builder: (context, snapshot) {
              if (snapshot.data == null) {
                return Center(child: const CircularProgressIndicator());
              }
              if (snapshot.data.length == 0) {
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
              }
              return ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (context, idx) {
                    print(snapshot.data[idx]);
                    return InkWell(
                      onTap: () async {
                        String id = snapshot.data[idx]['id'];
                        // bool req = await accounts.sendfriendrequest(id);
                        // if (req == true) {
                        //   print("....SUCCESS....");
                        // } else {
                        //   print("....FAILED....");
                        // }
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Details(val: id)));
                      },
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
                                color: Colors.black45
                                  .withOpacity(0.35),
                                blurRadius: 20.0),
                              BoxShadow(
                                offset: Offset(-10, -10),
                                color: Colors.white,
                                blurRadius: 20.0),
                            ]
                          ),
                        child: Row(
                          children: [
                            Container(
                              height: 60,
                              width: 60,
                              decoration: BoxDecoration(
                                color: Color(0xFF0068A5).withOpacity(0.15),
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              child: Container(
                                alignment: Alignment.center,
                                decoration: BoxDecoration(),
                                  child: (snapshot.data[idx]['profileimg'] == "null")
                                    ? ((snapshot.data[idx]['value'] != null)
                                    ? Text(snapshot.data[idx]['value'][0]
                                      .toString()
                                      .toUpperCase(), style: TextStyle(color: Colors.blueAccent, fontSize: 15, fontWeight: FontWeight.bold),)
                                    : Icon(EvaIcons.person))
                                    : Container(
                                        height: 60,
                                        width: 60,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(10.0),
                                          image: DecorationImage(
                                            image: NetworkImage(snapshot.data[idx]['profileimg']),
                                            fit: BoxFit.contain
                                          )
                                        ),
                                        //child: Image.network(snapshot.data[idx]['profileimg'], fit: BoxFit.fill)
                                      )
                              ),
                            ),
                            SizedBox(width: 20.0),
                            Container(
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text((snapshot.data[idx]['value'] != null)
                                    ? snapshot.data[idx]['value']
                                    : "",
                                       style: TextStyle(color: Colors.black, fontWeight: FontWeight.w500, fontSize: 16)),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  });
            }): Center(
          child: ClipRRect(
            child: Image.asset('assets/images/empty.png',  width: 500,  height: 500, fit: BoxFit.contain),
          ),
        ),
      ),
    );
  }
}
