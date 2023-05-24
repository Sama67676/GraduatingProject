import '../others/Prefrences.dart';
import 'StudentsList.dart';

import 'addNewStudent2.dart';
import 'addNewTeacher.dart';
import 'profile_screen.dart';
import 'package:flutter/material.dart';

import 'TeachersList.dart';
String name ='loading';
String reName= 'loading';

class MenuScreen extends StatefulWidget {
  static const String ScreanRoute = 'menu_Screen';
   const MenuScreen({super.key});

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {

@override
  void initState() {
    getprefrences();
    super.initState();
  }
  void getprefrences(){
     UserPrefrences().getUserName().then((value){
    setState(() {
           name= value.toString();
             print(name.toString());
             reName= name.substring( 1, name.length - 1 );
    });
    }
    );
   
}

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
                                  children:  [
                                   Text(
                                      reName,
                                      style: const TextStyle(
                                         fontFamily: 'HP Simplified Light', fontWeight: FontWeight.bold,
                                          fontSize: 20, color: Colors.black),
                                    ),
                                    const Text(
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
                    onTap: ()  {
         
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
                              horizontal: 5, vertical: 8),
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
                            horizontal: 5, vertical: 8),
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
                              horizontal: 5, vertical: 8),
                          child: Expanded(
                              flex: 1,
                              child:  creatMenu(
                                    'lessons', Image.asset('images/books.png')),
                               
                              )),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 5, vertical: 8),
                        child: Expanded(
                            flex: 1,
                            child: creatMenu('Notes',
                                  Image.asset('images/note-taking.png')),
                   
                            ),
                      ),
                    ],
                  ),
                  Expanded(
                    flex: 1,
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 5, vertical:8),
                                child: Expanded(
                                    flex: 1,
                                    child: FittedBox(
                                        fit: BoxFit.contain,
                                        child:  creatMenu(
                                              'Saved',
                                              Image.asset(
                                                  'images/bookmark.png')),
                                         
                                        ))),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 5, vertical: 8),
                              child: Expanded(
                                  flex: 1,
                                  child: FittedBox(
                                      fit: BoxFit.contain,
                                      child: creatMenu(
                                            'Library',
                                            Image.asset(
                                                'images/online-library.png')),
                                       )),
                            ),
                          ],
                        ),
                       Row(
                          children: [
                            Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 5, vertical: 8),
                                child: Expanded(
                                    flex: 1,
                                    child: FittedBox(
                                        fit: BoxFit.contain,
                                        child: InkWell(
                                          child: creatMenu(
                                              'Add teacher',
                                              Image.asset(
                                                  'images/addTeacher.png')),
                                          onTap: () {
                                              Navigator.push(
                                                context,
                                                 MaterialPageRoute(
                                                 builder: (contex) => const AddNewTeacher()));
                                          },
                                        )))),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 5, vertical: 8),
                              child: Expanded(
                                  flex: 1,
                                  child: FittedBox(
                                      fit: BoxFit.contain,
                                      child: InkWell(
                                        child: creatMenu(
                                            'Add student',
                                            Image.asset(
                                                'images/addStudent.png')),
                                        onTap: () {
                                             Navigator.push(
                                                context,
                                                 MaterialPageRoute(
                                                 builder: (contex) => const AddNewStudent2()));
                                        },
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
    width: 180,
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
                maxLines: 2,
                overflow: TextOverflow.clip,
                style: const TextStyle(fontSize: 18, color: Colors.black,
                 fontFamily: 'HP Simplified Light', fontWeight: FontWeight.bold,
                 ),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
