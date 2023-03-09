
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:open_file/open_file.dart';
 FirebaseFirestore firestore= FirebaseFirestore.instance;
 PlatformFile? PickedVideo;
class SendVideo {
  
 void pickVideo(context, chatRoomId,currentUser, frienduid) async {
   final result= await FilePicker.platform.pickFiles(
  type: FileType.custom, allowedExtensions: ['mp4'],
  );
  if (result != null){
    PickedVideo = result.files.first;
        OpenFile.open(PickedVideo!.path);
    uploadVideo(chatRoomId,currentUser, frienduid);
  }
  }
  Future<void> uploadVideo(chatRoomId,currentUser, frienduid) async {
    File? VideoFile = File(PickedVideo!.path!);
    String? docid;
    await firestore.collection('chatRoom').doc(chatRoomId).collection('messages').add({
                            'text': "",
                            'sender': currentUser,
                            'time': FieldValue.serverTimestamp(),
                            'receiver': frienduid,
                            'type': 'video',
                        }).then((value) {
                          docid= value.id;
                        });
      
      Reference ref = FirebaseStorage.instance.ref('files/${VideoFile.path}');
      var uploadTask = ref.putFile(VideoFile).whenComplete(() async {
      String VideoUrl = await firebase_storage.FirebaseStorage.instance
        .ref('files/${VideoFile.path}')
        .getDownloadURL();
await firestore.collection('chatRoom').doc(chatRoomId).collection('messages').doc(docid).update({'text': VideoUrl,});
      }
      );
  }
}