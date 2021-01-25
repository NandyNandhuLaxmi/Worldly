import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:io';
import 'package:path/path.dart';

// this accounts class has function to login , signup , autologin and reset password
class Accounts {

  // this login function is used to login the user
  login(String email,String password)async{
    print("login called");
    Map data = {'email': email, 'password': password};
    var response = await http.post('http://wordly.in/appapi/login.php',body: data);
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
    }else{
      return false;
    }
  }

  // this signup function is used to sign up the user

  signup(String username , String email , String password)async{
    Store store = Store();
    Map data = {
      "name": username,
      "email": email,
      "password": password
    };
    var response = await http.post('http://wordly.in/appapi/register.php', body: data);

    if ((json.decode(response.body))['success'] == 1) {
      print("sucess");
      store.savestring("username", username);
      store.savestring("email", email);
      store.savestring("password", password);
      login(email, password);
      return true;
    } if ((json.decode(response.body))['success'] == 2) {
      print("already exists");
      return false;
    }
  }


  // this is autologin function used to make the user to auto login on splash screen
  autologin()async{
    Store store = Store();
    String email = await store.getstring("email");
    String password = await store.getstring("password");
    if (email != null && password != null) {
      Map data = {'email': email, 'password': password};
      var response = await http.post('http://wordly.in/appapi/login.php',body: data);
      if (json.decode(response.body)['success'] == 1) {
        String username = json.decode(response.body)['name'];
        print(username);
        store.savestring("username", username);
        return true;
      }else{
        return false;
      }
    }else{
      return false;
    }
  }

  // this function is used to reset the user password on forgot password button
  reset(String email)async{
    Map data = {
      "emailid": email,
    };
    var response = await http.post("http://wordly.in/appapi/resetpassword.php",body: data);
    if (json.decode(response.body)['success'] == 1) {
      return true;
    }else{
      return false;
    }
  }

  //this function is used to update user or edit profile
  updateuser(String name , String aboutus)async{
    Store store = Store();
    String userid = await store.getstring("userid");
    Map data = {
      "name": name,
      "about":aboutus,
      "userid": userid
    };
    var response = await http.post("http://wordly.in/appapi/profile.php",body: data);
    if (json.decode(response.body)['success'] == 1) {
      store.savestring("username", name);
      return true;
    }else{
      return false;
    }
  }

  //this function is used to search a add user and profile, frinds
  search(String value)async{
    Map data = {
      "searchval": value,
    };
    var response = await http.post("http://wordly.in/appapi/searchapi.php",body: data);
    if (json.decode(response.body)['success'] == 1) {

      return json.decode(response.body)['searchlist'];
    }else{
      return "";
    }
  }

  //this function is used to  get profile
  getprofile(String id)async{
print("sdddsadsdadaaaaaaaaaaaaaaa");
    print(id);
    Map data = {
      "userid": id,
    };
    var response = await http.post("http://wordly.in/appapi/getprofile.php",body: data);
    print(json.decode(response.body)['name'].toString()+"ssssssssssssss");
    if (json.decode(response.body)['success'] == 1) {


      return json.decode(response.body);
    }else{
      return "";
    }
  }

  //this function is used to  getprofileimages
  getprofileimages()async{
    Store store = Store();
  String userid = await store.getstring("userid");

    Map data = {
      "userid": userid,
    };
    var response = await http.post("http://wordly.in/appapi/getprofileimages.php",body: data);
    if (json.decode(response.body)['success'] == 1) {
      return json.decode(response.body)['profileimg'];
    }else{
      return "";
    }
  }

  //this function is used to  updateprofileimage
  updateprofileimage(id, String profileimg)async{
    Map data = {
      "userid": id,
      "profileimg": profileimg,
    };
    var response = await http.post("http://wordly.in/appapi/updateprofileimage.php",body: data);
    if (json.decode(response.body)['success'] == 1) {
      return json.decode(response.body);
    }else{
      return "";
    }
  }

  //this is function is used to about us
  aboutus(String value) async {
    Map data = {
      "about": value,
    };
    var response = await http.post("http://wordly.in/appapi/about.php", body: data);
    if (json.decode(response.body)['success'] == 1) {
      return json.decode(response.body);
    }else{
      return "";
    }
  }

  //this is function is used to private policy
  privacy(String value) async {
    Map data = {
      "privacy": value,
    };
    var response = await http.post("http://wordly.in/appapi/privacy.php", body: data);
    if (json.decode(response.body)['success'] == 1) {
      return json.decode(response.body);
    }else{
      return "";
    }
  }

  //this is function is used to contact us
  contactus(String email, String mobile) async {
    Map data = {
      "email": email,
      "mobile": mobile,
    };
    var response = await http.post("http://wordly.in/appapi/contact.php", body: data);
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
  addtage()async{

  }

  //this is function is used to add/update tag
  usertag(String tagid) async {
    Store store = Store();
    String userid = await store.getstring("userid");
    Map data = {
      "userid": userid,
      "tagid": tagid,
    };
    var response = await http.post("http://wordly.in/appapi/usertag.php", body: data);
    if (json.decode(response.body)['success'] == 1) {
      return "1";
    } if(json.decode(response.body)['success'] == 3) {
      return "3";
    }else{
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
    var response = await http.post("http://wordly.in/appapi/deleteusertag.php", body: data);
    if (json.decode(response.body)['success'] == 1) {
      return true;
    } else {
      return false;
    }
  }

  addtag(String tagid, String editid) async {
    Store store = Store();
    String userid = await store.getstring("userid");
    Map data = {
      "tagid": tagid,
      "editid": editid,
      "userid": userid
    };
    var response = await http.post("http://wordly.in/appapi/usertag.php", body: data);
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
    var response = await http.post("http://wordly.in/appapi/sendfriendrequest.php", body: data);
    print(response.body);
    if (json.decode(response.body)['success'] == 1) {
      return "1";
    }
    if (json.decode(response.body)['success'] == 2) {
      return "2";
    }
    else {
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
    var response = await http.post("http://wordly.in/appapi/requestlist.php", body: data);
    print(json.decode(response.body)['connectionlist']);
    if (json.decode(response.body)['success'] == 1) {
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
    var response = await http.post("http://wordly.in/appapi/acceptrequest.php", body: data);
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
    var response = await http.post("http://wordly.in/appapi/rejectrequest.php", body: data);
    if (json.decode(response.body)['success'] == 1) {
      return true;
    } else {
      return false;
    }
  }
  connection()async{
    Store store = Store();
    String userid = await store.getstring("userid");
    Map data = {
      "userid": userid,
    };
    var response = await http.post("http://wordly.in/appapi/myconnection.php", body: data);
    if (json.decode(response.body)['success'] == 1) {
      return json.decode(response.body)['connectionlist'];
    } else {
      return "";
    }
  }
  List <String> reject = [];


  asyncFileUpload(File file) async{
    var request = http.MultipartRequest("POST", Uri.parse("http://wordly.in/appapi/updateprofileimage.php"));
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

}

// this Store class has function to set and get the data from saared preferences
class Store {
  savestring(String key,String value)async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(key, value);
    print("saved successfully..");
    return;
  }
  getstring(key)async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(key);
  }
}