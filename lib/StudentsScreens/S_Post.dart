
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

import 'package:flutter/material.dart';
import 'package:flutter_file_dialog/flutter_file_dialog.dart';
import 'package:graduating_project_transformed/StudentsScreens/ToSubmitToPost.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';


final CommentsController = TextEditingController();
class S_PostScreen extends StatefulWidget {
  S_PostScreen({this.postId,this.title, this.type, this.classId,this.teacherId, this.description,this.attachment, this.attachmentType,this.points,this.DateFromFirebase, this.time});
  String? postId;
  String? classId;
  String? teacherId;
 String? type;
 String? title;
 String? description;
 String? attachment;
 String? attachmentType;
 String? points;
Map<String, dynamic>? DateFromFirebase;
String? time;
  @override
  State<S_PostScreen> createState() => _S_PostScreenState(this.postId,this.title, this.type, this.teacherId, this.classId, this.description,this.attachment,this.attachmentType, this.points, this.DateFromFirebase, this.time);
}

class _S_PostScreenState extends State<S_PostScreen> {
    String? postId;
  String? classId;
  String? teacherId;
 String? type;
 String? title;
  String? description;
  String? attachment;
  String?attachmentType;
  String? points;
Map<String, dynamic>? DateFromFirebase;
String? time;
    _S_PostScreenState(this.postId,this.title,this.type, this.teacherId, this.classId,  this.description,this.attachment,this.attachmentType, this.points,this.DateFromFirebase, this.time);


  
  @override
void initState(){

}

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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
               Padding(
                 padding: const EdgeInsets.only(top:18.0),
                 child: Row(
                        children: [
                         Expanded(
                           child: IconButton(
                                    icon: const Icon(Icons.arrow_back_ios,
                                        size: 30,
                                        color: Color.fromARGB(255, 8, 61, 104)),
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                  ),
                         ),
                        Expanded(
                          flex: 2,
                          child: SizedBox(width: 4,)),
                      Expanded(
                        flex: 0,
                        child: Text(type!,
                           style: TextStyle(
                             fontFamily: 'HP Simplified Light', fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 8, 61, 104),
                            fontSize:35,
                           ),
                          ),
                      ),
                        Expanded(
                          flex: 2,
                          child: SizedBox(width: 4,)),
                           Expanded(
                             child: Text(
                             '-/10',
                             style: TextStyle(
                                fontFamily: 'HP Simplified Light', fontWeight: FontWeight.bold,
                               color: Color.fromARGB(255, 8, 61, 104),
                               fontSize:22,
                             ),
                              ), 
                           ),
                        ],
                      ),
               ),
                  
                
                
                 Expanded(
                  flex: 8,
                  child: Padding(
                    padding: const EdgeInsets.all(24),
                    child:
                        Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25),
                            ),
                            elevation: 0,
                            color: const Color.fromARGB(255, 8, 61, 104),
                            child: Padding(
                              padding: const EdgeInsets.all(24),
                              child: Stack(
                                children: [
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      
                                                      
                                      Row(
                                         children: [
                                           StreamBuilder<DocumentSnapshot>(
                            stream:FirebaseFirestore.instance.collection("users").doc(teacherId).snapshots(),
                             builder: (context, snapshot) {
                                  if (snapshot.data != null) {
                                  return  Row(
                             mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                   Padding(
                                     padding: const EdgeInsets.only(top:8.0, bottom: 8, right: 8, left: 3),
                                     child: CircleAvatar(
                                      radius: 24,
                                      backgroundColor: Colors.white,
                                     backgroundImage: NetworkImage(snapshot.data?['imgUrl']),
                                      ),
                                   ),
                                  
                                  Container(
                           
                                             constraints: const BoxConstraints(
                                             maxWidth: 200,
                                          ),         
                                    child: Padding(
                                      padding: const EdgeInsets.only(top:8.0, right: 8, bottom: 8),
                                      child: Text( '${snapshot.data?['Name']} :' ,
                                         style: const TextStyle(color: Colors.white,
                                                fontFamily: 'HP Simplified Light', fontWeight: FontWeight.bold,
                                                fontSize: 22,)),
                                    ),
                                  ),
                                       Container(
                                             constraints: const BoxConstraints(
                                             maxWidth: 80,
                                          ),         
                                        child: Padding(
                                                                   padding:const EdgeInsets.symmetric( horizontal: 14),
                                                                   child:
                                                                      
                                                                       Text(time!, style: const TextStyle(
                                               fontFamily: 'HP Simplified Light', fontWeight: FontWeight.bold,
                                              fontSize: 14, color: Colors.white54),),
                                                                    
                                                                 ),
                                      ),
                                  ],
                                  );
                            } else{
                             return  Container();
                             }
                          } 
                          ),
                                         
                                         ],
                                       ),
                                     Padding(
                                     padding: const EdgeInsets.symmetric(vertical:8.0),
                                       child: Text(title!,
                                            style: const TextStyle(
                                              fontFamily: 'HP Simplified Light', fontWeight: FontWeight.bold,
                                             color: Colors.white,
                                              fontSize:30,
                                            ),
                                           ),
                                     ),
                                     Padding(
                                    padding: const EdgeInsets.symmetric(vertical:8.0),
                                       child: description !=''? 
                                       Text('Description :',
                                        style: TextStyle(color: Colors.white,
                                              fontFamily: 'HP Simplified Light', fontWeight: FontWeight.bold,
                                              fontSize: 20,
                                             ),):
                                                SizedBox(width: 0, height: 0,)
                                          
                                     ),
                                      Text(description ?? '',
                                        style: TextStyle(color: Colors.white70,
                                              fontFamily: 'HP Simplified Light', fontWeight: FontWeight.bold,
                                              fontSize: 20,
                                             ),),
                                     
                                   attachment !=null?
                                    Padding(
                                      padding: const EdgeInsets.symmetric(vertical:12, ),
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
                                    
                                    const  SizedBox(height: 10,),
                                     
                                      Text('$points points',
                                         style: TextStyle(color: Colors.white,
                                                fontFamily: 'HP Simplified Light', fontWeight: FontWeight.bold,
                                                fontSize: 16,
                                               ),
                                       ),
                                     
                                 
                                    Text('due ${DateFromFirebase!['month']}/${DateFromFirebase!['day']} ${DateFromFirebase!['hour']}:${DateFromFirebase!['minute']} ${DateFromFirebase!['moreve']}',
                                       style: TextStyle(color: Colors.white,
                                                  fontFamily: 'HP Simplified Light', fontWeight: FontWeight.bold,
                                                  fontSize: 16,
                                                 ),
                                                 ),
                                     
                                   
                                    ],
                                  ),
                                  Positioned(
                             
                                right: 20,
                                bottom: 30,
                                child: InkWell(
                                  child: Container(
                                      width: 125,
                                      height: 60,
                                       child: Material(
                                        elevation: 4,
                                        
                                        borderRadius: const BorderRadius.all(
                                         Radius.circular(35),
                                         ),
                                        color:  const Color(0xFFCCCED3),
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
                                          child: Text('Submit',
                                          style: TextStyle(
                                            fontSize: 28,
                                            color: const Color.fromARGB(255, 8, 61, 104), fontFamily: 'HP Simplified Light', fontWeight: FontWeight.bold ),
                                          ),
                                        ),
                                       ),
                                     ),
                                     onTap: (){
                                      Navigator.push(context, MaterialPageRoute(builder: (context)=> ToSubmitToPost(courseId: classId, postId: postId,)));
                                     },
                                ),
                              ),
                                ],
                              ),
                            )),
                  ),
                ),
               
                Expanded(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: InkWell(
                          child: Row(
                                children: [
                                  const Expanded(
                                    flex: 4,
                                    child: Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: Text(
                                         'Comments',
                                        style: TextStyle(
                                           fontFamily: 'HP Simplified Light', fontWeight: FontWeight.bold,
                                          color: Color.fromARGB(255, 8, 61, 104),
                                          fontSize:24,
                                        ),
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
                              onTap: (){
                                showComments(context, classId!, postId!, );
                              },
                        ),
                      ),
                    ],
                  ),
                ),
                
            ],
          ),
        ),
      ),
    ) ;
  }
}
String? messageText;
void showComments(context,String classId, String postId, ){
showModalBottomSheet(context: context, builder: (BuildContext bc){
  return Container(
    color: const Color.fromARGB(255, 8, 61, 104),
    height: MediaQuery.of(context).size.height * .60,
    child:  Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
           Padding(
              padding: const EdgeInsets.all(28),
              child: Container(
                height: 30,
                child: Text('Comments :', style: TextStyle(
                    fontFamily: 'HP Simplified Light', fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontSize:24,
                  ),),
              ),
            ),
          
          Expanded(
            
            child:CommentsStreamBuilder(classId: classId, postId: postId,),
            ),
          Container(
            height: 70,
                  decoration: const BoxDecoration(
                      color: const Color.fromARGB(255, 8, 61, 104),
                      border: Border(
                          top: BorderSide(
                              color: Colors.white, width: 2))),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical:3),
                              
                              child:  TextField(
                                style: const TextStyle(color: Colors.white),
                                controller: CommentsController,
                                onChanged: (value) {
                                  messageText = value;
                                },
                                decoration: InputDecoration(
                               enabledBorder:  UnderlineInputBorder(
                  borderSide:  BorderSide(color: Colors.white)
              ),                            //this code for changing the under line of text field
                            
                                contentPadding: const EdgeInsets.symmetric(
                                  vertical: 10,
                                  horizontal: 20,
                                ),
                               
                                hintText: 'Add comment ...',
                                hintStyle: const TextStyle(fontSize: 20, color:  Colors.white, fontFamily: 'HP Simplified Light', fontWeight: FontWeight.bold ),
                                                    ),
                                                  ),
                          )),
                          const SizedBox(width: 8,),
                      
                      TextButton(
                          onPressed: () {
                            if (messageText != null) {
                            CommentsController.clear();
                            sendComments(classId, postId, FirebaseAuth.instance.currentUser!.uid, messageText!);   
                            }
                           
                          },
                          child: const Text(
                            'send',
                            style: TextStyle(
                              color:  Colors.white,
                              fontWeight: FontWeight.bold,
                               fontFamily: 'HP Simplified Light',
                              fontSize: 18,
                            ),
                          ))
                    ],
                  ),
                ),
          
        ],
      ),
    
  );
});
}
void sendComments(String classId, String postId, String sender, String commentText)async{
  await FirebaseFirestore.instance.collection('courses').doc(classId).collection('posts').doc(postId).collection('comments').add({
    'text': commentText,
    'time': FieldValue.serverTimestamp(),
    'senderId': sender,
  }).then((value) async{
    await FirebaseFirestore.instance.collection('courses').doc(classId).collection('posts').doc(postId).collection('comments').doc(value.id).update({
    'commentId': value.id,
  });
  });
}


