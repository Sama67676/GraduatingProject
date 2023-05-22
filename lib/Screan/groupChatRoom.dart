import 'dart:io';
import 'package:dio/dio.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_file_dialog/flutter_file_dialog.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import '../Others/auth.dart';
import '../Others/auth_notifier.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:permission_handler/permission_handler.dart';

import '../hiddenScreens/groupProfile.dart';

final firestore = FirebaseFirestore.instance;
final _auth = FirebaseAuth.instance;
late String currentUserName;
late String? curentUserImage;
 int? numberOfMembers;
Authintication _authintication = Authintication();
bool recordingIcon= false;




class GroupChatscrean extends StatefulWidget {
  static const String ScreanRoute = 'GroupChatscrean';
  const GroupChatscrean({
    super.key,
    required this.groupName,
    required this.groupPic,
    required this.authNotifier,
    required this.currentUser,
    required this.groupId,
   
  });
  final String groupName;
  final String groupPic;
  final AuthNotifier authNotifier;
  final String currentUser;
 final String groupId;

  @override
  // ignore: no_logic_in_create_state
  State<GroupChatscrean> createState() => _GroupChatscreanState(
      groupName, groupPic, authNotifier, currentUser, groupId, );
}

class _GroupChatscreanState extends State<GroupChatscrean> {
  final messageTextController = TextEditingController();
  String? messageText;
  bool isRecording = false;
  bool isRequrderReady= false;
  final String groupName;
  final String groupPic;
  final AuthNotifier authNotifier;
  final String currentUser;
  final String groupId;
  



  _GroupChatscreanState(this.groupName, this.groupPic,
      this.authNotifier, this.currentUser, this.groupId,);


  @override
  
  void initState() {
    super.initState();
    getUserName();
    initRecorder();
    getGroupDetails();
    _authintication.initializeCurrentUser(authNotifier);
  

  }

  
  Future getGroupDetails() async {
    await firestore
        .collection('groups')
        .doc(groupId)
        .get()
        .then((chatMap) {
      membersList = chatMap['members'];
      numberOfMembers =membersList.length;
      setState(() {
        
      });
    });
  }
Future downloaderinit()async{
final status = await Permission.storage.request();
if(status != PermissionStatus.granted){
  throw 'Microphone permission not granted!';
}await recorder.openRecorder();
isRequrderReady= true;
recorder.setSubscriptionDuration(const Duration(milliseconds: 100));
}

   Future stop()async{
final rec =await recorder.stopRecorder();
RecordedAudio=File(rec!);
print(rec);
uploadRecord(groupId,currentUser);
  }
   Future record() async{
    if (! isRequrderReady) return;
      await recorder.startRecorder(toFile: 'audio');
  }


