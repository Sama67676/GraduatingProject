import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../Widgets/myTextField.dart';
import '../Others/auth.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

import '../main.dart';

class NewUserScreen extends StatefulWidget {
  static const String ScreanRoute = 'New_User';

  @override
  State<NewUserScreen> createState() => _NewUserScreenState();
}

class _NewUserScreenState extends State<NewUserScreen> {
  XFile? photo;

  String Name = "";

  String email = "";

  String password = "";

  String department = "";

  String year = "";

  String repeatedPassowrd = "";

  bool _isLoading = false;

  String position = 'Student';
  var items = [
    'Student',
    'Teacher',
    'Emplyee',
  ];

 

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            resizeToAvoidBottomInset: true,
        
            body:  Container(
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
              child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      InkWell(
                        child: CircleAvatar(
                            radius: 50,
                            backgroundColor: Colors.indigo,
                            backgroundImage: photo != null
                                ? FileImage(File(photo!.path))
                                : null,
                            child: photo == null
                                ? const Icon(
                                    Icons.person,
                                    size: 60,
                                    color: Colors.white,
                                  )
                                : null),
                       
                      ),
                      const SizedBox(height: 8),
                      MyTextField(
                        onChanged: (value) {
                          email = value;
                        },
                        hint: 'Enter the email here',
                      ),
                      MyTextField(
                        onChanged: (value) {
                          password = value;
                        },
                        hint: 'Enter the Password here',
                      ),
                      MyTextField(
                        onChanged: (value) {
                          Name = value;
                        },
                        hint: 'Enter the Name here',
                      ),
                      const SizedBox(height: 8),
                      MyTextField(
                        onChanged: (value) {
                          department = value;
                        },
                        hint: 'Enter the Department here',
                      ),
                      const SizedBox(height: 8),
                      MyTextField(
                        onChanged: (value) {
                          year = value;
                        },
                        hint: 'Enter the year here',
                      ),
                      
                      const SizedBox(height: 8),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 25),
                        child: DropdownButton(
                            value: position,
                            icon: const Icon(Icons.keyboard_arrow_down),
                            items: items.map((String items) {
                              return DropdownMenuItem(
                                value: items,
                                child: Text(items),
                              );
                            }).toList(),
                            onChanged: (String? newValue) {
                              setState(() {
                                position = newValue!;
                              });
                            }),
                      ),
                      const SizedBox(height: 25),
                      ElevatedButton(
                        onPressed: () async {
                          setState(() {
                            _isLoading = true;
                          });
                        
                          try {
                            await Authintication()
                                .createUserAnonymous(
                                    email,
                                    password,
                                    Name,
                                    department,
                                    year,
                                  position)
                                .then((value) {
                              setState(() {
                                _isLoading = false;
                              });
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (contex) =>
                                          ButtomNavigationBar()));
                            });
                          } on FirebaseException catch (e) {
                            print(e);
                            setState(() {
                              _isLoading = false;
                            });
                          }
                        },
                        child: Text('create new user'),
                      ),
                    ],
                  ),
                ),
            ),
            ));
  }
}
