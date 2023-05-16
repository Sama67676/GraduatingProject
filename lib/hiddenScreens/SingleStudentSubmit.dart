import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_file_dialog/flutter_file_dialog.dart';
import 'package:graduating_project_transformed/hiddenScreens/NewPost.dart';
import 'package:path_provider/path_provider.dart';
String? description;
String? attachmentType;
String? attachment;
String? points;
String? comment;
TextEditingController _comment = TextEditingController();
class SingleStudentSubmit extends StatefulWidget {
   SingleStudentSubmit({ this.courseId, this.postId, this.userId, this.time, this.submitId, this.isMarked});
 final String? courseId;
 final String? postId;
 final String? userId;
 final String? time;
final String? submitId;
final String? isMarked;
  @override
  State<SingleStudentSubmit> createState() => _SingleStudentSubmitState( this.courseId, this.postId, this.userId, this.time, this.submitId, this.isMarked);
}

class _SingleStudentSubmitState extends State<SingleStudentSubmit> {
final String? courseId;
 final String? postId;

 final String? userId;
 final String? time;
 final String? submitId;
 final String? isMarked;
_SingleStudentSubmitState( this.courseId, this.postId,this.userId, this.time, this.submitId, this.isMarked);

 

@override
  void initState() {
   fetchData();
    super.initState();
  }
   Future<void> fetchData() async {
    await FirebaseFirestore.instance
        .collection('courses')
            .doc(courseId).collection('posts')
            .doc(postId).collection('submits').doc(submitId)
        .get()
        .then((snapshot) async {
      if (snapshot.exists) {
        setState(() {
          description = snapshot.data()!['description'];
          attachmentType = snapshot.data()!['attachmentType'];
          attachment = snapshot.data()!['attachement'];
          points= snapshot.data()!['points'];
          comment= snapshot.data()!['comment'];
        });
      }
    });
    
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Container(
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
        child: SafeArea(child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                 Expanded(
                      flex: 1,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children:  [
                    
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal:8.0),
                        child: IconButton(
                                      icon: const Icon(Icons.arrow_back_ios,
                                          size: 30,
                                          color: Color.fromARGB(255, 8, 61, 104)),
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                    ),
                      ),
                             
                      ],),
                    ),
                   Expanded(
                     child: Padding(
                       padding: const EdgeInsets.symmetric(horizontal:24),
                       child: Container(
                         constraints: const BoxConstraints(
                            maxWidth: 300,
                         ),
                         child: StreamBuilder<DocumentSnapshot>(
                            stream:FirebaseFirestore.instance.collection("users").doc(userId).snapshots(),
                             builder: (context, snapshot) {
                                  if (snapshot.data != null) {
                                  return 
                                  
                                  Container(
                                     constraints: const BoxConstraints(
                                     maxWidth: 140,
                                  ),
                                    child: Padding(
                                      padding: const EdgeInsets.only(top:8.0, right: 8, bottom: 8),
                                      child: Text("${snapshot.data?['Name']}'s submit:",
                                         style: const TextStyle(color: const Color.fromARGB(255, 8, 61, 104),
                                                fontFamily: 'HP Simplified Light', fontWeight: FontWeight.bold,
                                                fontSize: 34,)),
                                    ),
                                  );
                                     
                                
                            } else{
                             return  Container();
                             }
                          } 
                          ),
                
                       ),
                     ),
                   ),
                    Expanded(
                      flex: 9,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal:18, vertical: 10),
                        child: Card(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(25),
                                ),
                                elevation: 0,
                                color: const Color.fromARGB(255, 8, 61, 104),
                                child:Padding(
                                  padding: const EdgeInsets.symmetric(vertical:18,horizontal: 5),
                                  child: Stack(
                                    children: [
                                      SingleChildScrollView(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                            Row(
                                               children: [
                                                 StreamBuilder<DocumentSnapshot>(
                                                  stream:FirebaseFirestore.instance.collection("users").doc(widget.userId).snapshots(),
                                                   builder: (context, snapshot) {
                                        if (snapshot.data != null) {
                                        return  Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Row(
                                         mainAxisAlignment: MainAxisAlignment.start,
                                          children: [
                                           Padding(
                                             padding: const EdgeInsets.only(top:8.0, bottom: 8, right: 8, left: 3),
                                             child: InkWell(
                                              onTap: (){
                                                print(attachment);
                                              },
                                               child: CircleAvatar(
                                                radius: 24,
                                                backgroundColor: Colors.white,
                                               backgroundImage: NetworkImage(snapshot.data?['imgUrl']),
                                                ),
                                             ),
                                           ),
                                          
                                          Container(
                                             constraints: const BoxConstraints(
                                             maxWidth: 140,
                                         ),
                                            child: Padding(
                                              padding: const EdgeInsets.only(top:8.0, right: 8, bottom: 8),
                                              child: Text( '${snapshot.data?['Name']} :' ,
                                                 style: const TextStyle(color: Colors.white,
                                                        fontFamily: 'HP Simplified Light', fontWeight: FontWeight.bold,
                                                        fontSize: 22,)),
                                            ),
                                          ),
                                              Padding(
                                              padding:const EdgeInsets.symmetric( horizontal: 14),
                                             child:
                                                                            
                                                    Text(widget.time!, style: const TextStyle(
                                                     fontFamily: 'HP Simplified Light', fontWeight: FontWeight.bold,
                                                    fontSize: 14, color: Colors.white54),),
                                                    ),
                                          ],
                                          ),
                                        );
                                         } else{
                                         return  Container();
                                          }
                                       } 
                                       ),
                                         ],
                                          ),
                                     Padding(
                                       padding: const EdgeInsets.symmetric(vertical:8.0, horizontal: 18),
                                       child: Text(description?? '', style: TextStyle(color: Colors.white,
                                       fontFamily: 'HP Simplified Light', fontWeight: FontWeight.bold,
                                       fontSize: 20,
                                       ),),
                                     ),
                                    attachment !=null?
                                    Padding(
                                      padding: const EdgeInsets.symmetric(vertical:8.0, horizontal: 18),
                                      child: InkWell(
                                        child: Container(height: 50, 
                                        width: 100, 
                                        decoration: BoxDecoration( borderRadius: BorderRadius.circular(20),
                                        color: Colors.white,),
                                        child: attachmentType =='image'?
                                        Row(
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.symmetric(horizontal:4),
                                              child: Icon(Icons.image, color: Color.fromARGB(255, 8, 61, 104),),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.symmetric(horizontal:2),
                                              child: Text('Image', style: TextStyle(color: Color.fromARGB(255, 8, 61, 104),
                                                                                   fontFamily: 'HP Simplified Light', fontWeight: FontWeight.bold,
                                                                                   fontSize: 20,
                                                                                  ),),
                                            ),
                                          ],
                                        ):attachmentType =='pdf'?
                                        Row(
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.symmetric(horizontal:6),
                                              child: Icon(Icons.file_copy, color: Color.fromARGB(255, 8, 61, 104),),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.symmetric(horizontal:2),
                                              child: Text('pdf', style: TextStyle(color: Color.fromARGB(255, 8, 61, 104),
                                                                                   fontFamily: 'HP Simplified Light', fontWeight: FontWeight.bold,
                                                                                   fontSize: 20,
                                                                                  ),),
                                            ),
                                          ],
                                        ):attachmentType =='Audio'?
                                        Row(
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.symmetric(horizontal:6),
                                              child: Icon(Icons.audio_file, color: Color.fromARGB(255, 8, 61, 104),),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.symmetric(horizontal:2),
                                              child: Text('Audio', style: TextStyle(color: Color.fromARGB(255, 8, 61, 104),
                                                                                   fontFamily: 'HP Simplified Light', fontWeight: FontWeight.bold,
                                                                                   fontSize: 20,
                                                                                  ),),
                                            ),
                                          ],
                                        ):
                                      
