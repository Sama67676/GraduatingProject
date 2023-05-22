import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async' show Future;
class UserPrefrences {
static SharedPreferences? _sharedPrefs;
  factory UserPrefrences() => UserPrefrences._internal();
  UserPrefrences._internal();

    static const _keyUserName ='userName';
    static const _keyUserPosition ='userPosition';
    static const _keyDepartment ='userDepartment';
    static const _keyStatus ='userStatus';
    static const _keyYear ='userYear';
    static const _keyImage= 'userImage';

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

  Future setdepartment(String department)async{
     _sharedPrefs = await SharedPreferences.getInstance();
      return _sharedPrefs?.setString(_keyDepartment, jsonEncode(department));
  }
  
   getDepartment() async{
   _sharedPrefs ??= await SharedPreferences.getInstance();
    String? dep;
    dep=  _sharedPrefs?.getString(_keyDepartment);
    return dep;
    }

  Future setStatus(String status)async{
     _sharedPrefs = await SharedPreferences.getInstance();
      return _sharedPrefs?.setString(_keyStatus, jsonEncode(status));
  }
  
   getStatus() async{
   _sharedPrefs ??= await SharedPreferences.getInstance();
    String? status;
    status=  _sharedPrefs?.getString(_keyStatus);
    return status;
    }

  Future setYear(String year)async{
     _sharedPrefs = await SharedPreferences.getInstance();
      return _sharedPrefs?.setString(_keyYear, jsonEncode(year));
  }
  
   getYear() async{
   _sharedPrefs ??= await SharedPreferences.getInstance();
    String? year;
    year=  _sharedPrefs?.getString(_keyYear);
    return year;
    }

   Future setImageUrl(String image)async{
     _sharedPrefs = await SharedPreferences.getInstance();
      return _sharedPrefs?.setString(_keyImage, jsonEncode(image));
  }
  
   getImageUrl() async{
   _sharedPrefs ??= await SharedPreferences.getInstance();
    String? image;
    image=  _sharedPrefs?.getString(_keyImage);
    return image;
    }
}