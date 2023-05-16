import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:graduating_project_transformed/hiddenScreens/NewPost.dart';
import 'package:image_picker/image_picker.dart';
String? description;
String? attachmentType ='';
String? points;
String? comment;
bool isDone= false;
bool isLoading= false;

TextEditingController _description = TextEditingController();
class ToSubmitToPost extends StatefulWidget {
   ToSubmitToPost({ this.courseId, this.postId, this.userName, });
 final String? courseId;
 final String? postId;
 final String? userName;

  @override
  State<ToSubmitToPost> createState() => _ToSubmitToPostState( this.courseId, this.postId,  );
}

class _ToSubmitToPostState extends State<ToSubmitToPost> {
final String? courseId;
 final String? postId;





_ToSubmitToPostState( this.courseId, this.postId,  );

 

@override
  void initState() {

    super.initState();
  }
  void makingSubmits(String courseId,String postId)async{
     Reference ref = FirebaseStorage.instance.ref('files/${pickedFile!.path}');
      var uploadTask = ref.putFile(pickedFile!).whenComplete(() async {
      fileUrl = await firebase_storage.FirebaseStorage.instance
        .ref('files/${pickedFile!.path}')
        .getDownloadURL();
        print(fileUrl);
         await FirebaseFirestore.instance.collection('courses')
            .doc(courseId).collection('posts')
            .doc(postId).collection('submits').add({
              'attachement': fileUrl,
              'attachmentType': attachmentType,
              'description': _description.text,
              'isMarked':'false',
              'points': '',
              'studentId': FirebaseAuth.instance.currentUser!.uid,
              'time': FieldValue.serverTimestamp(),
            }).then((value) {
               FirebaseFirestore.instance.collection('courses')
            .doc(courseId).collection('posts')
            .doc(postId).collection('submits').doc(value.id).update({
              'submitId': value.id
            });
             setState(() {
              isLoading = false;
            isDone= true;
          });
               });

  }
      );

 
          
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
                         child:  Text("send submit:",
                           style: TextStyle(fontSize: 34,
                            fontFamily: 'HP Simplified Light', fontWeight: FontWeight.bold,color:const Color.fromARGB(255, 8, 61, 104)),),
                         
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
                                           Padding(
                                      padding: const EdgeInsets.all(18.0),
                                      child: Text('description: ', style: TextStyle(color: Colors.white,
                                       fontFamily: 'HP Simplified Light', fontWeight: FontWeight.bold,
                                       fontSize: 20,
                                      ),),
                                     ),
                                     Padding(
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
                                        controller: _description,
                                         decoration: InputDecoration(
                                            border: InputBorder.none,
                                            hintText:
                                                'Write your description',
                                            hintStyle: TextStyle(
                                                color: Colors.black38)),
                                        
                                                   ),
                                                 )
                                                 ),
                                           ),
                                         ),
                                           ),
                                           Padding(
                                      padding: const EdgeInsets.all(18.0),
                                      child: Text('choose attachement: ', style: TextStyle(color: Colors.white,
                                       fontFamily: 'HP Simplified Light', fontWeight: FontWeight.bold,
                                       fontSize: 20,
                                      ),),
                                     ),
                                      Padding(
                                         padding: EdgeInsets.only(
                                            left: 28.0, right: 10, bottom: 18 ),
                                        child: Container(
                                          height: 65,
                                          width: 65,
                                           child: InkWell(
                                             child: Material(
                                               color: Colors.white,
                                               elevation: 4,
                                              shape: RoundedRectangleBorder(
                                                 borderRadius: BorderRadius.all(
                                                   Radius.circular(20),
                                                 ),
                                                ),
                                               child: Padding(
                                                   padding: EdgeInsets.symmetric(
                                                      horizontal: 10,
                                                      vertical: 12,
                                                    ),
                                                    child: Padding(
                                                      padding: const EdgeInsets.all(6),
                                                      child: Icon(Icons.add,
                                                      color: const Color.fromARGB(255, 8, 61, 104),
                                                      size: 30,
                                                   )
                                                   ),
                                             ),
                                            ),
                                            onTap: (){
                                                setAttachment(context);
                                            },
                                           ),
                                           ),
                                      ),
                                         ],
                                     ),
                                      ),

                               Positioned(
                             
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
                                      setState(() {
                                        isLoading= true;
                                      });
                                      
                                          makingSubmits(courseId!, postId!);
                                     },
                                ),
                              ),
                              isLoading ? Center(
             child: SizedBox(
                  height: 60,
                  width: 60,
                          child:  CircularProgressIndicator(
                          color: Colors.black38,
                           strokeWidth: 4,
                          ),
                        ),
         
             
           ) : isDone? 
           Center(
             child: Container(
              height: 80,
              width: 80,
                      child:  showDone()
                    ),
           ):
           
           Container(height: 1, width: 1,)
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