  void dispose(){
    recorder.stopRecorder();
    super.dispose();

  }

Future initRecorder()async{
final status = await Permission.microphone.request();
if(status != PermissionStatus.granted){
  throw 'Microphone permission not granted!';
}
await recorder.openRecorder();
isRequrderReady= true;
recorder.setSubscriptionDuration(const Duration(milliseconds: 100));
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      extendBodyBehindAppBar: true,
      appBar: AppBar(
      
        backgroundColor:Color(0xFFCCCED3),
       centerTitle: true,
           title: Center(child: Column(
             children: [
               Text(groupName, style: TextStyle(color: Colors.black),),
               Text('${numberOfMembers.toString()} Members', style: TextStyle(color: Colors.black,  fontSize:14),),
             ],
           )),
                  
               
           
        
   
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_ios,
              color: Color.fromARGB(255, 8, 61, 104)),
         
        ),
        actions: [
          IconButton(
            icon: Container(
              height: 40,
              width: 40,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
              ),
              child: CircleAvatar(
                backgroundImage: NetworkImage(groupPic),
                radius: 50.0,
              ),
            ),
            onPressed: () {
               Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (contex) => GroupProfile(groupImage: groupPic, groupName: groupName, groupId: groupId)));
            },
          )
        ],
      ),
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
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              messageStreamBuilder(
                groupId: groupId,
           currentUser: currentUser,
              ),
              Container(
                decoration: const BoxDecoration(
                    color: Color(0xFFCCCED3),
                    // border: Border(
                    //     top: BorderSide(
                    //         color: Color.fromARGB(255, 8, 61, 104), width: 2)
                    //         )
                            ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(width: 5),
                    Container(
                        child: IconButton(
                                onPressed: () {
                                  chooseAttachmentType(context,groupId,currentUser);
                                },
                                icon: const Icon(
                                  Icons.attachment,
                                  color: Color.fromARGB(255, 8, 61, 104),
                                ),
                              ),
                      ),
                    Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical:3),
                          child: TextField(
                                              style: const TextStyle(color: Colors.white),
                                              controller: messageTextController,
                                              onChanged: (value) {
                          messageText = value;
                                              },
                                              decoration: InputDecoration(
                          filled: true,
                          fillColor: const Color.fromARGB(255, 8, 61, 104),
                          contentPadding: const EdgeInsets.symmetric(
                            vertical: 10,
                            horizontal: 20,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(80),
                            borderSide: const BorderSide(
                              color: Color.fromARGB(255, 8, 61, 104),
                            ),
                          ),
                          hintText: 'Message ...',
                          hintStyle: const TextStyle(color: Colors.white),
                                              ),
                                            ),
                        )),
                        const SizedBox(width: 8,),
                    IconButton(
                      onPressed: ()async {
                        if(recorder.isRecording){
                          setState(() {
                            recordingIcon= true;
                          });
                          await stop();
                        } else{
                          setState(() {
                            recordingIcon= false;
                          });
                          await record();
                        }
                      },
                       icon: Icon(
                          recorder.isRecording? Icons.stop:
                          Icons.mic, color: Color.fromARGB(255, 8, 61, 104),),
                          
                     
                    ),
                    TextButton(
                        onPressed: () {
                          messageTextController.clear();
                          if (messageText == '') {
                            return;
                          }
                          firestore
                              .collection('groups')
                              .doc(groupId)
                              .collection('messages')
                              .add({
                            'text': messageText,
                            'sender': currentUser,
                            'time': FieldValue.serverTimestamp(),
                            'senderName': currentUserName,
                            'type': 'text',
                            'imgUrl': curentUserImage,
                          });
                        },
                        child: const Text(
                          'send',
                          style: TextStyle(
                            color: Color.fromARGB(255, 8, 61, 104),
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ))
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

// ignore: camel_case_types
class messageStreamBuilder extends StatelessWidget {
  
  const messageStreamBuilder(
      {super.key, required this.groupId, required this.currentUser});
  final String groupId;
   final String currentUser;
  
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: firestore
          .collection('groups')
          .doc(groupId)
          .collection('messages')
          .orderBy('time')
          .snapshots(),
      //من وين حيجي الستريم
      builder: (context, snapshot) {
        List<MessageLine> messageWidgets = [];
        if (!snapshot.hasData) {}

        final messages = snapshot.data!.docs.reversed;
        for (var message in messages) {
          final messageText = message.get('text');
          final messagesender = message.get('sender');
          final messageSenderName = message.get('senderName');
          final time = message.get('time');
          final type = message.get('type');
          final memberImage = message.get('imgUrl');
          final currentuser = currentUser;
if (time!=null){
final DateTime convtime= DateTime.parse(time.toDate().toString());
String outputTime = DateFormat.jm().format(convtime);


          final messageWidget = MessageLine(
            sender: messagesender,
            text: messageText,
            time: outputTime,
            messageSenderName: messageSenderName,
            memberImage: memberImage,
            isMe: currentuser == messagesender,
            type: type,
          );

          messageWidgets.add(messageWidget);
        }
        }
        return Expanded(
          child: ListView(
            reverse: true,
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
            children: messageWidgets,
          ),
        );
      },
    );
  }
}

class MessageLine extends StatelessWidget {
  const MessageLine({this.text,this.memberImage, this.sender,this.messageSenderName, required this.isMe, required this.time,required this.type, super.key});
  final String? sender;
  final String? text;
  final String? messageSenderName;
  final String? memberImage;
  final String time;
  final bool isMe;
  final String type;

