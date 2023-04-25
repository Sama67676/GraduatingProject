import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:provider/provider.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';

// ignore: unused_import
import '../main.dart';

import 'Others/auth_notifier.dart';
import 'Screan/Classes.dart';

import 'Screan/OpeningScreen1.dart';
import 'Screan/ScheduleScreen.dart';

import 'Screan/SwaipableChats.dart';
import 'Screan/menuScreen.dart';
import 'Screan/newUserScreen.dart';

import 'Screan/ChatList.dart';
import 'Screan/OpeningScreen1.dart';
import 'package:firebase_core/firebase_core.dart';

import 'StudentsScreens/S_Callender.dart';
import 'StudentsScreens/S_Classes.dart';
import 'StudentsScreens/S_Menu.dart';
import 'StudentsScreens/S_Swipeable_chats.dart';
import 'Widgets/MyIcons.dart';
import 'others/GlobalVariables.dart';
import 'others/Prefrences.dart';
import 'others/groupList.dart';
import 'others/underInstruction.dart';



void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(ChangeNotifierProvider(create: (_) => AuthNotifier(), child: My()));
}


class My extends StatefulWidget {
  My({super.key});

  @override
  State<My> createState() => _MyState();
}

class _MyState extends State<My> {
  final _auth = FirebaseAuth.instance;
  late StreamSubscription<User?> user;
  

  @override
  void initState() {
    super.initState();
    AuthNotifier authNotifier =
        Provider.of<AuthNotifier>(context, listen: false);
         user = FirebaseAuth.instance.authStateChanges().listen((user) {
      if (user == null) {
        print('User is currently signed out!');
      } else {
        print('User is signed in!');
        print(Variables.glopalPosition);
      }
    });
        
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    AuthNotifier authNotifier = Provider.of<AuthNotifier>(context);
    
    return MaterialApp(
      home:  Variables.glopalPosition =='Teacher'?const ButtomNavigationBar():
      ButtomNavigationBarStudents(),
      initialRoute: FirebaseAuth.instance.currentUser == null 
          ? 'OpeningScreen'
          : Variables.glopalPosition =='Teacher'? ButtomNavigationBar.ScreanRoute:
          ButtomNavigationBarStudents.ScreanRoute,
      routes: {
        'OpeningScreen': (context) => const OpeningScreen1(),
        ButtomNavigationBar.ScreanRoute: (context) =>
            const ButtomNavigationBar(),
        ButtomNavigationBarStudents.ScreanRoute: (context) =>
            const ButtomNavigationBarStudents()
      },
    );
  }
}


//  for teachers
class ButtomNavigationBar extends StatefulWidget  {
  static const String ScreanRoute = 'SalmonBar_Screen';
  static const title = 'salomon_bottom_bar';

  const ButtomNavigationBar({super.key});

  @override
  State<ButtomNavigationBar> createState() => _ButtomNavigationBarState();
}

class _ButtomNavigationBarState extends State<ButtomNavigationBar> with WidgetsBindingObserver{
  int _currentIndex = 0;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final List<Widget> children = [
    UnderInstructions(),
    const SwipableChats(),
    const ClassesScreen(),
    const calender(),
     MenuScreen(),
    
  ];
  
void notificationsPermission()async{
  FirebaseMessaging messaging = FirebaseMessaging.instance;

NotificationSettings settings = await messaging.requestPermission(
  alert: true,
  announcement: false,
  badge: true,
  carPlay: false,
  criticalAlert: false,
  provisional: false,
  sound: true,
);
print('User granted permission: ${settings.authorizationStatus}');

FirebaseMessaging.onMessage.listen((RemoteMessage message) {
  print('Got a message whilst in the foreground!');
  print('Message data: ${message.data}');

  if (message.notification != null) {
    print('Message also contained a notification: ${message.notification}');
  }
});
}

void setStatus(String status)async{
  AuthNotifier authNotifier =
        Provider.of<AuthNotifier>(context, listen: false);
 await _firestore.collection('users').doc(FirebaseAuth.instance.currentUser!.uid).update({'onlineStatus': status});
}

@override
  void initState() {
    super.initState();
    notificationsPermission();
    WidgetsBinding.instance.addObserver(this);
    setStatus('online');
  }


  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      // online
      setStatus("Online");
    } else {
      // offline
      setStatus("Offline");
    }
  }



  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: ButtomNavigationBar.title,
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Scaffold(
        body: children[_currentIndex],
        bottomNavigationBar: SalomonBottomBar(
          currentIndex: _currentIndex,
          onTap: (i) => setState(() => _currentIndex = i),
          items: [
            /// Home
            SalomonBottomBarItem(
             icon: const Icon(Icons.home),
              title: const Text("Home", style: TextStyle(color: Color.fromARGB(255, 8, 61, 104),  fontFamily: 'HP Simplified Light', fontWeight: FontWeight.bold),),
              unselectedColor: Color.fromARGB(255, 8, 61, 104),
              selectedColor: Color.fromARGB(255, 8, 61, 104),
            ),

            /// Likes
            SalomonBottomBarItem(
              icon: const Icon(Icons.group),
          
              title: const Text("Groups", style: TextStyle( fontFamily: 'HP Simplified Light', fontWeight: FontWeight.bold),),
               unselectedColor: Colors.indigo.shade900,
              selectedColor: Colors.indigo.shade900,
            ),

            /// Search
            SalomonBottomBarItem(
              icon: const Icon(Icons.book),
              title: const Text("Clases", style: TextStyle( fontFamily: 'HP Simplified Light', fontWeight: FontWeight.bold),),
               unselectedColor: Colors.indigo.shade900,
              selectedColor: Colors.indigo.shade900,
            ),
            SalomonBottomBarItem(
              icon: const Icon(Icons.edit_calendar),
              title: const Text("schedule", style: TextStyle( fontFamily: 'HP Simplified Light', fontWeight: FontWeight.bold),),
              selectedColor: Colors.indigo.shade900,
            ),

            /// Profile
            SalomonBottomBarItem(
              icon: const Icon(Icons.menu),
              title: const Text("Menu", style: TextStyle( fontFamily: 'HP Simplified Light', fontWeight: FontWeight.bold),),
               unselectedColor: Colors.indigo.shade900,
              selectedColor: Colors.indigo.shade900,
            ),
          ],
        ),
      ),
    );
  }
}