class CommentsStreamBuilder extends StatelessWidget {
   CommentsStreamBuilder({this.classId, this.postId, super.key});
  String? classId;
  String? postId;
  @override
  Widget build(BuildContext context) {
    return  StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('courses').doc(classId)
            .collection('posts').doc(postId)
            .collection('comments')
            .orderBy('time')
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<CommentsLine> CommentsWidgets = [];
            final comments = snapshot.data!.docs.reversed;
            for (var comment in comments) {
              final senderId = comment.get('senderId');
              final commentId = comment.get('commentId');
              final text = comment.get('text');
              final time = comment.get('time');
              
final DateTime convtime= DateTime.parse(time.toDate().toString());
String outputTime = DateFormat.jm().format(convtime);

              final commentWidget = CommentsLine(
                  senderId: senderId,
                  commentId: commentId,
                  text: text,
                  time: outputTime,
                    );
              CommentsWidgets.add(commentWidget);
            }
            return Expanded(
              child: ListView(
                children: CommentsWidgets,
              ),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        });
  }
}

class CommentsLine extends StatelessWidget {
  const CommentsLine({this.senderId, this.commentId, super.key, this.text, this.time});
  final String? senderId;
  final String? commentId;
  final String? text;
  final time;
  @override
  Widget build(BuildContext context) {
    return    Padding(
      padding: const EdgeInsets.only(left: 5, right: 30),
      child: InkWell(
        child: Padding(
            padding: const EdgeInsets.only(
              left: 5,
              right: 30 ,
              top: 3,
              bottom: 3,
              
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
              StreamBuilder<DocumentSnapshot>(
                          stream:FirebaseFirestore.instance.collection("users").doc(senderId).snapshots(),
                           builder: (context, snapshot) {
                            if (snapshot.data != null) {
                            return  Row(
                           mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                             CircleAvatar(
                              radius: 25,
                             backgroundImage: NetworkImage(snapshot.data?['imgUrl']),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                             Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(top:8.0, left: 12, bottom: 3),
                                      child: Text( snapshot.data?['Name'] ,
                                         style: const TextStyle(fontSize: 15, color: Colors.white, fontFamily: 'HP Simplified Light', fontWeight: FontWeight.bold)),
                                    ),
                                   Material(
                                    color: Colors.white,
                              shape:const RoundedRectangleBorder( borderRadius: BorderRadius.only(
                                topRight: Radius.circular(30),
                                bottomLeft:  Radius.circular(30),
                                bottomRight:  Radius.circular(30),
                                topLeft:  Radius.circular(30),
                                     ),) ,
                                     child: Padding(
                                       padding: const EdgeInsets.symmetric(horizontal:16, vertical:6),
                                       child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                         children: [
                                           Text(
                                             '$text',
                                             style: const TextStyle(
                                              fontFamily: 'HP Simplified Light', fontWeight: FontWeight.bold,
                                              fontSize: 16, color: Colors.black),
                                             maxLines: 10,
                                             overflow: TextOverflow.fade,
                                      ),
                                        const SizedBox(height: 2,),
                                         Text((time).toString(),
                                       maxLines: 10,
                                          style: TextStyle(
                                               fontSize: 10,
                                               color: Colors.black45),)
                                         ],
                                       ),
                                      
                                     ),
                                   ),
                                  ],
                                ),
                             
                            ],
                            );
                          } else{
                           return  Container();
                           }
                        } 
                        )
            ]),
          ),
        
          onTap: () {

          
        },
      ),
    );
  }
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
