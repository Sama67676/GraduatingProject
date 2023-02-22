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

  void pickImage() async {
    photo = await ImagePicker()
        .pickImage(source: ImageSource.gallery, imageQuality: 25);
    uploadpfp();
  }

  Future<void> uploadpfp() async {
    File? imagefile = File(photo!.path);
    try {
      Reference ref = FirebaseStorage.instance.ref('files/${imagefile.path}');
      UploadTask uploadTask = ref.putFile(imagefile);
      final snapshot = await uploadTask.whenComplete(() => null);
    } catch (e) {
      print(e);
    }
  }

  Future<String> getDowmload() async {
    File? imagefile = File(photo!.path);
    return firebase_storage.FirebaseStorage.instance
        .ref('files/${imagefile.path}')
        .getDownloadURL();
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            resizeToAvoidBottomInset: true,
            backgroundColor: Colors.blue.shade200,
            body: Form(
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
                      onTap: () {
                        pickImage();
                      },
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
                        await uploadpfp().then((value) => {});
                        String value = await getDowmload();
                        try {
                          await Authintication()
                              .createUserAnonymous(
                                  email,
                                  password,
                                  Name,
                                  department,
                                  year,
                                  value != null ? value : "",
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
            )));
  }
}
