
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_sound/public/flutter_sound_recorder.dart';
 FirebaseFirestore firestore= FirebaseFirestore.instance;
   final recorder= FlutterSoundRecorder();
   File? RecordedAudio;
class SendRecords {
  

  
 
 uploadRecord(chatRoomId,currentUser, frienduid)async {
  
    String? docid;
    await firestore.collection('chatRoom').doc(chatRoomId).collection('messages').add({
                            'text': "",
                            'sender': currentUser,
                            'time': FieldValue.serverTimestamp(),
                            'receiver': frienduid,
                            'isRead':'',
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
await firestore.collection('chatRoom').doc(chatRoomId).collection('messages').doc(docid).update({'text': AudioUrl,});
      }
      );
}

}