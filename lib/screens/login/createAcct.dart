import 'package:flutter/material.dart';
import 'package:worldly/data/data.dart';
import 'package:worldly/screens/home/home.dart';
import 'package:worldly/screens/login/login.dart';

class CreateAcct extends StatefulWidget {
  @override
  _CreateAcctState createState() => _CreateAcctState();
}

class _CreateAcctState extends State<CreateAcct> {
  Accounts accounts = Accounts();
  _signup() async {
    bool reg = await accounts.signup(_username.text, _email.text, _password.text);
    if (reg == true) {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> Login()));
    } else{
      showDialog(
          context: context,
          builder: (context){
            return AlertDialog(
              title: Text("Failed"),
              content: Text("Email already exists"),
              actions: [
                OutlinedButton(onPressed: (){Navigator.pop(context);}, child: Text("OK"))
              ],
            );
          }
      );
    }
  }

  TextEditingController _username = TextEditingController();
  TextEditingController _email = TextEditingController();
  TextEditingController _password = TextEditingController();

  @override
  void initState() {
    setState(() {
      super.initState();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFAFAFA),
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Color(0xFFFAFAFA),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: Color(0xFF000000),
          ),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        child: SizedBox(
          width: double.infinity,
          child: Container(
            child: Column(
              children: [
                Container(
                    alignment: Alignment.topLeft,
                    padding: const EdgeInsets.all(10.0),
                    child: Text(
                      'Create your\naccount',
                      style: TextStyle(
                        fontSize: 30,
                        color: Colors.blue,
                        fontWeight: FontWeight.w600,
                      ),
                    )),
                SizedBox(height: 20.0),
                Container(
                  // width: double.infinity,
                  height: 70.0,
                  padding: const EdgeInsets.all(10.0),
                  child: TextField(
                    controller: _username,
                    autocorrect: true,
                    decoration: InputDecoration(
                        hintText: 'Username',
                        hintStyle: TextStyle(
                          color: Color(0xFFA9A9A9),
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                        ),
                        filled: true,
                        fillColor: Colors.white,
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(30.0)),
                          borderSide:
                              BorderSide(color: Color(0xFFFFFFFF), width: 1.2),
                        ),
                        focusedBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(30.0)),
                            borderSide: BorderSide(
                                color: Color(0xFFFFFFFF), width: 1.2))),
                  ),
                ),
                Container(
                  // width: double.infinity,
                  height: 70.0,
                  padding: const EdgeInsets.all(10.0),
                  child: TextField(
                    controller: _email,
                    autocorrect: true,
                    decoration: InputDecoration(
                        hintText: 'Email',
                        hintStyle: TextStyle(
                          color: Color(0xFFA9A9A9),
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                        ),
                        filled: true,
                        fillColor: Colors.white,
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(30.0)),
                          borderSide:
                              BorderSide(color: Color(0xFFFFFFFF), width: 1.2),
                        ),
                        focusedBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(30.0)),
                            borderSide: BorderSide(
                                color: Color(0xFFFFFFFF), width: 1.2))),
                  ),
                ),
                Container(
                  // width: double.infinity,
                  height: 70.0,
                  padding: const EdgeInsets.all(10.0),
                  child: TextField(
                    controller: _password,
                    autocorrect: true,
                    obscureText: true,
                    decoration: InputDecoration(
                        hintText: 'Password',
                        hintStyle: TextStyle(
                          color: Color(0xFFA9A9A9),
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                        ),
                        filled: true,
                        fillColor: Colors.white,
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(30.0)),
                          borderSide:
                              BorderSide(color: Color(0xFFFFFFFF), width: 1.2),
                        ),
                        focusedBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(30.0)),
                            borderSide: BorderSide(
                                color: Color(0xFFFFFFFF), width: 1.2))),
                  ),
                ),

                Container(
                  width: 410,
                  height: 52.0,
                  child: RaisedButton(
                    hoverColor: Colors.black,
                    shape: RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(30.0)),
                    child: Text(
                      "sign up",
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Colors.white),
                    ),
                    color: Colors.blue,
                    textColor: Colors.black,
                    splashColor: Colors.white,
                    onPressed: () {
                   if (_username.text.isNotEmpty&&_password.text.isNotEmpty&&_email.text.isNotEmpty) {
                     _signup();
                   }else{
                     showDialog(
                         context: context,
                         builder: (context){
                           return AlertDialog(
                             title: Text("Failed"),
                             content: Text("All fields should be filled"),
                             actions: [
                               OutlinedButton(onPressed: (){Navigator.pop(context);}, child: Text("OK"))
                             ],
                           );
                         }
                     );
                   }
                    },
                  ),
                ),
                SizedBox(
                  height: 25.0,
                ),
                Container(
                  alignment: Alignment.bottomCenter,
                  child: Column(
                    children: [
                      Text(
                        'By clicking Sign up you agree to the our',
                        style: TextStyle(
                            color: Colors.black87, fontWeight: FontWeight.w700),
                      ),
                      Text(
                        'Terms and Conditions',
                        style: TextStyle(
                            color: Colors.black87, fontWeight: FontWeight.w700),
                      ),
                    ],
                  ),
                ),
                Container(
                  alignment: Alignment.bottomCenter,
                  padding: const EdgeInsets.only(top: 150.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text("Already an account?",
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Colors.black)),
                      SizedBox(
                        width: 8.0,
                      ),
                      GestureDetector(
                        child: Text("Log in",
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: Colors.blue)),
                        onTap: () {
                          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> Login()));
                        },
                      ),
                    ],
                  ),
                )

                //     Expanded(
                //   child: Container(
                //     alignment: Alignment.bottomCenter,
                //     padding: const EdgeInsets.all(5.0),
                //     child: Row(
                //       mainAxisAlignment: MainAxisAlignment.center,
                //       crossAxisAlignment: CrossAxisAlignment.center,
                //       children: [
                //         Text("Don't have an account?", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.black)),
                //         SizedBox(width: 8.0,),
                //         GestureDetector(child: Text("Sign up", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Color(0xFFF15B5D))),
                //         onTap: () {
                //           Navigator.push(context,  MaterialPageRoute(builder: (context) => CreateAcct()));
                //         },
                //         ),
                //       ],
                //     ),
                //   ),
                // )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
