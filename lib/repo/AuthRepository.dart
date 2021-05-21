
import 'package:shared_preferences/shared_preferences.dart';

class AuthRepository {
  static SharedPreferences prefs;

  AuthRepository._();

  static const String _IS_LOGGED_IN = "is_logged_in";

  static Future<AuthRepository> create()async{
    prefs = await SharedPreferences.getInstance();
    return new AuthRepository._();
  }

   static initPrefs()async{
    prefs = await SharedPreferences.getInstance();
  }

  static login() async {
    if(prefs==null){await initPrefs();}
    await prefs.setBool(_IS_LOGGED_IN, true);
  }

  static Future<bool> isLoggedIn() async {
    if(prefs==null){await initPrefs();}
    return prefs.containsKey(_IS_LOGGED_IN);
  }

  static logout() async {
    if(prefs==null){await initPrefs();}
    prefs.clear();
  }
}