//fpr students
class ButtomNavigationBarStudents extends StatefulWidget  {
  static const String ScreanRoute = 'SalmonBar_Screen';
  static const title = 'salomon_bottom_bar';

  const ButtomNavigationBarStudents({super.key});

  @override
  State<ButtomNavigationBarStudents> createState() => _ButtomNavigationBarStudentsState();
}

class _ButtomNavigationBarStudentsState extends State<ButtomNavigationBarStudents> with WidgetsBindingObserver{
  int _currentIndex = 0;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final List<Widget> children = [
    UnderInstructions(),
    const S_SwipableChats(),
    const S_ClassesScreen(),
    const S_calender(),
    const S_MenuScreen(),
  

    
  ];
  
void notificationsPermission()async{
  FirebaseMessaging messaging = FirebaseMessaging.instance;

NotificationSettings settings = await messaging.requestPermission(
  alert: true,
  announcement: false,
  badge: true,
  carPlay: false,
  criticalAlert: false,
  provisional: false,
  sound: true,
);
print('User granted permission: ${settings.authorizationStatus}');

FirebaseMessaging.onMessage.listen((RemoteMessage message) {
  print('Got a message whilst in the foreground!');
  print('Message data: ${message.data}');

  if (message.notification != null) {
    print('Message also contained a notification: ${message.notification}');
  }
});
}

void setStatus(String status)async{
  AuthNotifier authNotifier =
        Provider.of<AuthNotifier>(context, listen: false);
 await _firestore.collection('users').doc(FirebaseAuth.instance.currentUser!.uid).update({'onlineStatus': status});
}

@override
  void initState() {
    super.initState();
    notificationsPermission();
    WidgetsBinding.instance.addObserver(this);
    setStatus('online');
  }


  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      // online
      setStatus("Online");
    } else {
      // offline
      setStatus("Offline");
    }
  }



  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: ButtomNavigationBar.title,
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Scaffold(
        body: children[_currentIndex],
        bottomNavigationBar: SalomonBottomBar(
          currentIndex: _currentIndex,
          onTap: (i) => setState(() => _currentIndex = i),
          items: [
            /// Home
            SalomonBottomBarItem(
             icon: const Icon(Icons.home),
              title: const Text("Home", style: TextStyle(color: Color.fromARGB(255, 8, 61, 104),  fontFamily: 'HP Simplified Light', fontWeight: FontWeight.bold),),
              unselectedColor: Color.fromARGB(255, 8, 61, 104),
              selectedColor: Color.fromARGB(255, 8, 61, 104),
            ),

            /// Likes
            SalomonBottomBarItem(
              icon: const Icon(Icons.group),
          
              title: const Text("Groups", style: TextStyle( fontFamily: 'HP Simplified Light', fontWeight: FontWeight.bold),),
               unselectedColor: Colors.indigo.shade900,
              selectedColor: Colors.indigo.shade900,
            ),

            /// Search
            SalomonBottomBarItem(
              icon: const Icon(Icons.book),
              title: const Text("Clases", style: TextStyle( fontFamily: 'HP Simplified Light', fontWeight: FontWeight.bold),),
               unselectedColor: Colors.indigo.shade900,
              selectedColor: Colors.indigo.shade900,
            ),
            SalomonBottomBarItem(
              icon: const Icon(Icons.edit_calendar),
              title: const Text("schedule", style: TextStyle( fontFamily: 'HP Simplified Light', fontWeight: FontWeight.bold),),
              selectedColor: Colors.indigo.shade900,
            ),

            /// Profile
            SalomonBottomBarItem(
              icon: const Icon(Icons.menu),
              title: const Text("Menu", style: TextStyle( fontFamily: 'HP Simplified Light', fontWeight: FontWeight.bold),),
               unselectedColor: Colors.indigo.shade900,
              selectedColor: Colors.indigo.shade900,
            ),
          ],
        ),
      ),
    );
  }
}