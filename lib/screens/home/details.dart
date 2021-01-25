import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:worldly/data/data.dart';
import 'package:sweetsheet/sweetsheet.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:worldly/screens/home/my_friend.dart';

import 'adduser.dart';
import 'home.dart';

class Details extends StatefulWidget {
  Details({Key key, @required this.val}) : super(key: key);
  final val;
  @override
  _DetailsState createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  Accounts accounts = Accounts();
  final SweetSheet _sweetSheet = SweetSheet();

  int count = 1;
  String id = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF2F2F2),
      appBar: AppBar(
        title: Text('Profile', style: TextStyle(color: Color(0xFFFFFFFF))),
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
            future: accounts.getprofile(widget.val),
            builder: (context, snapshot) {
              print(snapshot.data.toString() + "mmmmmmmmmmm");
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
                      (snapshot.data['profileimg'] ==
                              "http://wordly.in/appapi/")
                          ? Container(
                              width: MediaQuery.of(context).size.width * 0.3,
                              height: MediaQuery.of(context).size.height * 0.3,
                              child: Center(
                                  child: Icon(
                                EvaIcons.personOutline,
                                size: 50,
                              )),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                shape: BoxShape.circle,
                              ),
                            )
                          : Container(
                              width: MediaQuery.of(context).size.width * 0.3,
                              height: MediaQuery.of(context).size.height * 0.3,
                              decoration: BoxDecoration(
                                  color: Colors.blue,
                                  shape: BoxShape.circle,
                                  image: DecorationImage(
                                      image: NetworkImage(
                                          snapshot.data['profileimg']),
                                      fit: BoxFit.cover)),
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
                        IconButton(
                            icon: Icon(EvaIcons.personAddOutline),
                            onPressed: () async {
                              // String id = snapshot.data['id'];
                              // bool ret = await accounts.acceptrequest(id);
                              //   if (ret == true) {
                              //     print("--ACCEPTED--");
                              //     Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>MyFriend()));
                              //   } else {
                              //     print("--NO ACCEPTED--");
                              // }
                              _sweetSheet.show(
                                context: context,
                                title: Text("Friend To Friend Requests",
                                    style: TextStyle(color: Color(0xFF000000))),
                                description: Text(
                                    "",
                                    style: TextStyle(color: Color(0xff2D3748))),
                                    icon: EvaIcons.navigation2Outline,
                                color: CustomSheetColor(
                                  main: Colors.white,
                                  accent: Colors.blue,
                                  icon: Colors.blue,
                                ),
                                // icon: Icons.local_shipping,
                                positive: SweetSheetAction(
                                  onPressed: () async {
                                    // String id =  snapshot.data[snapshot]['id'];
                                    // bool ret = await accounts.acceptrequest(id);
                                    // if (ret == true) {
                                    //   print("accepted");
                                    //   Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> MyFriend()));
                                    // } else {
                                    //   print("Failed");
                                    // }

                                    String req = await accounts
                                        .sendfriendrequest(widget.val);
                                    if (req == "1") {
                                      Fluttertoast.showToast(
                                          msg:
                                              "Friend request sent successfully",
                                          toastLength: Toast.LENGTH_SHORT,
                                          gravity: ToastGravity.BOTTOM,
                                          timeInSecForIosWeb: 1,
                                          backgroundColor: Color(0xFF666666),
                                          textColor: Colors.white,
                                          fontSize: 12.0);
                                      print("....SUCCESS....");
                                    }
                                    if (req == "2") {
                                      Fluttertoast.showToast(
                                          msg: "Friend request already send...",
                                          toastLength: Toast.LENGTH_SHORT,
                                          gravity: ToastGravity.BOTTOM,
                                          timeInSecForIosWeb: 1,
                                          backgroundColor: Color(0xFF666666),
                                          textColor: Colors.white,
                                          fontSize: 12.0);
                                      print("....exists....");
                                    }
                                    if (req == "3") {
                                      Fluttertoast.showToast(
                                          msg: "Failed",
                                          toastLength: Toast.LENGTH_SHORT,
                                          gravity: ToastGravity.BOTTOM,
                                          timeInSecForIosWeb: 1,
                                          backgroundColor: Color(0xFF666666),
                                          textColor: Colors.white,
                                          fontSize: 12.0);
                                      print("....FAILED....");
                                    }
                                  },
                                  title: 'Friend Request',
                                ),
                              );
                            }),
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
                          Text('Skill',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15)),
                          SizedBox(height: 8),
                          Builder(builder: (context) {
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
                                              padding: const EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 8.0),
                                              margin: const EdgeInsets.all(8.0),
                                              decoration: BoxDecoration(
                                                color: Color(0xFFF2F2F2),
                                                borderRadius: BorderRadius.circular(30),
                                              ),
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                children: [
                                                  Text(snapshot.data['taglist'][index]["tagname"].toString()),
                                                  Icon(EvaIcons.closeCircleOutline)
                                                ],
                                              ),
                                            ),
                                          ],
                                        );
                                      }),
                                ],
                              );
                            } catch (e) {
                              return Center(
                                child: Text("no tags"),
                              );
                            }
                          })

                          // Container(
                          //   child: ChipsChoice<String>.multiple(
                          //     value: tags,
                          //     onChanged: (val) => setState(() => tags = val),
                          //     choiceItems: C2Choice.listFrom<String, String>(
                          //       source: options,
                          //       value: (i, v) => v,
                          //       label: (i, v) => v,
                          //       tooltip: (i, v) => v,
                          //     ),
                          //     textDirection: TextDirection.ltr,
                          //     wrapped: true,
                          //     choiceStyle: C2ChoiceStyle(
                          //       showCheckmark: false,
                          //       labelStyle: const TextStyle(
                          //         fontSize: 16
                          //       ),
                          //       borderRadius: const BorderRadius.all(Radius.circular(20)),

                          //       // color: Color(0xFFFFFFFF),
                          //       borderColor: Color(0xFFFFFFFF),
                          //     ),
                          //     choiceActiveStyle: const C2ChoiceStyle(
                          //       brightness: Brightness.dark,
                          //       borderShape: RoundedRectangleBorder(
                          //         borderRadius: BorderRadius.all(Radius.circular(20)),
                          //         side: BorderSide(color: Color(0xFFF15B5D))
                          //       ),
                          //     ),
                          //   ),
                          // ),
                        ]),
                  ),
                ],
              );
            }),
      ),
    );
  }
}