                                        Icon(Icons.error),
                                        ),
                                      onTap: (){
                                        downloadFiles(attachment!);
                                      },
                                      ),
                                    ):
                                    Container(height: 1, width: 1,),
                                    
                                    const  SizedBox(height: 30,),
                                    const Padding(
                                      padding: EdgeInsets.symmetric(horizontal:18.0),
                                      child: Divider(
                                          thickness:2,
                                          color: Colors.white,
                                      ),
                                    ),
                                    isMarked!= 'true'?const Padding(
                                      padding: EdgeInsets.all(18.0),
                                      child: Text('set points: ', style: TextStyle(color: Colors.white,
                                       fontFamily: 'HP Simplified Light', fontWeight: FontWeight.bold,
                                       fontSize: 20,
                                      ),),
                                     ): Container(height: 1, width: 1,),
                                      isMarked!= 'true'?Padding(
                                      padding: const EdgeInsets.symmetric(horizontal:24,),
                                      child: Container(
                                        height: 80,
                                        width: 50,
                                        child: ListWheelScrollView.useDelegate(
                                          perspective: 0.005,
                                          onSelectedItemChanged: (value) {
                                            setState(() {
                                                 points= value.toString();
                                            });
                                          },
                                          physics: const FixedExtentScrollPhysics(),
                                           itemExtent: 20, 
                                         childDelegate: ListWheelChildBuilderDelegate(
                                          childCount: 101,
                                           builder: (context, index){
                                             return Container(
                                           child: Text(index.toString(), style:  TextStyle(fontSize: 20, color:points == index.toString()? Colors.white: Colors.white30,  fontFamily: 'HP Simplified Light', fontWeight: FontWeight.bold),),
                                          );
                                        })),
                                       )
                                       
                                      ):
                                      Padding(
                                        padding: const EdgeInsets.symmetric(vertical:8.0, horizontal: 18),
                                        child: Text('$points points',style: TextStyle(color: Colors.white,
                                          fontFamily: 'HP Simplified Light', fontWeight: FontWeight.bold,
                                          fontSize: 20,) ),
                                      ),
                                       isMarked!= 'true'?Padding(
                                        padding: const EdgeInsets.all(18.0),
                                        child: Text('add comment: ', style: TextStyle(color: Colors.white,
                                        fontFamily: 'HP Simplified Light', fontWeight: FontWeight.bold,
                                        fontSize: 20,
                                        ),),
                                      ):
                                      comment != null?Padding(
                                        padding: const EdgeInsets.only(bottom:8.0, left: 18, right: 18, top: 24),
                                        child: Text('Comment: ', style: TextStyle(color: Colors.white,
                                          fontFamily: 'HP Simplified Light', fontWeight: FontWeight.bold,
                                          fontSize: 24,
                                          ),),
                                      ):
                                      Container(height: 1, width: 1,),
                                      comment != null?Padding(
                                        padding: const EdgeInsets.symmetric(vertical:8.0, horizontal: 18),
                                        child: Text(comment!, style: TextStyle(color: Colors.white,
                                          fontFamily: 'HP Simplified Light', fontWeight: FontWeight.bold,
                                          fontSize: 20,
                                          ),),
                                      ):
                                      Container(height: 1, width: 1,),
                                      isMarked!= 'true'?Padding(
                                         padding: EdgeInsets.only(
                                            left: 10.0, right: 10, bottom: 18 ),
                                        child: Container(
                                          height: 100,
                                           child: Material(
                                             color: Colors.white,
                                             elevation: 4,
                                            shape: RoundedRectangleBorder(
                                               borderRadius: BorderRadius.all(
                                                 Radius.circular(30),
                                               ),
                                              ),
                                             child: Padding(
                                                 padding: EdgeInsets.symmetric(
                                                    horizontal: 10,
                                                    vertical: 12,
                                                  ),
                                                  child: Padding(
                                                    padding: const EdgeInsets.all(6),
                                                    child: TextField(
                                        controller: _comment,
                                         decoration: InputDecoration(
                                            border: InputBorder.none,
                                            hintText:
                                                'Write your Comment',
                                            hintStyle: TextStyle(
                                                color: Colors.black38)),
                                        
                                                   ),
                                                 )
                                                 ),
                                           ),
                                         ),
                                           ):
                                           Container(height: 1, width: 1,),
                                         ],
                                     ),
                                      ),

                                isMarked!= 'true'?Positioned(
                             
                                right: 20,
                                bottom: 30,
                                child: InkWell(
                                  child: Container(
                                      width: 80,
                                      height: 55,
                                       child: Material(
                                        elevation: 4,
                                        
                                        borderRadius: const BorderRadius.all(
                                         Radius.circular(35),
                                         ),
                                        color:  const Color(0xFFCCCED3),
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
                                          child: Icon( Icons.done,
                                          size: 30,
                                          color: Color.fromARGB(255, 8, 61, 104)),
                                        ),
                                       ),
                                     ),
                                     onTap: ()
                                     {
                                          markingSubmits(courseId!, postId!, submitId!);
                                     },
                                ),
                              ):
                              Container(height: 1, width: 1,),
                                    ],
                                  )
        ),
      )
    ),
    
                    ),
              ]
        )
        )
      )
    );
  }
}

