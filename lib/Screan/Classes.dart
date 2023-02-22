import 'package:flutter/material.dart';

class ClassesScreen extends StatelessWidget {
  const ClassesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
        child: SafeArea(
            child: Padding(
          padding:
              const EdgeInsets.only(left: 25, right: 15, bottom: 5, top: 5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(
                height: 65,
              ),
              Material(
                elevation: 10,
                borderRadius: BorderRadius.all(Radius.circular(35)),
                child: Container(
                  decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(35)),
                      boxShadow: [
                        BoxShadow(
                            color: Color.fromARGB(255, 8, 61, 104), //New
                            blurRadius: 0,
                            offset: Offset(-10, 0)),
                      ]),
                  child: Material(
                    color: Colors.white,
                    elevation: 1, //shadows
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(35),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(25),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Internet Programming',
                              style: TextStyle(
                                fontSize: 25,
                                color: Colors.indigo[900],
                              )),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            'HTML - JavaScript',
                            style: TextStyle(
                              fontSize: 15,
                              color: Colors.indigo[900],
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              Container(
                                height: 35,
                                width: 35,
                                decoration: BoxDecoration(
                                  color: (const Color.fromRGBO(17, 58, 99, 1)),
                                  borderRadius: BorderRadius.circular(50),
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Text('Wasseem Nahi',
                                  style: TextStyle(
                                    fontSize: 15,
                                    color: Colors.black45,
                                  ))
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        )),
      ),
    );
  }
}
