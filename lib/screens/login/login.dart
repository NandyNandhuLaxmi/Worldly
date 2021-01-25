import 'package:flutter/material.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:worldly/data/data.dart';
import 'package:worldly/screens/home/home.dart';
import 'package:worldly/screens/login/forgotPwd.dart';
import 'createAcct.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  Accounts accounts = Accounts();
  login() async {
    bool log = await accounts.login(_email.text, _password.text);
    print(log);
    if (log == true) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => Home()));
    } else {
      showDialog(
          context: context,
          builder: (context){
            return AlertDialog(
              title: Text("Failed"),
              content: Text("Email and password is incorrect"),
              actions: [
                OutlinedButton(onPressed: (){Navigator.pop(context);}, child: Text("OK"))
              ],
            );
          }
      );
    }
  }

  @override
  void initState() {
    setState(() {
      super.initState();
      login();
    });
  }

  TextEditingController _email = TextEditingController();
  TextEditingController _password = TextEditingController();
  final RoundedLoadingButtonController _btnController =
  new RoundedLoadingButtonController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFAFAFA),
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Color(0xFFFAFAFA),
        // leading: IconButton(
        //   icon: Icon(
        //     Icons.arrow_back_ios,
        //     color: Color(0xFF000000),
        //   ),
        //   onPressed: () => Navigator.pop(context),
        // ),
      ),
      body: Container(
        width: double.infinity,
        // height: double.infinity,
        child: Column(
          children: [
            Container(
                alignment: Alignment.topLeft,
                padding: const EdgeInsets.all(10.0),
                child: Text(
                  'Log in to your\naccount',
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
                        borderRadius: BorderRadius.all(Radius.circular(30.0)),
                        borderSide:
                        BorderSide(color: Color(0xFFFFFFFF), width: 1.2))),
              ),
            ),
            Container(
              // width: double.infinity,
              height: 70.0,
              padding: const EdgeInsets.all(10.0),
              child: Stack(
                children: [
                  TextField(
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
                  GestureDetector(
                    child: Container(
                        alignment: Alignment.topRight,
                        padding: const EdgeInsets.only(top: 12.0, right: 18.0),
                        child: Text('Forgot?',
                            style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                                color: Colors.blue))),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => ForgotPwd()),
                      );
                    },
                  )
                ],
              ),
            ),
            SizedBox(height: 25.0),
            Container(
              width: 410,
              height: 52.0,
              child: MaterialButton(
                hoverColor: Colors.black,
                shape: RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(30.0)),
                child: Text(
                  "Log in",
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Colors.white),
                ),
                color: Colors.blue,
                // textColor: Colors.black,
                // splashColor: Colors.white,
                onPressed: () {

                  if (_email.text.isNotEmpty && _password.text.isNotEmpty) {
                    login();
                  }else{
                    showDialog(
                        context: context,
                        builder: (context){
                          return AlertDialog(
                            title: Text("Failed", style: TextStyle(color: Colors.red),),
                            content: Text("Email and password incorrect"),
                            actions: [
                              FlatButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: Text("OK")
                              )
                            ],
                          );
                        }
                    );
                  }
                },
              ),
            ),
            SizedBox(height: 20),
            Text('or', style: TextStyle(color: Color(0xFF000000), fontSize: 18, fontWeight: FontWeight.w300),),
            SizedBox(height: 20),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.0),
                        image: DecorationImage(
                            image: AssetImage('assets/images/facebook.png')
                        )
                    ),
                  ),
                  SizedBox(width: 15),
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.0),
                        image: DecorationImage(
                            image: AssetImage('assets/images/google.png')
                        )
                    ),
                  ),
                  SizedBox(width: 15),
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.0),
                        image: DecorationImage(
                            image: AssetImage('assets/images/linkedin.png'), fit: BoxFit.cover
                        )
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Container(
                alignment: Alignment.bottomCenter,
                padding: const EdgeInsets.only(bottom: 50.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text("Don't have an account?",
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.black)),
                    SizedBox(
                      width: 8.0,
                    ),
                    GestureDetector(
                      child: Text("Sign up",
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Colors.blue)),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => CreateAcct()));
                      },
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}