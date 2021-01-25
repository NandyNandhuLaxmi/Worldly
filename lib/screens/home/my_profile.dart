import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:worldly/data/data.dart';
import 'package:worldly/screens/home/adduser.dart';
import 'package:worldly/screens/home/home.dart';

import '../../data/data.dart';
import '../../data/data.dart';

class MyProfile extends StatefulWidget {
  @override
  _MyProfileState createState() => _MyProfileState();
}

class _MyProfileState extends State<MyProfile> {
  int tag = 1;
  Accounts accounts = Accounts();
  Store store = Store();
  String val = "";

  getshare() async {
    final id = await store.getstring("userid");
    setState(() {
      val = id;
    });
  }

  // String skill = '';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getshare();
    // skill();
  }

  bool edittag = false;

  // skill() async {
  //   var response = await http.get("http://wordly.in/appapi/skill.php");
  //   if (json.decode(response.body)['taglist']['success'] == 1) {
  //     return json.decode(response.body);
  //   } else {
  //     return "";
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => Home())),
      child: Scaffold(
        backgroundColor: Color(0xFFF2F2F2),
        appBar: AppBar(
          title: Text('My Profile', style: TextStyle(color: Color(0xFFFFFFFF))),
          backgroundColor: Colors.blue,
          brightness: Brightness.light,
          elevation: 0,
          actionsIconTheme: IconThemeData(color: Colors.white),
          iconTheme: IconThemeData(color: Colors.white),
          leading: (IconButton(
              icon: Icon(EvaIcons.arrowBackOutline),
              onPressed: () => Navigator.pushReplacement(
                  context, MaterialPageRoute(builder: (context) => Home())))),
        ),
        body: SingleChildScrollView(
          child: FutureBuilder(
              future: accounts.getprofile(val),
              builder: (context, snapshot) {
                print(snapshot.data);
                if (snapshot.data == null) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Stack(
                      children: [
                        Container(
                          width: double.infinity,
                          height: 150,
                          padding: const EdgeInsets.all(10.0),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              image: DecorationImage(
                                  image: AssetImage('assets/images/bg.png'),
                                  fit: BoxFit.cover),
                              boxShadow: [
                                BoxShadow(
                                    offset: Offset(10, 10),
                                    color: Colors.black45.withOpacity(0.2),
                                    blurRadius: 20.0),
                                BoxShadow(
                                    offset: Offset(-10, -10),
                                    color: Colors.white24,
                                    blurRadius: 20.0),
                              ]),
                        ),
                        (snapshot.data['profileimg'] != "null")
                            ? Container(
                                width: MediaQuery.of(context).size.width * 0.3,
                                height:
                                    MediaQuery.of(context).size.height * 0.3,
                                decoration: BoxDecoration(
                                    color: Colors.blue,
                                    shape: BoxShape.circle,
                                    image: DecorationImage(
                                        image: NetworkImage(
                                            snapshot.data['profileimg']),
                                        fit: BoxFit.cover)),
                              )
                            : Container(
                                width: MediaQuery.of(context).size.width * 0.3,
                                height:
                                    MediaQuery.of(context).size.height * 0.3,
                                decoration: BoxDecoration(
                                  color: Colors.blue,
                                  shape: BoxShape.circle,
                                ),
                                child: Text(snapshot.data['name']
                                    .toString()[0]
                                    .toUpperCase()),
                              ),
                      ],
                    ),
                    Container(
                      height: 50,
                      width: double.infinity,
                      padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8.0),
                          boxShadow: [
                            BoxShadow(
                                offset: Offset(10, 10),
                                color: Colors.black45.withOpacity(0.2),
                                blurRadius: 20.0),
                            BoxShadow(
                                offset: Offset(-10, -10),
                                color: Colors.white24,
                                blurRadius: 20.0),
                          ]),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(snapshot.data['name'],
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18)),
                          InkWell(
                            child: Icon(EvaIcons.edit),
                            onTap: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => AddUser())),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 10),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(10.0),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8.0),
                          boxShadow: [
                            BoxShadow(
                                offset: Offset(10, 10),
                                color: Colors.black45.withOpacity(0.2),
                                blurRadius: 20.0),
                            BoxShadow(
                                offset: Offset(-10, -10),
                                color: Colors.white24,
                                blurRadius: 20.0),
                          ]),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('About',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15)),
                            SizedBox(height: 8),
                            Text(snapshot.data['about'],
                                style: TextStyle(
                                    color: Colors.black26,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 15)),
                          ]),
                    ),
                    SizedBox(height: 10),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(10.0),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8.0),
                          boxShadow: [
                            BoxShadow(
                                offset: Offset(10, 10),
                                color: Colors.black45.withOpacity(0.2),
                                blurRadius: 20.0),
                            BoxShadow(
                                offset: Offset(-10, -10),
                                color: Colors.white24,
                                blurRadius: 20.0),
                          ]),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Skill',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15)),
                                IconButton(
                                  icon: Icon(Icons.add),
                                    onPressed: () => _addtag(context),
                                  ),
                              ],
                            ),
                            SizedBox(height: 8),
                            FutureBuilder(
                                future: accounts.skill(),
                                builder: (context, snap) {
                                  print(snapshot.data);
                                  if (snapshot.data == null) {
                                    return Center(
                                      child: CircularProgressIndicator(),
                                    );
                                  }
                                  if (snapshot.data['taglist'] == "null") {
                                    return Text('No Skills add');
                                  }
                                  try {
                                    return Wrap(
                                      children: [
                                        GridView.builder(
                                            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4),
                                            itemCount: snapshot.data['taglist'].length,
                                            controller: new ScrollController(keepScrollOffset: false),
                                            shrinkWrap: true,
                                            scrollDirection: Axis.vertical,
                                            itemBuilder: (context, index) {
                                              return Wrap(
                                                direction: Axis.horizontal,
                                                children: [
                                                  Container(
                                                    // padding: const EdgeInsets.fromLTRB(8.0, 0, 0, 0),
                                                    margin: const EdgeInsets.all(8.0),
                                                    decoration: BoxDecoration(
                                                      color: Color(0xFFF2F2F2),
                                                      borderRadius: BorderRadius.circular(30),
                                                    ),
                                                    child: Row(
                                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                      children: [
                                                        Text(snapshot.data['taglist'][index]["tagname"].toString()),
                                                        IconButton(
                                                          icon: Icon(EvaIcons.closeCircleOutline),
                                                            onPressed: () async {
                                                              String id = snapshot.data['taglist'][index]['editid'];
                                                              bool ret = await accounts.deleteusertag(id);
                                                              if (ret == true) {
                                                                Fluttertoast.showToast(
                                                                    msg: "Skill removed...",
                                                                    toastLength: Toast.LENGTH_SHORT,
                                                                    gravity: ToastGravity.BOTTOM,
                                                                    timeInSecForIosWeb: 1,
                                                                    backgroundColor: Color(0xFF666666),
                                                                    textColor: Colors.white,
                                                                    fontSize: 12.0);
                                                                setState(() { });
                                                              }
                                                            }
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              );
                                            }),
                                      ],
                                    );
                                 } catch (e) {
                                      return Center(child: Text("no tags"),
                                    );
                                  } 
                                }),
                          ]),
                    ),
                  ],
                );
              }),
        ),
      ),
    );
  }

  _addtag(context) {
  showModalBottomSheet(
    context: context,
    builder: (BuildContext bc) {
      return Stack(
        children: [
          Container(
            height: 30.0,
            width: double.infinity,
            color: Colors.black54,
          ),
          Container(
            width: double.infinity,
            height: MediaQuery.of(context).size.height * 0.5,
            decoration: BoxDecoration(
              color: Color(0xFFFFFFFF),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              )
            ),
            child: FutureBuilder(
                future: accounts.skill(),
                builder: (BuildContext context,  snapshot) {
                  print(snapshot.data.toString());
                  if (snapshot.data != null) {
                    return GridView.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 4),
                        itemCount: snapshot.data['taglist'].length,
                        itemBuilder: (context, index) {
                          return Wrap(
                            direction: Axis.horizontal,
                            children: [
                              InkWell(
                                onTap: ()async{
                                  String id  = snapshot.data['taglist'][index]['id'];
                                  String ret = await accounts.usertag(id);
                                  if (ret == "1") {
                                    Fluttertoast.showToast(
                                        msg: "Added Successfully...",
                                        toastLength: Toast.LENGTH_SHORT,
                                        gravity: ToastGravity.BOTTOM,
                                        timeInSecForIosWeb: 1,
                                        backgroundColor: Color(0xFF666666),
                                        textColor: Colors.white,
                                        fontSize: 12.0);
                                    setState(() { });
                                  }  if(ret == "3"){
                                    Fluttertoast.showToast(
                                        msg: "Skill already added...",
                                        toastLength: Toast.LENGTH_SHORT,
                                        gravity: ToastGravity.BOTTOM,
                                        timeInSecForIosWeb: 1,
                                        backgroundColor: Color(0xFF666666),
                                        textColor: Colors.white,
                                        fontSize: 12.0);
                                  }
                                },
                                child: Container(
                                  padding:  const EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 8.0),
                                  margin: const EdgeInsets.all(8.0),
                                  decoration: BoxDecoration(
                                    color: Color(0xFFF2F2F2),
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Text(snapshot.data['taglist'][index]["tag"]
                                          .toString()),
                                      Icon(Icons.add)
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          );
                        });
                  } else {
                    return Center(child: CircularProgressIndicator());
                  }
                }),
          )
        ]
      );
    }
  );
}
}


