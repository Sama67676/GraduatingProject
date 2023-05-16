import 'dart:convert';
import 'dart:io';
import 'package:flutter_file_dialog/flutter_file_dialog.dart';
import 'dart:math';
import 'dart:isolate'; //مال فلتر دونلودر حتى ليخرب التطبيق بين ما ينزل ملف
import 'dart:ui'; //مال فلتر دونلودر حتى ليخرب التطبيق بين ما ينزل ملف
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:graduating_project_transformed/hiddenScreens/FriendProfile.dart';
import 'package:graduating_project_transformed/others/managefiles/chatRoomPdf.dart';
import 'package:intl/intl.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import '../Others/auth.dart';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:permission_handler/permission_handler.dart';
import '../others/managefiles/chatRoomAudio.dart';
import '../others/managefiles/chatRoomRecord.dart';
import '../others/managefiles/chooseAttachment.dart';
import 'package:dio/dio.dart';
import 'package:http/http.dart' show get;
import 'package:http/http.dart' as http;
import 'package:flutter/services.dart'; //to copy paste


late String friendToken;
SendRecords sendRecords= SendRecords(); 
final firestore = FirebaseFirestore.instance;

class Cahtscrean extends StatefulWidget {
  static const String ScreanRoute = 'Chat_Screan';
  const Cahtscrean({
    super.key,
    required this.frienduid,
    required this.friendName,
    required this.profilePic,

    required this.currentUser,
    required this.chatRoomId,
  });
  final String frienduid;
  final String friendName;
  final String profilePic;

  final String chatRoomId;
  final String currentUser;

  @override
  // ignore: no_logic_in_create_state
  State<Cahtscrean> createState() => _CahtscreanState(
      frienduid, friendName, profilePic, chatRoomId, currentUser);
}

class _CahtscreanState extends State<Cahtscrean> {
  final messageTextController = TextEditingController();
  String? messageText;
  final String frienduid;
  final String friendName;
  final String profilePic;
  final String chatRoomId;
 
  final String currentUser;

  _CahtscreanState(this.frienduid, this.friendName, this.profilePic, this.chatRoomId, this.currentUser);
bool recordingIcon= false;
bool isRecording = false;
bool isRequrderReady= false;
//  FocusNode _focus = FocusNode();   يمكن ما احتاجة
  @override
  
  void initState() {
    super.initState();
    initRecorder();
    getFriendDeviceToken(frienduid);
 messageTextController.addListener(_printLatestValue);

  }


   Future stop()async{
final path =await recorder.stopRecorder();
RecordedAudio=File(path!);
sendRecords.uploadRecord(chatRoomId,currentUser, frienduid);
  }
   Future record() async{
    if (! isRequrderReady) return;
      await recorder.startRecorder(toFile: 'audio');
  }


  @override
  void dispose(){
    recorder.stopRecorder();
    super.dispose();
   messageTextController.dispose();
   
  }
  
