import 'dart:ui';

import 'package:flutter/material.dart';


import 'Signin.dart';

int pageNum=1;
String title1 ='Welcome to Aliraqia app!';
String title2= 'The main purpose is communication';
String title3= 'Organize time and materials';
String text1= 'this app is an Educational platform developed for both students and teachers to make Education more easier';
String text2= 'Easy communication with your teacher and your classmatesusing groupchats, classrooms and private chats also available';
String text3= 'You can easily find the material orgnized in classes also organize studing time and preparing for exams with callender';
String img1= 'images/OpeningScreen1edited.png';
String img2= 'images/OpeningImage2.png';
String img3= 'images/OpeningImage3.png';

class OpeningScreen1 extends StatefulWidget {
    static const String ScreanRoute = 'OpeningScreen';
  const OpeningScreen1({super.key});

  @override
  State<OpeningScreen1> createState() => _OpeningScreen1State();
}

class _OpeningScreen1State extends State<OpeningScreen1> {
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
        child:Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Expanded(
                  flex: 1,
                  child: SizedBox(height: 1,)),
                Expanded(
                  flex: 2,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 24, right: 24, top: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [ 
                        Expanded(
                          flex: 1,
                          child: pageNum ==1? Container():IconButton(
                            icon: const Icon(Icons.arrow_back_ios,
                                color: Color.fromARGB(255, 8, 61, 104)),
                            onPressed: () {
                              if(pageNum==1){
                              
                              }else  if(pageNum==2){
                                setState(() {
                                  pageNum=1;
                                });
                              }else  if(pageNum==3){
                                setState(() {
                                  pageNum=2;
                                });
                              }
                            },
                          ),
                        ),
                        const Expanded(
                          flex: 11,
                          child: SizedBox(width: 2,)),
                      Expanded(
                        flex: 0,
                        child:pageNum==3?Container(): GestureDetector(
                          onTap: () {
                            if (pageNum==3){

                            }else{
                             Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (contex) =>
                                               const SignIn()));
                            }
                          },
                          child: const Text('Skip', style: TextStyle(color: Colors.white, fontSize: 20,
                           fontFamily: 'HP Simplified Light', fontWeight: FontWeight.bold, ),),
                        ),
                      )
                    ],),
                  ),
                ),
                    Expanded(
                      flex: 11,
                      child: Container(
                        
                                    height: 200,
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 10),
                                      child: Stack(
                                        children: [
                                          Opacity(child: Image.asset(pageNum==1?img1: pageNum==2? img2: img3,color: Colors.black), opacity: 0.9),
                                          ClipRect(
                                            child: BackdropFilter(
                                               filter: ImageFilter.blur(sigmaX: 5, sigmaY: 4),
                                              child: Image.asset(pageNum==1?img1: pageNum==2? img2: img3, 
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                    ),
              
                Expanded(
                  flex:10,
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(35),
                      ),
                    elevation: 0,
                    color:Colors.white,   
                    child: Padding(
                      padding: const EdgeInsets.all(24),
                      child: Column(
                       
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children:  [
                           Expanded(
                            child: Text(pageNum==1? title1: pageNum==2? title2: title3,
                            style: const TextStyle(color: Color.fromRGBO(17, 58, 99, 1),
                            fontFamily: 'HP Simplified Light', fontWeight: FontWeight.bold, 
                            fontSize: 20,
                                               
                            ),
                            ),
                          ),
                     
                            Expanded(
                             child: Text(pageNum==1? text1: pageNum==2? text2: text3,
                                                     style: const TextStyle(color: Colors.black45,
                                                     fontFamily: 'HP Simplified Light', fontWeight: FontWeight.bold, 
                                                     fontSize: 18
                                                     ),
                                                     ),
                           ),
                    Expanded(
                      flex: 2,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            height: 44,
                            width: 100,
                            decoration: BoxDecoration(borderRadius: BorderRadius.circular(22),
                            color: const Color.fromARGB(255, 8, 61, 104)
                            ),
                            child: MaterialButton(
                                    onPressed: () {
                                      if(pageNum==1){
                                        setState(() {
                                          pageNum=2;
                                        });
                                      }
                                      else if(pageNum==2){
                                        setState(() {
                                          pageNum=3;
                                        });
                                      }
                                      else if(pageNum==3){
                                        pageNum=1;
                                          Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (contex) =>
                                             const SignIn()));
                                      }
                                   
                                    },

                                    child:  Padding(
                                      padding: const EdgeInsets.all(10),
                                      child: Text(
                                        pageNum==3?
                                        'Start': 'Next',
                                        style: const TextStyle(
                                           fontFamily: 'HP Simplified Light', fontWeight: FontWeight.bold,
                                            color: Colors.white,
                                            fontSize: 15),
                                      ),
                                    ),
                                    ),
                          ),
                        ],
                      ),
                    ),
                     Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                        Container(
                              height: 10,
                              width: 10,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50),
                                color:  pageNum ==1?Colors.indigo[900]:Colors.black26,
                              ),
                            ),
                            const SizedBox(width: 5,),
                            Container(
                              height: 10,
                              width: 10,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50),
                                color: pageNum ==2?Colors.indigo[900]:Colors.black26,
                              ),
                            ),
                            const SizedBox(width: 5,),
                            Container(
                              height: 10,
                              width: 10,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50),
                                color:  pageNum ==3?Colors.indigo[900]:Colors.black26,
                              ),
                            ),
                       ],),
                        ],                  
                         ),
                    ),       
                   ),
                )
              ],
            ),
          
      ),
      
    );
  }
}