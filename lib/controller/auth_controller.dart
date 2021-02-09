import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../data/data.dart';
import 'dart:io';

class AuthController extends GetxController {
  autologin() async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    Store store = Store();
    String email = await store.getstring("email");
    String password = await store.getstring("password");
    String deviceid = await store.getstring("deviceid");
    if (preferences.getString("google") != null) {
      if (preferences.getString("google") == "true") {
        return true;
      }
    }
    if (email != null && password != null) {
      Map data = {'email': email, 'password': password};
      var response =
          await http.post('http://wordly.in/appapi/login.php', body: data);
      if (json.decode(response.body)['success'] == 1) {
        String username = json.decode(response.body)['name'];
        print(username);
        // print(deviceid);
        store.savestring("username", username);
        return true;
      } else {
        return false;
      }
    } else {
      return false;
    }
  }

  login(String email, String password) async {
    print("login called");
    Map data = {'email': email, 'password': password};
    var response =
        await http.post('http://wordly.in/appapi/login.php', body: data);
    if (json.decode(response.body)['success'] == 1) {
      String userid = json.decode(response.body)['userid'];
      Store store = Store();
      String username = json.decode(response.body)['name'];
      print(username);
      store.savestring("email", email);
      store.savestring("password", password);
      store.savestring("userid", userid);
      store.savestring("username", username);
      return true;
    } else {
      return false;
    }
  }

  signup(String username, String email, String password) async {
    Store store = Store();
    Map data = {"name": username, "email": email, "password": password};
    var response =
        await http.post('http://wordly.in/appapi/register.php', body: data);

    if ((json.decode(response.body))['success'] == 1) {
      print("sucess");
      store.savestring("username", username);
      store.savestring("email", email);
      store.savestring("password", password);
      login(email, password);
      return true;
    }
    if ((json.decode(response.body))['success'] == 2) {
      print("already exists");
      return false;
    }
  }

  reset(String email) async {
    Map data = {
      "emailid": email,
    };
    var response = await http.post("http://wordly.in/appapi/resetpassword.php",
        body: data);
    if (json.decode(response.body)['success'] == 1) {
      return true;
    } else {
      return false;
    }
  }

  //this function is used to update user or edit profile
  updateuser(String name, String aboutus) async {
    Store store = Store();
    String userid = await store.getstring("userid");
    Map data = {"name": name, "about": aboutus, "userid": userid};
    var response =
        await http.post("http://wordly.in/appapi/profile.php", body: data);
    if (json.decode(response.body)['success'] == 1) {
      store.savestring("username", name);
      return true;
    } else {
      return false;
    }
  }

  //this function is used to search a add user and profile, frinds
  search(String value) async {
    Map data = {
      "searchval": value,
    };
    var response =
        await http.post("http://wordly.in/appapi/searchapi.php", body: data);
    if (json.decode(response.body)['success'] == 1) {
      return json.decode(response.body)['searchlist'];
    } else {
      return "";
    }
  }

  //this function is used to  get profile
  getprofile(String id) async {
    print(id);
    Map data = {
      "userid": id,
    };
    var response =
        await http.post("http://wordly.in/appapi/getprofile.php", body: data);
    if (json.decode(response.body)['success'] == 1) {
      return json.decode(response.body);
    } else {
      return "";
    }
  }

  //this function is used to  getprofileimages
  getprofileimages() async {
    Store store = Store();
    String userid = await store.getstring("userid");

    Map data = {
      "userid": userid,
    };
    var response = await http
        .post("http://wordly.in/appapi/getprofileimages.php", body: data);
    if (json.decode(response.body)['success'] == 1) {
      return json.decode(response.body)['profileimg'];
    } else {
      return "";
    }
  }

  //this function is used to  updateprofileimage
  updateprofileimage(id, String profileimg) async {
    Map data = {
      "userid": id,
      "profileimg": profileimg,
    };
    var response = await http
        .post("http://wordly.in/appapi/updateprofileimage.php", body: data);
    if (json.decode(response.body)['success'] == 1) {
      return json.decode(response.body);
    } else {
      return "";
    }
  }

  //this is function is used to about us
  aboutus(String value) async {
    Map data = {
      "about": value,
    };
    var response =
        await http.post("http://wordly.in/appapi/about.php", body: data);
    if (json.decode(response.body)['success'] == 1) {
      return json.decode(response.body);
    } else {
      return "";
    }
  }

  //this is function is used to private policy
  privacy(String value) async {
    Map data = {
      "privacy": value,
    };
    var response =
        await http.post("http://wordly.in/appapi/privacy.php", body: data);
    if (json.decode(response.body)['success'] == 1) {
      return json.decode(response.body);
    } else {
      return "";
    }
  }

  //this is function is used to contact us
  contactus(String email, String mobile) async {
    Map data = {
      "email": email,
      "mobile": mobile,
    };
    var response =
        await http.post("http://wordly.in/appapi/contact.php", body: data);
    if (json.decode(response.body)['success'] == 1) {
      return json.decode(response.body);
    } else {
      return "";
    }
  }

  //this is function is used to skill
  skill() async {
    var response = await http.get("http://wordly.in/appapi/skill.php");
    if (json.decode(response.body)['success'] == 1) {
      return json.decode(response.body);
    } else {
      return "";
    }
  }

  //this is function is used to add/update tag
  usertag(String tagid) async {
    Store store = Store();
    String userid = await store.getstring("userid");
    Map data = {
      "userid": userid,
      "tagid": tagid,
    };
    var response =
        await http.post("http://wordly.in/appapi/usertag.php", body: data);
    if (json.decode(response.body)['success'] == 1) {
      return "1";
    }
    if (json.decode(response.body)['success'] == 3) {
      return "3";
    } else {
      return json.decode(response.body)['success'];
    }
  }

  //this is function is used to deleted tag
  deleteusertag(String editid) async {
    Store store = Store();
    String userid = await store.getstring("userid");
    Map data = {
      "userid": userid,
      "editid": editid,
    };
    var response = await http.post("http://wordly.in/appapi/deleteusertag.php",
        body: data);
    if (json.decode(response.body)['success'] == 1) {
      return true;
    } else {
      return false;
    }
  }

  addtag(String tagid, String editid) async {
    Store store = Store();
    String userid = await store.getstring("userid");
    Map data = {"tagid": tagid, "editid": editid, "userid": userid};
    var response =
        await http.post("http://wordly.in/appapi/usertag.php", body: data);
    print(response.body);
    if (json.decode(response.body)['success'] == 1) {
      return true;
    } else {
      return false;
    }
  }

  //this is function is used to sendfriendrequest
  sendfriendrequest(String friendsid) async {
    Store store = Store();
    String userid = await store.getstring("userid");
    print(userid);
    Map data = {
      "userid": userid,
      "friendsid": friendsid,
    };
    var response = await http
        .post("http://wordly.in/appapi/sendfriendrequest.php", body: data);
    print(response.body);
    if (json.decode(response.body)['success'] == 1) {
      return "1";
    }
    if (json.decode(response.body)['success'] == 2) {
      return "2";
    } else {
      return "3";
    }
  }

  //this is function is used to requestlist
  requestlist() async {
    Store store = Store();
    String userid = await store.getstring("userid");
    Map data = {
      "userid": userid,
    };
    var response =
        await http.post("http://wordly.in/appapi/requestlist.php", body: data);
    print(json.decode(response.body)['connectionlist']);
    if (json.decode(response.body)['success'] == 1) {
      Map head = {
        "Authorization":
            "key=AAAANDQR_DM:APA91bGpUtUQeW2ES_c8rvHYh8c7jtd2gRJAlTAIfpLibCN1kaGI0irJPTMhiNFS7wAWKqyePvW1b-ZaN8u-OLajBDJraT6F4b--KZ-bbndoN16WRvNKuBbPtBm5swMu8rmx5LYH_rna"
      };
      Map notifibody = {
        "notification": {
          "body": "You have received a notification",
          "title": "Friend request"
        },
        "priority": "high",
        "data": {
          "clickaction": "FLUTTERNOTIFICATIONCLICK",
          "id": "1",
          "status": "done"
        },
        "to": "/topics/all"
      };
      var res = await http.post("https://fcm.googleapis.com/fcm/send",
          headers: head, body: notifibody);
      return json.decode(response.body)['connectionlist'];
    } else {
      return "";
    }
  }

  //this is function is used to acceptrequest
  acceptrequest(id) async {
    Map data = {
      "id": id,
    };
    var response = await http.post("http://wordly.in/appapi/acceptrequest.php",
        body: data);
    if (json.decode(response.body)['success'] == 1) {
      return true;
    } else {
      return false;
    }
  }

  //this is function is used to rejectrequest
  rejectrequest(String userid) async {
    // Store store = Store();
    // String userid = await store.getstring("userid");
    Map data = {
      "id": userid,
    };
    var response = await http.post("http://wordly.in/appapi/rejectrequest.php",
        body: data);
    if (json.decode(response.body)['success'] == 1) {
      return true;
    } else {
      return false;
    }
  }

  connection() async {
    Store store = Store();
    String userid = await store.getstring("userid");
    Map data = {
      "userid": userid,
    };
    var response =
        await http.post("http://wordly.in/appapi/myconnection.php", body: data);
    if (json.decode(response.body)['success'] == 1) {
      return json.decode(response.body)['connectionlist'];
    } else {
      return "";
    }
  }

  List<String> reject = [];

  asyncFileUpload(File file) async {
    var request = http.MultipartRequest(
        "POST", Uri.parse("http://wordly.in/appapi/updateprofileimage.php"));
    Store store = Store();
    String userid = await store.getstring("userid");
    request.fields["userid"] = userid;
    var pic = await http.MultipartFile.fromPath("profileimg", file.path);
    request.files.add(pic);
    var response = await request.send();
    var responseData = await response.stream.toBytes();
    var responseString = String.fromCharCodes(responseData);
    print(responseString);
  }

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();

  signInWithGoogle() async {
    await Firebase.initializeApp();

    final GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();
    final GoogleSignInAuthentication googleSignInAuthentication =
        await googleSignInAccount.authentication;

    final AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleSignInAuthentication.accessToken,
      idToken: googleSignInAuthentication.idToken,
    );

    final UserCredential authResult =
        await _auth.signInWithCredential(credential);
    final User user = authResult.user;

    if (user != null) {
      assert(!user.isAnonymous);
      assert(await user.getIdToken() != null);

      final User currentUser = _auth.currentUser;
      assert(user.uid == currentUser.uid);

      print('signInWithGoogle succeeded: $user');

      // return '$user';
      print("login called");
      Map data = {
        "name": user.displayName,
        'email': user.email,
        'token': user.uid
      };
      var response = await http.post('http://wordly.in/appapi/social-login.php',
          body: data);
      if (json.decode(response.body)['success'] == 1) {
        String userid = json.decode(response.body)['userid'];
        Store store = Store();
        String username = json.decode(response.body)['name'];
        String email = json.decode(response.body)['email'];
        print(username);
        store.savestring("email", email);
        store.savestring("userid", userid);
        store.savestring("username", username);
        store.savestring("google", "true");
        return true;
      }
    }

    return null;
  }
}
