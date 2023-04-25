import 'package:shared_preferences/shared_preferences.dart';

class UserPrefrences {
  static const _keyUserName ='userName';
    static const _keyUserPosition ='userPosition';


  static Future setUserName(String userName)async{
    await  SharedPreferences.getInstance().then((value) async{
      await value.setString(_keyUserName, userName);
    })
   ;
  }
  
  static getUserName() async{
    await  SharedPreferences.getInstance().then((value) async{
       return await value.getString(_keyUserName).toString();
    });
   
    }

//صلحي هذا بعدين
  static Future setUserPosition(String userPosition)async{
  SharedPreferences _preferences =await  SharedPreferences.getInstance();
   await _preferences.setString(_keyUserPosition, userPosition);
  }
  
  static getUserPosition() async{
    SharedPreferences _preferences =await  SharedPreferences.getInstance();
    String position =_preferences.getString(_keyUserPosition).toString();
    return position;
    }
}