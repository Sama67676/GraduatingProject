import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';

// ignore: unused_import
import '../main.dart';

import 'Others/auth_notifier.dart';
import 'Screan/Classes.dart';

import 'Screan/Signin.dart';
import 'Screan/menuScreen.dart';
import 'Screan/newUserScreen.dart';

import 'Others/allUsers.dart';

import 'package:firebase_core/firebase_core.dart';

import 'others/groupList.dart';

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

  @override
  void initState() {
    super.initState();
    AuthNotifier authNotifier =
        Provider.of<AuthNotifier>(context, listen: false);
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    AuthNotifier authNotifier = Provider.of<AuthNotifier>(context);
    return MaterialApp(
      home: const ButtomNavigationBar(),
      initialRoute: AuthNotifier().user == null
          ? SignIn.ScreanRoute
          : ButtomNavigationBar.ScreanRoute,
      routes: {
        SignIn.ScreanRoute: (context) => const SignIn(),
        ButtomNavigationBar.ScreanRoute: (context) =>
            const ButtomNavigationBar()
      },
    );
  }
}

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
    NewUserScreen(),
    Allusers(),
    const ClassesScreen(),
    groupList(),
    const MenuScreen(),
  

    
  ];

void setStatus(String status)async{
  AuthNotifier authNotifier =
        Provider.of<AuthNotifier>(context, listen: false);
 await _firestore.collection('users').doc(authNotifier.userDetails!.uid).update({'onlineStatus': status});
}

@override
  void initState() {
    super.initState();
    
    WidgetsBinding.instance.addObserver(this);
    setStatus('online');
  }

@override
void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      setStatus('online');
    }else{
setStatus('offline');
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
              title: const Text("Home"),
              selectedColor: Colors.indigo.shade900,
            ),

            /// Likes
            SalomonBottomBarItem(
              icon: const Icon(Icons.group),
              title: const Text("groups"),
              selectedColor: Colors.indigo.shade900,
            ),

            /// Search
            SalomonBottomBarItem(
              icon: const Icon(Icons.book),
              title: const Text("Clases"),
              selectedColor: Colors.indigo.shade900,
            ),
            SalomonBottomBarItem(
              icon: const Icon(Icons.edit_calendar),
              title: const Text("schedule"),
              selectedColor: Colors.indigo.shade900,
            ),

            /// Profile
            SalomonBottomBarItem(
              icon: const Icon(Icons.menu),
              title: const Text("Menu"),
              selectedColor: Colors.indigo.shade900,
            ),
          ],
        ),
      ),
    );
  }
}