void markingSubmits(String courseId,String postId, String submitId)async{
  FirebaseFirestore.instance.collection('courses')
            .doc(courseId).collection('posts')
            .doc(postId).collection('submits').doc(submitId).update({
              'points': points,
              'comment': _comment,
              'isMarked':'true'
            });
}

void downloadFiles(String url)async{
 try {
   final httpsReference = FirebaseStorage.instance.refFromURL(url);
  final appDocDir = await getApplicationDocumentsDirectory();
  final filePath = appDocDir.absolute.path +'/' + httpsReference.name;
  Directory? directory;
    if (Platform.isIOS) {
      directory = await getDownloadsDirectory();
      print(directory?.path);
    } else if (Platform.isAndroid) {
      // For Android get the application's scoped cache directory
      directory = await getTemporaryDirectory();
    }
      if (directory == null) {
      throw Exception('Could not access local storage for '
          'download. Please try again.');
    }
    print('Temp cache save path: ${directory.path}/${httpsReference.name}');
      // Use Dio package to download the short lived url to application cache
      final dio = Dio();
    await dio.download(
      url,
      '${directory.path}/${httpsReference.name}',
    );
     /// For Android call the flutter_file_dialog package, which will give the option to save the now downloaded file by Dio (to temp application cache) to wherever the user wants including Downloads!
      if (Platform.isAndroid) {
      final params = SaveFileDialogParams(
          sourceFilePath: '${directory.path}/${httpsReference.name}');
      final filePath =
          await FlutterFileDialog.saveFile(params: params);

      print('Download path: $filePath');
    }
 } catch (e) {
   
 }
  
}