Future<void> setAttachment(context,) async{

       return showDialog<void>(
    context: context,
    barrierDismissible: false, 
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('choose Attachement', 
        style: TextStyle(color: const Color.fromARGB(255, 8, 61, 104),
        fontFamily: 'HP Simplified Light', fontWeight: FontWeight.bold,
        ),),
        contentPadding: const EdgeInsets.all(30),
        actionsPadding: const EdgeInsets.only(left:20, right: 20, bottom: 20),
       shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(35))),
        content:  Column(
          mainAxisSize: MainAxisSize.min,
      children: [
       Row(children: [
            Padding(
              padding: const EdgeInsets.only(left:5, right: 5, top: 5,bottom: 5),
              child: Column(
                children: [
                  ElevatedButton(
                    onPressed: (){
                       Navigator.of(context).pop();
                 attachmentType= 'image';
                 pickImagefromGalery();
                    },
                     style: ElevatedButton.styleFrom(
                shape: const CircleBorder(),
                padding: const EdgeInsets.all(15),
              ),child: const Icon(Icons.image, size: 30,),
                  ),
                  const SizedBox(height: 4,),
                  const Text('Image', style: TextStyle(fontSize: 15, color: const Color.fromARGB(255, 8, 61, 104),
        fontFamily: 'HP Simplified Light', fontWeight: FontWeight.bold),)
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left:5, right: 5, top: 5,bottom: 5),
              child: Column(
                children: [
                  ElevatedButton(
                    onPressed: (){
                    attachmentType='pdf';
                    pickpdfs();
                    },
                     style: ElevatedButton.styleFrom(
                shape: const CircleBorder(),
                padding: const EdgeInsets.all(15),
              ),child: const Icon(Icons.file_copy, size: 30,),
                  ),
                  const SizedBox(height: 4,),
                  const Text('file', style: TextStyle(fontSize: 15, color: const Color.fromARGB(255, 8, 61, 104),
        fontFamily: 'HP Simplified Light', fontWeight: FontWeight.bold),)
                ],
              ),
            ),
            Padding(
              padding:const EdgeInsets.only(left:5, right: 5, top: 5,bottom: 5),
              child: Column(
                children: [
                  ElevatedButton(
                    onPressed: (){
                      attachmentType= 'image';
                 pickImagefromCamera();
                    },
                     style: ElevatedButton.styleFrom(
                shape: const CircleBorder(),
                padding: const EdgeInsets.all(15),
              ),child: const Icon(Icons.camera_alt, size: 30,),
                  ),
                  const SizedBox(height: 4,),
                  const Text('Camera', style: TextStyle(fontSize: 15, color: const Color.fromARGB(255, 8, 61, 104),
        fontFamily: 'HP Simplified Light', fontWeight: FontWeight.bold),)
                ],
              ),
            )
      ]), 
        
        Row(children: [
            Padding(
                padding: const EdgeInsets.only(left:5, right: 5, bottom: 5,top: 5),
                child: Column(
                  children: [
                    ElevatedButton(
                      onPressed: (){
                        attachmentType= 'Audio';
                        pickAudio();
                      },
                       style: ElevatedButton.styleFrom(
                  shape: const CircleBorder(),
                  padding: const EdgeInsets.all(15),
                ),child: const Icon(Icons.headphones, size: 30,),
                    ),
                    const SizedBox(height: 4,),
                    const Text('audio', style: TextStyle(fontSize: 15, color: const Color.fromARGB(255, 8, 61, 104),
        fontFamily: 'HP Simplified Light', fontWeight: FontWeight.bold),)
                  ],
                ),
              ),
              Padding(
              padding: const EdgeInsets.only(left:5, right: 5, bottom: 5,top: 5),
              child: Column(
                children: [
                  ElevatedButton(
                    onPressed: (){
                      attachmentType='Video';
                      pickVideo();
                    },
                     style: ElevatedButton.styleFrom(
                shape: const CircleBorder(),
                padding: const EdgeInsets.all(15),
              ),child: const Icon(Icons.video_call, size: 30,),
                  ),
                  const SizedBox(height: 4,),
                  const Text('Video', style: TextStyle(fontSize: 15, color: const Color.fromARGB(255, 8, 61, 104),
        fontFamily: 'HP Simplified Light', fontWeight: FontWeight.bold),)
                ],
              ),
            )
          ],),
        
      ],
    ),
        
        actions: <Widget>[
          TextButton(
            child: const Text('Cancel',   style: TextStyle(color: const Color.fromARGB(255, 8, 61, 104),
        fontFamily: 'HP Simplified Light', fontWeight: FontWeight.bold,)),
            onPressed: () {
             
              Navigator.of(context).pop();
            },
          ),
          TextButton(
            child: const Text('Approve',   style: TextStyle(color: const Color.fromARGB(255, 8, 61, 104),
        fontFamily: 'HP Simplified Light', fontWeight: FontWeight.bold,)),
            onPressed: () async {

             
            },
          ),
        ],
      );
    },
  );
  }
