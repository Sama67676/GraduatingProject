import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async' show Future;
class UserPrefrences {
static SharedPreferences? _sharedPrefs;
  factory UserPrefrences() => UserPrefrences._internal();
  UserPrefrences._internal();

    static const _keyUserName ='userName';
    static const _keyUserPosition ='userPosition';

 
 
   Future setUserName(String userName)async{
     _sharedPrefs = await SharedPreferences.getInstance();
      return _sharedPrefs?.setString(_keyUserName, jsonEncode(userName));
  }
  
   getUserName() async{
   _sharedPrefs ??= await SharedPreferences.getInstance();
    String? name;
    name=  _sharedPrefs?.getString(_keyUserName);
    return name;
    }

   Future setUserPosition(String userPosition)async{
   _sharedPrefs = await SharedPreferences.getInstance();
   await _sharedPrefs?.setString(_keyUserPosition, jsonEncode(userPosition));
  }
  
   getUserPosition() async{
    _sharedPrefs ??= await SharedPreferences.getInstance();
    String? position;
     position =_sharedPrefs?.getString(_keyUserPosition);
    return position;
    }
}