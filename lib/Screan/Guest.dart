import 'package:flutter/material.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
import '../GuestScreens/GuestCalendar.dart';
import '../GuestScreens/GuestChatList.dart';
import '../GuestScreens/GuestClasses.dart';
import '../GuestScreens/GuestMenu.dart';
import 'News.dart';

class GuestClass extends StatefulWidget  {
  static const String ScreanRoute = 'SalmonBar_Screen';
  static const title = 'salomon_bottom_bar';

  const GuestClass({super.key});

  @override
  State<GuestClass> createState() => _GuestClassState();
}

class _GuestClassState extends State<GuestClass> with WidgetsBindingObserver{
  int _currentIndex = 0;

  final List<Widget> children = [
    const ApplyScreen(baseUrl: 'https://mohesr.gov.iq/ar/homeNews/newsTerm_more/6',),
    const GuestChatList(),
    const GuestClasses(),
    const GuestCalender(),
     GuestMenu(),
    
  ];
  


@override
  void initState() {
    super.initState();

  }





  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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
              unselectedColor: Colors.indigo.shade900,
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