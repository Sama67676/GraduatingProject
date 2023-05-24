
import 'package:flutter/material.dart';

import '../Screan/Signin.dart';

class GuestClasses extends StatelessWidget {
  const GuestClasses({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
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
        child: SafeArea(
          child: Stack(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children:  [
                  const SizedBox(height: 20,),
                  Padding(
                    padding: const EdgeInsets.all(24),
                    child: Container(
                      height: 180,
                      width: 300,
                      child: const Material(
                         color: Colors.white,
                            elevation: 1, //shadows
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(35),
                              ),
                            ),
                      ),
                    ),
                  ),
                  
                const SizedBox(height: 30,),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical:24, horizontal: 30),
                    child: Row(
                      children:  [
                        const Text('if you have an account just ',
                        style: TextStyle(fontFamily: 'HP Simplified Light', fontWeight: FontWeight.bold,
                        color:  Colors.black38,
                        fontSize: 21
                        ),),
                        InkWell(
                          child: const Text('login ',
                          style: TextStyle(fontFamily: 'HP Simplified Light', fontWeight: FontWeight.bold,
                          color:   Color.fromARGB(255, 8, 61, 104),
                          fontSize: 21
                          ),),
                          onTap: (){
                                Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(
                                              builder: (contex) =>
                                                   const SignIn()));
                          },
                        ),
                      ],
                    ),
                  )
                ],
              ),
              Positioned(
                top: 80,
                left: 100,
                child: Container(
                  height: 200,
                  child: Image.asset('images/guestClases.png',)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}