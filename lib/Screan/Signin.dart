import '../Others/auth_notifier.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Others/auth.dart';
import '../Others/user_Entity.dart';
import '../Widgets/my_button.dart';
import '../main.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'Chat_screan.dart';
import 'Registration.dart';

class SignIn extends StatefulWidget {
  static const String ScreanRoute = 'signin_screan';

  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final _auth = FirebaseAuth.instance;
  late String email;
  late String password;
  bool showspinner = false;
  bool _obsecureText = true;
  UserModel _userModel = new UserModel(); //maybe wrong

  Authintication _authintication = new Authintication();

  @override
  void initState() {
    AuthNotifier _authNotifer =
        Provider.of<AuthNotifier>(context, listen: false);
    _authintication.initializeCurrentUser(_authNotifer);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        child: Column(children: [
          ModalProgressHUD(
            inAsyncCall: showspinner,
            child: Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
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
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Form(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Container(
                        height: 240,
                        child: Image.asset('images/homescreenphoto.png'),
                      ),
                      const SizedBox(height: 10),
                      Padding(
                        padding: const EdgeInsets.only(left: 10.0),
                        child: Text(
                          'AL-Iraqia university',
                          textAlign: TextAlign.start,
                          style: TextStyle(
                              fontSize: 25, color: Colors.indigo[900]),
                        ),
                      ),
                      const SizedBox(height: 50),
                      Material(
                        elevation: 5,
                        borderRadius: const BorderRadius.all(
                          Radius.circular(45),
                        ),
                        child: TextField(
                          textAlign: TextAlign.center,
                          onChanged: (value) {
                            email = value;
                            _userModel.email = value.trim();
                          },
                          decoration: const InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            hintText: 'Enter your ID',
                            contentPadding: EdgeInsets.symmetric(
                              vertical: 10,
                              horizontal: 20,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(45),
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.white, width: 1),
                              borderRadius: BorderRadius.all(
                                Radius.circular(45),
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color.fromARGB(255, 8, 61, 104),
                                  width: 2),
                              borderRadius: BorderRadius.all(
                                Radius.circular(45),
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 30),
                      Material(
                        elevation: 5,
                        borderRadius: const BorderRadius.all(
                          Radius.circular(45),
                        ),
                        child: TextField(
                          obscureText: _obsecureText,
                          textAlign: TextAlign.center,
                          onChanged: (value) {
                            password = value.trim();
                            _userModel.password = value;
                          },
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            hintText: 'Enter your password',
                            suffixIcon: GestureDetector(
                              onTap: () {
                                setState(() {
                                  _obsecureText = !_obsecureText;
                                });
                              },
                              child: Icon(
                                _obsecureText
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                                color: Colors.black26,
                              ),
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                              vertical: 10,
                              horizontal: 20,
                            ),
                            border: const OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(45),
                              ),
                            ),
                            enabledBorder: const OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.white, width: 1),
                              borderRadius: BorderRadius.all(
                                Radius.circular(45),
                              ),
                            ),
                            focusedBorder: const OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color.fromARGB(255, 8, 61, 104),
                                  width: 2),
                              borderRadius: BorderRadius.all(
                                Radius.circular(45),
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 30),
                      const SizedBox(height: 30),
                      Row(
                        children: [
                          Expanded(
                            flex: 1,
                            child: Mybutton(
                              color: Colors.white,
                              title: 'Guest',
                              textColor: const Color.fromARGB(255, 8, 61, 104),
                              onPressed: () {
                                Navigator.pushNamed(
                                    context, ButtomNavigationBar.ScreanRoute);
                              },
                            ),
                          ),
                          const SizedBox(width: 20),
                          Expanded(
                            flex: 1,
                            child: Mybutton(
                              color: const Color.fromARGB(255, 8, 61, 104),
                              title: 'Log in',
                              textColor: Colors.white,
                              onPressed: () {
                                AuthNotifier _authNotifer =
                                    Provider.of<AuthNotifier>(context,
                                        listen: false);
                                _authintication.login(
                                    _userModel, _authNotifer, context);
                              },
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ]),
      ),
    );
  }
}

void showSnackBar({required BuildContext context, required String content}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(content),
    ),
  );
}
