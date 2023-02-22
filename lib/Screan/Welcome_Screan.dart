import 'package:flutter/material.dart';
import '../main.dart';

import '../Widgets/my_button.dart';
import 'Signin.dart';

class WelcomeScrean extends StatefulWidget {
  static const String screanroute = 'Welcome_Screan';

  const WelcomeScrean({super.key});

  @override
  State<WelcomeScrean> createState() => _WelcomeScreanState();
}

class _WelcomeScreanState extends State<WelcomeScrean> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue.shade200,
      body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Column(
                children: [
                  SizedBox(
                    height: 180,
                    child: Image.asset('images/iraqia logo.jpg'),
                  ),
                  const Text(
                    'Al_iraqia University',
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.w400,
                      color: Color.fromARGB(255, 18, 86, 142),
                    ),
                  )
                ],
              ),
              const SizedBox(height: 15),
              Mybutton(
                color: Colors.green.shade700,
                title: 'Log in',
                textColor: Colors.black,
                onPressed: () {
                  Navigator.pushNamed(context, SignIn.ScreanRoute);
                },
              ),
              Mybutton(
                color: Colors.blue.shade900,
                title: 'Guest',
                textColor: Colors.white,
                onPressed: () {
                  Navigator.pushNamed(context, ButtomNavigationBar.ScreanRoute);
                },
              ),
            ],
          )),
    );
  }
}