  @override
  Widget build(BuildContext context) {
    return type== 'text'? Padding(
      padding: isMe? const EdgeInsets.only(left: 75,bottom: 5,top: 5, right: 5) : const EdgeInsets.only(left: 0,bottom: 5,top: 5, right: 75),
      child: Column(
        crossAxisAlignment:
            isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          
          Padding(
            padding: isMe? const EdgeInsets.only(left:55, top: 2, bottom: 2, right: 5): const EdgeInsets.only(left:55, top: 2, bottom: 2, right: 2),
            child:!isMe? Text(messageSenderName!, style: TextStyle(color: Colors.black))
            :Container(height: 1, width: 1,),
          ),
           Row(
          mainAxisAlignment: isMe? MainAxisAlignment.end: MainAxisAlignment.start ,
            children: [
              !isMe? Padding(
                padding: const EdgeInsets.only(right: 8),
                child: CircleAvatar(
                  radius: 20,
                      
                  // ignore: sort_child_properties_last
                   backgroundImage: memberImage != null 
                  ? NetworkImage(memberImage!)
                              : null,
                          child: memberImage == null
                              ? const Icon(
                                  Icons.camera_alt,
                                  size: 35,
                                  color: Colors.white,
                                )
                              : null),
              ):Container(width: 1, height: 1,),
              Container(
                 constraints: const BoxConstraints(
                  maxWidth: 260,
                ),
                child: Material(
                  color: isMe ? Colors.white : const Color.fromARGB(255, 8, 61, 104),
                  elevation: 5, //shadow
                  borderRadius: const BorderRadius.all(
                    Radius.circular(25),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 15,
                      vertical: 5,
                    ),
                    child: Column(
                      crossAxisAlignment: isMe ?CrossAxisAlignment.end: CrossAxisAlignment.start,
                      children: [
                         Text(
                              '$text',
                              style: TextStyle(
                                  fontSize: 15,
                                  color: isMe ?Colors.black: Colors.white),
                                  maxLines: 10,
                            ),
                        const SizedBox(height: 2,),
                        Text((time).toString(),
                      maxLines: 10,
                         style: TextStyle(
                              fontSize: 10,
                              color: isMe ?Colors.black45: Colors.white54),)
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    ): type== 'image'? Padding(
      padding: isMe? const EdgeInsets.only(left: 75,bottom: 5,top: 5, right: 5) : const EdgeInsets.only(left: 5,bottom: 5,top: 5, right: 75),
      child: InkWell(
        onTap: (){downloadFiles(text!);},
        child: Container(
              decoration: BoxDecoration(border: Border.all(width: 2, color: const Color.fromARGB(255, 8, 61, 104),),
          borderRadius: BorderRadius.circular(40),),
          child: ClipRRect(borderRadius: BorderRadius.circular(35),
            child: CachedNetworkImage(
           width: 150,
           height: 150,
             alignment:   isMe ? Alignment.centerRight : Alignment.centerLeft,
            imageUrl: text!,
            imageBuilder: (context, imageProvider) => Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: imageProvider,
                  fit: BoxFit.cover,
                ),
            ),
            ),
            placeholder: (context, url) => const CircularProgressIndicator(),
            errorWidget: (context, url, error) => const Icon(Icons.error),
              ),
          ),
        ),
      ),
    ):type== 'pdf'? Padding(
      padding: isMe? const EdgeInsets.only(left: 75,bottom: 5,top: 5, right: 5) : const EdgeInsets.only(left: 5,bottom: 5,top: 5, right: 75),
      child:  InkWell(
        onTap: (){

         downloadFiles(text!);
        },
        child: Material(
          
          color:Colors.white,
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(30),
              ),
              side: BorderSide(color: Color.fromRGBO(17, 58, 99, 1), width: 3),
            ),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 13),
            child: 
                Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Column(
                       crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Text(pickedpdf!.name, 
                          textAlign: TextAlign.left,
                          style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 15),overflow: TextOverflow.ellipsis,),
                       const SizedBox(height: 10,),
                       Text((time).toString(),
                    maxLines: 10,
                       style: const TextStyle(
                            fontSize: 10,
                            color:Colors.black45),),
                        ],
                      )),
                const SizedBox(width: 3,),
                  
       const CircleAvatar(
                      radius: 30,
                      backgroundColor: Color.fromRGBO(17, 58, 99, 1),
                      child: Icon(Icons.file_copy,size: 30, color: Colors.white,),
                    ),
      
                  ],),
                  
                            
               
          ),),
      ),
    ):type== 'Audio'?
     Padding(
      padding: isMe? const EdgeInsets.only(left: 75,bottom: 5,top: 5, right: 5) : const EdgeInsets.only(left: 5,bottom: 5,top: 5, right: 75),
      child:  InkWell(
        onTap: (){
          downloadFiles(text!);
        },
        child: Material(
          
          color:Colors.white,
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(30),
              ),
              side: BorderSide(color: Color.fromRGBO(17, 58, 99, 1), width: 2),
            ),
          child: Padding(
            padding: const EdgeInsets.all(13),
            child: 
                Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Column(
                       crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Text(pickedAudio!.name, 
                          textAlign: TextAlign.left,
                          style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 15),overflow: TextOverflow.ellipsis,),
                       const SizedBox(height: 10,),
                       Text((time).toString(),
                    maxLines: 10,
                       style: const TextStyle(
                            fontSize: 10,
                            color:Colors.black45),),
                        ],
                      )),
                const SizedBox(width: 3,),
       const CircleAvatar(
                      radius: 30,
                      backgroundColor: Color.fromRGBO(17, 58, 99, 1),
                     child: Icon(
                                  Icons.play_arrow,
                                  size: 50,
                                  color: Colors.white,
                                ),
                    ),
                  ],), 
          ),),
      ),
    )
    
    
    // :Container(child: IconButton(onPressed: (){},
    //                               icon:const Icon(Icons.play_arrow,
    //                               size: 60,
    //                               color: Color.fromRGBO(17, 58, 99, 1),
    //                             ),));
    : type== 'Video'?Padding(
      padding: isMe? const EdgeInsets.only(left: 75,bottom: 5,top: 5, right: 5) : const EdgeInsets.only(left: 5,bottom: 5,top: 5, right: 75),
      child: InkWell(
        onTap: (){downloadFiles(text!);},
        child: Container(
              decoration: BoxDecoration(border: Border.all(width: 5, color: const Color.fromARGB(255, 8, 61, 104),),
          borderRadius: BorderRadius.circular(40),),
          child: ClipRRect(borderRadius: BorderRadius.circular(35),
            child: CachedNetworkImage(
           width: 150,
           height: 150,
             alignment:   isMe ? Alignment.centerRight : Alignment.centerLeft,
            imageUrl: text!,
            imageBuilder: (context, imageProvider) => Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: imageProvider,
                  fit: BoxFit.cover,
                ),
            ),
            ),
            placeholder: (context, url) => const CircularProgressIndicator(),
            errorWidget: (context, url, error) => const Icon(Icons.play_arrow),
              ),
          ),
        ),
      ),
    ):type== 'Recorde'?Padding(
      padding: isMe? const EdgeInsets.only(left: 75,bottom: 5,top: 5, right: 5) : const EdgeInsets.only(left: 5,bottom: 5,top: 5, right: 75),
      child:  InkWell(
        onTap: (){
       
        },
        child: Material(
          elevation: 4,
          color:Colors.white,
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(30),
              ),
              // side: BorderSide(color: Color.fromRGBO(17, 58, 99, 1), width: 1),
            ),
          child: Padding(
            padding: const EdgeInsets.all(13),
            child: 
                Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Column(
                       crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          
                       Text((time).toString(),
                    maxLines: 10,
                       style: const TextStyle(
                            fontSize: 10,
                            color:Colors.black45),),
                        ],
                      )),
                const SizedBox(width: 3,),
       const CircleAvatar(
                      radius: 30,
                      backgroundColor: Color.fromRGBO(17, 58, 99, 1),
                     child: Icon(
                                  Icons.play_arrow,
                                  size: 50,
                                  color: Colors.white,
                                ),
                    ),
                  ],), 
          ),),
      ),
    ): Container();
  }
}


