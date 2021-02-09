import 'package:shared_preferences/shared_preferences.dart';

bool valueterms = false;

// this accounts class has function to login , signup , autologin and reset password
class Accounts {}

// this Store class has function to set and get the data from saared preferences
class Store {
  savestring(String key, String value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(key, value);
    print("saved successfully..");
    return;
  }

  getstring(key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(key);
  }
}