String? fileUrl= '';
XFile? photo;
File? pickedFile; 

void pickImagefromGalery() async {
    photo = await ImagePicker()
        .pickImage(source: ImageSource.gallery, imageQuality: 25,);
        pickedFile = File(photo!.path);
  }

void pickImagefromCamera() async {
    photo = await ImagePicker()
        .pickImage(source: ImageSource.camera, imageQuality: 25,);
        pickedFile = File(photo!.path);
  }

void pickpdfs() async{
  final result= await FilePicker.platform.pickFiles(
  type: FileType.custom, allowedExtensions: ['pdf','docx'],
  );
  if (result != null){
    PlatformFile pickedfile =result.files.first;
    pickedFile= File(pickedfile.path!);
  }
}

void pickAudio()async{
    final result= await FilePicker.platform.pickFiles(
  type: FileType.custom, allowedExtensions: ['mp3', 'm4a'],
  );
  if (result != null){
    PlatformFile pickedAudio =result.files.first;
     pickedFile= File(pickedAudio.path!);

  }
}
void pickVideo() async {
   final result= await FilePicker.platform.pickFiles(
  type: FileType.custom, allowedExtensions: ['mp4'],
  );
  if (result != null){
  PlatformFile PickedVideo = result.files.first;
   pickedFile= File(PickedVideo.path!);
  }
  }

// Future<void> uploadFile() async {
//   try {
//      Reference ref = FirebaseStorage.instance.ref('files/${pickedFile!.path}');
//       var uploadTask = ref.putFile(pickedFile!).whenComplete(() async {
//       fileUrl = await firebase_storage.FirebaseStorage.instance
//         .ref('files/${pickedFile!.path}')
//         .getDownloadURL();
//         print(fileUrl);
//   }
//       );
//   } catch (e) {
//     print(e);
//   }
// }