void chooseAttachmentType(context, groupId,currentUser, ){
showModalBottomSheet(context: context, builder: (BuildContext bc){
  return Container(
    height: MediaQuery.of(context).size.height * .30,
    child: Column(
      children: [
        Expanded(
          child: Row(children: [
            Padding(
              padding: const EdgeInsets.only(left:35, right: 35, top: 35,bottom: 5),
              child: Column(
                children: [
                  ElevatedButton(
                    onPressed: (){
                      pickImagefromGalery(context, groupId, currentUser);
                    },
                     style: ElevatedButton.styleFrom(
                shape: const CircleBorder(),
                padding: const EdgeInsets.all(15),
              ),child: const Icon(Icons.image, size: 30,),
                  ),
                  const SizedBox(height: 4,),
                  const Text('Image', style: TextStyle(fontSize: 15),)
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left:35, right: 35, top: 35,bottom: 5),
              child: Column(
                children: [
                  ElevatedButton(
                    onPressed: (){
                      pickpdfs(groupId,currentUser);
                    },
                     style: ElevatedButton.styleFrom(
                shape: const CircleBorder(),
                padding: const EdgeInsets.all(15),
              ),child: const Icon(Icons.file_copy, size: 30,),
                  ),
                  const SizedBox(height: 4,),
                  const Text('file', style: TextStyle(fontSize: 15),)
                ],
              ),
            ),
            Padding(
              padding:const EdgeInsets.only(left:35, right: 35, top: 35,bottom: 5),
              child: Column(
                children: [
                  ElevatedButton(
                    onPressed: (){
                      pickImagefromcamera(context, groupId, currentUser);
                    },
                     style: ElevatedButton.styleFrom(
                shape: const CircleBorder(),
                padding: const EdgeInsets.all(15),
              ),child: const Icon(Icons.camera_alt, size: 30,),
                  ),
                  const SizedBox(height: 4,),
                  const Text('Camera', style: TextStyle(fontSize: 15),)
                ],
              ),
            )
      ]), 
        ),
        Expanded(
          child: Row(children: [
            Padding(
                padding: const EdgeInsets.only(left:35, right: 35, bottom: 35,top: 5),
                child: Column(
                  children: [
                    ElevatedButton(
                      onPressed: (){
                        pickAudio(context, groupId, currentUser, );
                      },
                       style: ElevatedButton.styleFrom(
                  shape: const CircleBorder(),
                  padding: const EdgeInsets.all(15),
                ),child: const Icon(Icons.headphones, size: 30,),
                    ),
                    const SizedBox(height: 4,),
                    const Text('audio', style: TextStyle(fontSize: 15),)
                  ],
                ),
              ),
              Padding(
              padding: const EdgeInsets.only(left:35, right: 35, bottom: 35,top: 5),
              child: Column(
                children: [
                  ElevatedButton(
                    onPressed: (){
                      pickVideo(context, groupId, currentUser, );
                    },
                     style: ElevatedButton.styleFrom(
                shape: const CircleBorder(),
                padding: const EdgeInsets.all(15),
              ),child: const Icon(Icons.video_call, size: 30,),
                  ),
                  const SizedBox(height: 4,),
                  const Text('Video', style: TextStyle(fontSize: 15),)
                ],
              ),
            )
          ],),
        )
      ],
    ),
  );
});
}
XFile? photo;
PlatformFile? pickedpdf;
PlatformFile? pickedAudio;
File? imagefile;
File? RecordedAudio;
PlatformFile? PickedVideo;
// final duration= snapshot.hasdata? snapshot.data!.duration: duration.zero;


 void pickImagefromGalery(context, groupId,currentUser,) async {
    photo = await ImagePicker()
        .pickImage(source: ImageSource.gallery, imageQuality: 25,);
        File? imagefile = File(photo!.path);
        OpenFile.open(imagefile.path);
    uploadpfp(currentUser,currentUser);
  }

  void pickImagefromcamera(context, currentUser,groupId) async {
    photo = await ImagePicker()
        .pickImage(source: ImageSource.camera, imageQuality: 25);
    uploadpfp(groupId,currentUser);
  }

  Future<void> uploadpfp(groupId,currentUser) async {
    File? imagefile = File(photo!.path);
    String? docid;
    await firestore.collection('groups').doc(groupId).collection('messages').add({
                            'text': "",
                            'sender': currentUser,
                            'time': FieldValue.serverTimestamp(),
                            'imgUrl': curentUserImage,
                            'senderName': currentUserName,
                            'type': 'image',
                        }).then((value) {
                          docid= value.id;
                        });
      
      Reference ref = FirebaseStorage.instance.ref('files/${imagefile.path}');
      var uploadTask = ref.putFile(imagefile).whenComplete(() async {
      String imgUrl = await firebase_storage.FirebaseStorage.instance
        .ref('files/${imagefile.path}')
        .getDownloadURL();
await firestore.collection('groups').doc(groupId).collection('messages').doc(docid).update({'text': imgUrl,});
      }
      );
  }


void pickpdfs(groupId,currentUser) async{
  final result= await FilePicker.platform.pickFiles(
  type: FileType.custom, allowedExtensions: ['pdf','docx'],
  );
  if (result != null){
    pickedpdf =result.files.first;
    // OpenFile.open(file.path!);
    uploadpdfs(groupId,currentUser);
  }
}
Future<void> uploadpdfs(groupId,currentUser) async {
    File? pdfFile = File(pickedpdf!.path!);
    String? docid;
    await firestore.collection('groups').doc(groupId).collection('messages').add({
                            'text': "",
                            'sender': currentUser,
                            'time': FieldValue.serverTimestamp(),
                            'imgUrl': curentUserImage,
                            'senderName': currentUserName,
                            'type': 'pdf',
                        }).then((value) {
                          docid= value.id;
                        });
      
      Reference ref = FirebaseStorage.instance.ref('files/${pdfFile.path}');
      var uploadTask = ref.putFile(pdfFile).whenComplete(() async {
      String pdfUrl = await firebase_storage.FirebaseStorage.instance
        .ref('files/${pdfFile.path}')
        .getDownloadURL();
await firestore.collection('groups').doc(groupId).collection('messages').doc(docid).update({'text': pdfUrl,});
      }
      );
  }


  void pickAudio(context, groupId, currentUser, )async{
    final result= await FilePicker.platform.pickFiles(
  type: FileType.custom, allowedExtensions: ['mp3', 'm4a'],
  );
  if (result != null){
    pickedAudio =result.files.first;
    // OpenFile.open(file.path!);
    uploadAudio(groupId,currentUser, );
  }
}
uploadAudio(grooupId,currentUser, )async {
   File? AudioFile = File(pickedAudio!.path!);
    String? docid;
    await firestore.collection('groups').doc(grooupId).collection('messages').add({
                            'text': "",
                            'sender': currentUser,
                            'time': FieldValue.serverTimestamp(),
                            'imgUrl': curentUserImage,
                            'senderName': currentUserName,
                            'type': 'Audio',
                        }).then((value) {
                          docid= value.id;
                        });
      
      Reference ref = FirebaseStorage.instance.ref('files/${AudioFile.path}');
      var uploadTask = ref.putFile(AudioFile).whenComplete(() async {
      String AudioUrl = await firebase_storage.FirebaseStorage.instance
        .ref('files/${AudioFile.path}')
        .getDownloadURL();
await firestore.collection('groups').doc(grooupId).collection('messages').doc(docid).update({'text': AudioUrl,});
      }
      );
}

 void pickVideo(context, groupId,currentUser,) async {
   final result= await FilePicker.platform.pickFiles(
  type: FileType.custom, allowedExtensions: ['mp4'],
  );
  if (result != null){
    PickedVideo = result.files.first;
        OpenFile.open(PickedVideo!.path);
    uploadVideo(groupId,currentUser,);
  }
  }
  Future<void> uploadVideo(groupId,currentUser, ) async {
    File? VideoFile = File(PickedVideo!.path!);
    String? docid;
    await firestore.collection('groups').doc(groupId).collection('messages').add({
                            'text': "",
                            'sender': currentUser,
                            'time': FieldValue.serverTimestamp(),
                            'imgUrl': curentUserImage,
                            'senderName': currentUserName,
                            'type': 'video',
                        }).then((value) {
                          docid= value.id;
                        });
      
      Reference ref = FirebaseStorage.instance.ref('files/${VideoFile.path}');
      var uploadTask = ref.putFile(VideoFile).whenComplete(() async {
      String VideoUrl = await firebase_storage.FirebaseStorage.instance
        .ref('files/${VideoFile.path}')
        .getDownloadURL();
await firestore.collection('groups').doc(groupId).collection('messages').doc(docid).update({'text': VideoUrl,});
      }
      );
  }

  final recorder= FlutterSoundRecorder();
  
 
 uploadRecord(groupId,currentUser)async {
  
    String? docid;
    await firestore.collection('groups').doc(groupId).collection('messages').add({
                            'text': "",
                            'sender': currentUser,
                            'time': FieldValue.serverTimestamp(),
                            'imgUrl': curentUserImage,
                            'senderName': currentUserName,
                            'type': 'Recorde',
                            
                        }).then((value) {
                          docid= value.id;
                        });
      
      Reference ref = FirebaseStorage.instance.ref('files/${RecordedAudio!.path}');
      var uploadTask = ref.putFile(RecordedAudio!).whenComplete(() async {
      String AudioUrl = await firebase_storage.FirebaseStorage.instance
        .ref('files/${RecordedAudio!.path}')
        .getDownloadURL();
        Reference ref=  await firebase_storage.FirebaseStorage.instance
        .ref('files/${RecordedAudio!.path}');
await firestore.collection('groups').doc(groupId).collection('messages').doc(docid).update({'text': AudioUrl,});
      }
      );
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
     OpenFile.open(directory.path);
 } catch (e) {
   
 }
  
}

Future<void> getUserName() async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get()
        .then((snapshot) async {
      if (snapshot.exists) {
         curentUserImage =  snapshot.data()!['imgUrl'];
          currentUserName = snapshot.data()!['Name'];
      }
    });
  }
