
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
PlatformFile? pickedAudio;
 FirebaseFirestore firestore= FirebaseFirestore.instance;
class SendAudio {
  

  void pickAudio(context, chatRoomId, currentUser, frienduid)async{
    final result= await FilePicker.platform.pickFiles(
  type: FileType.custom, allowedExtensions: ['mp3', 'm4a'],
  );
  if (result != null){
    pickedAudio =result.files.first;
    // OpenFile.open(file.path!);
    uploadAudio(chatRoomId,currentUser, frienduid);
  }
}
uploadAudio(chatRoomId,currentUser, frienduid)async {
   File? AudioFile = File(pickedAudio!.path!);
    String? docid;
    await firestore.collection('chatRoom').doc(chatRoomId).collection('messages').add({
                            'text': "",
                            'sender': currentUser,
                            'time': FieldValue.serverTimestamp(),
                            'receiver': frienduid,
                            'isRead': '',
                            'type': 'Audio',
                        }).then((value) {
                          docid= value.id;
                        });
      
      Reference ref = FirebaseStorage.instance.ref('files/${AudioFile.path}');
      var uploadTask = ref.putFile(AudioFile).whenComplete(() async {
      String AudioUrl = await firebase_storage.FirebaseStorage.instance
        .ref('files/${AudioFile.path}')
        .getDownloadURL();
await firestore.collection('chatRoom').doc(chatRoomId).collection('messages').doc(docid).update({'text': AudioUrl,});
      }
      );
}
}