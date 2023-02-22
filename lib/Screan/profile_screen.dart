import 'dart:io';

import '../Others/auth_notifier.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:provider/provider.dart';
import '../Others/auth.dart';
import '../Others/fireBase_Storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';


class ProfileScreen extends StatefulWidget {
  static const String ScreanRoute = 'profile_Screen';
  ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final currentUser = FirebaseAuth.instance.currentUser!.uid;
  Authintication _authintication = Authintication();

  String? Name;

  String? email;

  String? department;

  String? status;

  String? year;

  String? imageUrl;

  Future<void> fetchData() async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get()
        .then((snapshot) async {
      if (snapshot.exists) {
        setState(() {
          Name = snapshot.data()!['Name'];
          department = snapshot.data()!['department'];
          status = snapshot.data()!['status'];
          year = snapshot.data()!['year'];
          email = snapshot.data()!['email'];
          imageUrl = snapshot.data()!['imgUrl'];
        });
      }
    });
  }

  Future getCurrentUserId() async {
    return await FirebaseAuth.instance.currentUser!.uid;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchData();
  }

  @override
  Widget build(BuildContext context) {
    final FireBaseStorage storage = FireBaseStorage();
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
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                Row(
                  children: [
                    Positioned.fill(
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: IconButton(
                          icon: const Icon(Icons.arrow_back_ios,
                              color: Color.fromARGB(255, 8, 61, 104)),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                      ),
                    ),
                    // Expanded(
                    //   flex: 1,
                    //   child: IconButton(
                    //     icon: const Icon(Icons.edit,
                    //         color: Color.fromARGB(255, 8, 61, 104)),
                    //     onPressed: () {},
                    //   ),
                    // ),
                  ],
                ),
                Column(
                  children: [
                    Stack(
                      clipBehavior: Clip.none,
                      children: [
                        InkWell(
                          onTap: () {},
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(30),
                            child: const Image(
                              image: AssetImage('images/galaxy.jpg'),
                            ),
                          ),
                        ),
                        Positioned(
                          top: 190,
                          left: 30,
                          child: InkWell(
                              child: CircleAvatar(
                                radius: 50,
                                backgroundImage: imageUrl != null
                                    ? NetworkImage(imageUrl!)
                                    : null,
                                child: imageUrl == null
                                    ? Icon(
                                        Icons.person,
                                        size: 60,
                                        color: Colors.white,
                                      )
                                    : null,
                              ),
                              onTap: () {
                                () async {
                                  final results =
                                      await FilePicker.platform.pickFiles(
                                    allowMultiple: false,
                                    type: FileType.custom,
                                    allowedExtensions: [
                                      'png',
                                      'jpg',
                                    ],
                                  );
                                  if (results == null) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text('no file selected.'),
                                      ),
                                    );
                                    return null;
                                  }
                                  final path = results.files.single.path!;
                                  final fileName =
                                      results.files.single.name; //profile/$uid

                                  storage.uploadFile(
                                      path,
                                      fileName
                                          as File); //we may have to add then and print some message or something
                                };
                              }),
                        ),
                      ],
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 140),
                        child: Text(
                          '$Name',
                          textAlign: TextAlign.start,
                          style: TextStyle(
                              fontSize: 20, color: Colors.indigo[900]),
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 140),
                        child: Text(
                          '$department' + ' ' + '$year' + ' ' + 'year',
                          textAlign: TextAlign.start,
                          style: TextStyle(
                              fontSize: 20, color: Colors.indigo[900]),
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: const EdgeInsets.all(15),
                        child: Text(
                          'bio',
                          textAlign: TextAlign.start,
                          style: TextStyle(
                              fontSize: 20, color: Colors.indigo[900]),
                        ),
                      ),
                    ),
                    InkWell(
                      child: Container(
                        width: 370,
                        height: 80,
                        child: Material(
                          color: Colors.white,
                          elevation: 1, //shadows
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(35),
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(15),
                            child: Text('$status',
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                    fontSize: 20, color: Colors.indigo[900])),
                          ),
                        ),
                      ),
                      onTap: () {
                        // openDialog();
                      },
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Material(
                      color: Colors.indigo[800],
                      borderRadius: BorderRadius.circular(45),
                      child: MaterialButton(
                        onPressed: () {
                          AuthNotifier authNotifier =
                              Provider.of<AuthNotifier>(context, listen: false);
                          if (authNotifier.user != null) {
                            _authintication.signout(authNotifier, context);
                          }
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: const Text(
                            'Log out',
                            style: TextStyle(
                                color: Color.fromARGB(255, 22, 20, 20),
                                fontSize: 15),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// String? StatusChanges;
// Future openDialog() => showDialog(
//     context: context,
//     builder: (context) => AlertDialog(
//           title: const Text("Change Status"),
//           content: TextField(
//             autofocus: true,
//             decoration: InputDecoration(hintText: 'Enter your new status'),
//             onChanged:  (value) {
//                       StatusChanges = value;
//                     },
//           ),
//           actions: [
//             IconButton(
//                 icon: Icon(Icons.check_box),
//                 onPressed: () {
//                   final DocUser =
//                       FirebaseFirestore.instance.collection('users').doc('uid');
//                   DocUser.update({'Status': StatusChanges});
//                   Navigator.pop(context);
//                 })
//           ],
//         ));
