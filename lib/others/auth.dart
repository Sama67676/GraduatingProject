// ignore_for_file: non_constant_identifier_names, unused_local_variable, unnecessary_null_comparison, use_build_context_synchronously, avoid_init_to_null

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';


import '../main.dart';
import 'auth_notifier.dart';
import 'user_Entity.dart';

class Authintication {
  final FirebaseAuth auth = FirebaseAuth.instance;

  Future<void> createUserAnonymous(String email, String password, String Name,
      String department, String year,  String position) async {
    UserCredential userCredential =
        await FirebaseAuth.instance.signInAnonymously();

    final Convert = EmailAuthProvider.credential(
        email: email.trim(), password: password.trim());
    final List<Map> friendsId= [];
    final userConvert =
        await FirebaseAuth.instance.currentUser!.linkWithCredential(Convert);
    Map<String, dynamic> userInfoMap = {
      "uid": FirebaseAuth.instance.currentUser!.uid,
      "email": email,
      "password": password,
      "Name": Name,
      "lowercaseName": Name.toLowerCase(),
      "department": department,
      "year": year,
      "imgUrl": '',
      "status": "",
      "friendsId": friendsId,
      "position": position,
      "onlineStatus":"",
      "deviceToken":"",
      "typingTo":""
      
    };
    if (userCredential != null) {
      DatabaseMethods().addUserInfoToDB(auth.currentUser!.uid, userInfoMap);
    }
  }



  Future<void> login(UserModel userModel, AuthNotifier authNotifier,
      BuildContext context) async {
    UserCredential resault;
    try {
      resault = await auth.signInWithEmailAndPassword(
          email: userModel.email ?? "", password: userModel.password ?? "");
      if (resault != null) {
        User? user = auth.currentUser;
        if (user!.emailVerified) {
          auth.signOut();
          print('email not verifyed');
        } else if (user != null) {
          print('$user is logged in');
          authNotifier.setUser(user);
          await getUserDetails(authNotifier);
          print('done');
          if (authNotifier.userDetails?.position == 'Student') {
            Navigator.push(context,
                MaterialPageRoute(builder: (contex) => ButtomNavigationBar()));
            initializeCurrentUser(authNotifier);
          }
        }
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> initializeCurrentUser(AuthNotifier authNotifier) async {
    User? user = auth.currentUser;
    if (user != null) {
      authNotifier.setUser(user);
      await getUserDetails(authNotifier);
    }
      final FirebaseMessaging _fcm = FirebaseMessaging.instance;
      _fcm.getToken().then((token)async{
      print('token is: $token');
      await FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser!.uid).update({
        "deviceToken":token,
      });
    });
  }

  Future<void> signout(AuthNotifier authNotifier, BuildContext context) async {
    User? usern = null;
    await auth.signOut();
    authNotifier.setUser(usern!);
    Navigator.pushNamedAndRemoveUntil(context, "signin_screan", (route) => false);
  }

  Future<void> getUserDetails(AuthNotifier authNotifier) async {
    FirebaseFirestore.instance
        .collection('users')
        .doc(authNotifier.user?.uid)
        .get()
        .catchError((e) => print(e))
        .then((value) => (value != null)
            ? authNotifier.setUserDetails(
                UserModel.fromMap(value.data() as Map<String, dynamic>))
            : print(value));
  }
}

class DatabaseMethods {
  String currentUser = FirebaseAuth.instance.currentUser!.uid;
  Future addUserInfoToDB(String userId, Map<String, dynamic> userInfoMap) {
    return FirebaseFirestore.instance
        .collection("users")
        .doc(currentUser)
        .set(userInfoMap);
  }

  Future<DocumentSnapshot> getUserFromDB(String userID) async {
    return FirebaseFirestore.instance.collection("users").doc("uid").get();
  }
}