   void _printLatestValue() {
        print('Second text field: ${messageTextController.text}');
        if(messageTextController.text.isNotEmpty){
             firestore.collection('users').doc(currentUser).update(
                              {
                                'typingTo': frienduid
                              }
                             );
        }else{
           firestore.collection('users').doc(currentUser).update(
                              {
                                'typingTo': null
                              }
                             );
        }
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
    
        elevation: 0.6,
        backgroundColor:Color(0xFFCCCED3),
        title:  StreamBuilder<DocumentSnapshot>(
          stream:firestore.collection("users").doc(frienduid).snapshots(),
           builder: (context, snapshot) {
             if (snapshot.data != null) {
          return Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                    Text(friendName,
                        style:
                            const TextStyle(fontSize: 20, color: Colors.black, fontFamily: 'HP Simplified Light', fontWeight: FontWeight.bold)),
                 Text( snapshot.data?['typingTo'] == currentUser?
                 'typing ...': snapshot.data!['onlineStatus'],
                    style: const TextStyle(fontSize: 16, color: Colors.black45, fontFamily: 'HP Simplified Light', fontWeight: FontWeight.bold))
              ],
            ),
          );
             }else{
              return  Container();
             }
           }
        ),
        leadingWidth: 80,
        leading: TextButton.icon(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_ios,
              color: Color.fromARGB(255, 8, 61, 104)),
          label: const Text(
            'Back',
            style: TextStyle(color: Color.fromARGB(255, 8, 61, 104),
             fontFamily: 'HP Simplified Light', fontWeight: FontWeight.bold),
          ),
        ),
        actions: [
          GestureDetector(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: CircleAvatar(
                    backgroundImage: NetworkImage(profilePic),
                    radius: 25.0,
                  ),
            ),
            onTap: ()async{
              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (contex) => FriendProfile(friendId: frienduid,)));
            },
          ),
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
                chatRoomId: chatRoomId,
           currentUser: currentUser,
              ),
              Container(
                decoration: const BoxDecoration(
                    color: Color(0xFFCCCED3),
                    border: Border(
                        top: BorderSide(
                            color: Color(0xFFCCCED3), width: 2))),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(width: 5),
                    Container(
                        child: IconButton(
                                onPressed: () {
                                  ChooseAttachement chooseAttachement = ChooseAttachement();
                                  chooseAttachement.chooseAttachmentType(context,chatRoomId,currentUser, frienduid);
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
                            
                            child:  TextField(
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
                              hintStyle: const TextStyle(color: Colors.white, fontFamily: 'HP Simplified Light', fontWeight: FontWeight.bold ),
                                                  ),
                                                ),
                        )),
                        const SizedBox(width: 8,),
                    IconButton(
                      onPressed: ()async {
                        if(recorder.isRecording){
                          setState(() {
                            recordingIcon= false;
                          });
                          await stop();
                        } else{
                          setState(() {
                            recordingIcon= true;
                          });
                          await record();
                        }
                      },
                       icon: Icon(
                          recordingIcon? Icons.stop:
                          Icons.mic, color: const Color.fromARGB(255, 8, 61, 104),
                          size: 33,
                          ),
                          
                     
                    ),
                    TextButton(
                        onPressed: () {
                          messageTextController.clear();
                          if (messageText == '') {
                            return;
                          }
                          firestore
                              .collection('chatRoom')
                              .doc(chatRoomId)
                              .collection('messages')
                              .add({
                            'text': messageText,
                            'sender': currentUser,
                            'time': FieldValue.serverTimestamp(),
                            'receiver': frienduid,
                            'type': 'text',
                            'isRead':'',
                          }).then((value) => sendPushNotification(friendToken, currentUser, messageText));
                          
                          firestore
                              .collection('chatRoom')
                              .doc(chatRoomId).update({
                                'lastMessage': messageText
                              });
                        },
                        child: const Text(
                          'send',
                          style: TextStyle(
                            color: Color.fromARGB(255, 8, 61, 104),
                            fontWeight: FontWeight.bold,
                             fontFamily: 'HP Simplified Light',
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
      {super.key, required this.chatRoomId, required this.currentUser});
  final String chatRoomId;
   final String currentUser;
  
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: firestore
          .collection('chatRoom')
          .doc(chatRoomId)
          .collection('messages')
          .orderBy('time')
          .snapshots(),
      
      builder: (context, snapshot) {
        List<MessageLine> messageWidgets = [];
        if (!snapshot.hasData) {}

        final messages = snapshot.data!.docs.reversed;
        for (var message in messages) {
          final messageText = message.get('text');
          final messagesender = message.get('sender');
          final time = message.get('time');
          final type = message.get('type');
          final isRead = message.get('isRead');
          final currentuser = currentUser;
if (time!=null){
final DateTime convtime= DateTime.parse(time.toDate().toString());
String outputTime = DateFormat.jm().format(convtime);


          final messageWidget = MessageLine(
            sender: messagesender,
            text: messageText,
            time: outputTime,
            isRead : isRead,
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
  const MessageLine({this.text, this.sender, required this.isMe, required this.time,required this.type, required this.isRead, super.key});
  final String? sender;
  final String? text;
  final String time;
  final bool isMe;
  final String type;
  final String isRead;

  @override
  Widget build(BuildContext context) {
    return type== 'text'? Padding(
      padding: isMe? const EdgeInsets.only(left: 75,bottom: 5,top: 5, right: 5) : const EdgeInsets.only(left: 5,bottom: 5,top: 5, right: 75),
      child: Column(
        crossAxisAlignment:
            isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          InkWell(
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
                          color: isMe ?Colors.black: Colors.white,
                           fontFamily: 'HP Simplified Light', fontWeight: FontWeight.bold),
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
            
            onTap: ()async {await Clipboard.setData(ClipboardData(text: text));},
          ),
        ],
      ),
    ): type== 'image'? Padding(
      padding: isMe? const EdgeInsets.only(left: 75,bottom: 5,top: 5, right: 5) : const EdgeInsets.only(left: 5,bottom: 5,top: 5, right: 75),
      child: InkWell(
        onTap: (){
        // downloadFiles(text!);
         },
         onLongPress: () {
          downloadFileDialog(context, text!);
        },
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

        //  downloadFiles(text!);
        },
        onLongPress: () {
          downloadFileDialog(context, text!);
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
          // downloadFiles(text!);
        },
        onLongPress: () {
          downloadFileDialog(context, text!);
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
        // onTap: (){downloadFiles(text!);},
        onLongPress: () {
          downloadFileDialog(context, text!);
        },
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
      //  onTap: (){downloadFiles(text!);},
      onLongPress: () {downloadFileDialog(context, text!);},
        child: Material(
          color:Colors.white,
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(30),
              ),
              side: BorderSide(color: Color.fromRGBO(17, 58, 99, 1), width: 1),
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


bool setOnlineStatus(String frienduid){ 
  String onlineStatus;
     FirebaseFirestore.instance
        .collection('users')
        .doc(frienduid)
        .get()
        .then((snapshot)  {
      if (snapshot.exists) {
          onlineStatus = snapshot.data()!['onlineStatus'];
           if (onlineStatus == "online"){
    return true;
  }else if(onlineStatus== 'offline'){
    return false;
  }
          }});
 return false;
}




Future<void> updateMessageReadState(messageId, chatRoomId)async {
  firestore.collection('chatRoom').doc(chatRoomId).update({
    'isRead': true
  });
}

void sendPushNotification(token,msgSender, msg)async{
try {
  final body={
    "to":token,
    "notification": {
        "title": msgSender,
        "body": msg
    }
};
var url = Uri.https('example.com', 'whatsit/create');

var response = await http.post(Uri.parse('https://fcm.googleapis.com/fcm/send'),
headers: {HttpHeaders.contentTypeHeader: 'application/json',
HttpHeaders.authorizationHeader: 'key=AAAA9EJgwkc:APA91bE-6mR8NRuNmQe0nXJehRO4uXhqQPz-LaaWbSpuCwhWn7nS3YuRhGDxemhW7tseo9pWD-Lse6Bi3s8MngGIf3EU0_dwkajRvJSfJaNFMy6nUFjLxdTZNlG5cSZgUacppLylCF7W'
} ,
body: jsonEncode(body));

print('Response status: ${response.statusCode}');
print('Response body: ${response.body}');
} catch (e) {
  print('ERROR NOTIFICATIONS: $e');
}
}

void getFriendDeviceToken(frienduid)async{
  await firestore.collection('users').doc('frienduid').get().then((snapshot) {
    if (snapshot.exists) {
       friendToken = snapshot.data()!['deviceToken'];
    }
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
     OpenFile.open(directory.path);
 } catch (e) {
   
 }
  
}

 void downloadFileDialog(context, String text) {
  
        showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                content: ListTile(
                  onTap: () { 
                    downloadFiles(text);
                    Navigator.pop(context);
                  },
                  title: const Text("Download file"),
                ),
              );
            });
      
    
  }