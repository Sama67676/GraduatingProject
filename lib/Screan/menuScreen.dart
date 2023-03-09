import 'package:graduating_project_transformed/Screan/OpeningScreen1.dart';

import '../hiddenScreens/groupProfile.dart';
import 'StudentsList.dart';
import 'profile_screen.dart';
import 'package:flutter/material.dart';

import 'TeachersList.dart';

class MenuScreen extends StatelessWidget {
  static const String ScreanRoute = 'menu_Screen';
  const MenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
            decoration: const BoxDecoration(
                gradient: LinearGradient(
              begin: Alignment(-1.0, 0.0),
              end: Alignment(1.0, 0.0),
              transform: GradientRotation(0.7),
              colors: [
                Color.fromARGB(58, 1, 27, 99),
                Color.fromRGBO(255, 255, 255, 1)
              ],
            )),
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 50,
                  ),
                  InkWell(
                    child: Material(
                      color: Colors.white,
                      elevation: 4,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(30),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 20,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const Expanded(
                              flex: 1,
                              child: CircleAvatar(
                                backgroundImage:
                                    AssetImage('images/personPic.jpg'),
                                radius: 30,
                              ),
                            ),
                            Expanded(
                              flex: 4,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: const [
                                    Text(
                                      'Name',
                                      style: TextStyle(
                                         fontFamily: 'HP Simplified Light', fontWeight: FontWeight.bold,
                                          fontSize: 20, color: Colors.black),
                                    ),
                                    Text(
                                      'See your profile',
                                      style: TextStyle(
                                         fontFamily: 'HP Simplified Light', fontWeight: FontWeight.bold,
                                          fontSize: 15, color: Colors.black26),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: IconButton(
                                onPressed: () {},
                                icon: const Icon(
                                  Icons.more_vert,
                                  color: Colors.black26,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (contex) => ProfileScreen()));
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 15),
                          child: Expanded(
                              flex: 1,
                              child: InkWell(
                                child: creatMenu('Teachers',
                                    Image.asset('images/teacher.png')),
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (contex) =>
                                              const TeachersListScreen()));
                                },
                              ))),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 15),
                        child: Expanded(
                            flex: 1,
                            child: InkWell(
                              child: creatMenu('Students',
                                  Image.asset('images/students (2).png')),
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (contex) =>
                                            const StudentsListScreen()));
                              },
                            )),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 15),
                          child: Expanded(
                              flex: 1,
                              child: InkWell(
                                child: creatMenu(
                                    'lessons', Image.asset('images/books.png')),
                                onTap: () {
                                   Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (contex) =>
                                            const OpeningScreen1()));
                                },
                              ))),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 15),
                        child: Expanded(
                            flex: 1,
                            child: InkWell(
                              child: creatMenu('Notes',
                                  Image.asset('images/note-taking.png')),
                              onTap: () {},
                            )),
                      ),
                    ],
                  ),
                  Expanded(
                    flex: 2,
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 15),
                                child: Expanded(
                                    flex: 1,
                                    child: FittedBox(
                                        fit: BoxFit.contain,
                                        child: InkWell(
                                          child: creatMenu(
                                              'Saved',
                                              Image.asset(
                                                  'images/bookmark.png')),
                                          onTap: () {},
                                        )))),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 15),
                              child: Expanded(
                                  flex: 1,
                                  child: FittedBox(
                                      fit: BoxFit.contain,
                                      child: InkWell(
                                        child: creatMenu(
                                            'Library',
                                            Image.asset(
                                                'images/online-library.png')),
                                        onTap: () {},
                                      ))),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            flex: 1,
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8),
                              child: IconButton(
                                  alignment: Alignment.bottomLeft,
                                  onPressed: () {},
                                  icon: const Icon(
                                    Icons.question_mark_rounded,
                                    size: 40,
                                    color: Color.fromARGB(255, 8, 61, 104),
                                  )),
                            ),
                          ),
                          const Expanded(
                            flex: 4,
                            child: Text(
                              'Help & Support',
                              style: TextStyle(
                                 fontFamily: 'HP Simplified Light', fontWeight: FontWeight.bold,
                                color: Color.fromARGB(255, 8, 61, 104),
                                fontSize: 18,
                              ),
                            ),
                          ),
                          const Expanded(
                            flex: 1,
                            child: Icon(
                              Icons.arrow_drop_down,
                              size: 40,
                              color: Color.fromARGB(255, 8, 61, 104),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const Divider(
                    thickness: 1.5,
                    indent: 16,
                    color: Color.fromARGB(255, 8, 61, 104),
                  ),
                  Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          child: IconButton(
                              alignment: Alignment.bottomLeft,
                              onPressed: () {},
                              icon: const Icon(
                                Icons.settings,
                                size: 40,
                                color: Color.fromARGB(255, 8, 61, 104),
                              )),
                        ),
                      ),
                      const Expanded(
                        flex: 4,
                        child: Text(
                          'Settings & privacy',
                          style: TextStyle(
                             fontFamily: 'HP Simplified Light', fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 8, 61, 104),
                            fontSize: 18,
                          ),
                        ),
                      ),
                      const Expanded(
                        flex: 1,
                        child: Icon(
                          Icons.arrow_drop_down,
                          size: 40,
                          color: Color.fromARGB(255, 8, 61, 104),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            )),
      ),
    );
  }
}

Container creatMenu(String MenuName, Image image) {
  return Container(
    width: 170,
    child: Material(
      color: Colors.white,
      elevation: 4,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(30),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 5,
          vertical: 20,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
                backgroundColor: Colors.white, radius: 30, child: image),
            Padding(
              padding: const EdgeInsets.all(8),
              child: Text(
                '$MenuName',
                style: const TextStyle(fontSize: 20, color: Colors.black,
                 fontFamily: 'HP Simplified Light', fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
