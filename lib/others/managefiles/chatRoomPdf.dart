import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';

 FirebaseFirestore firestore= FirebaseFirestore.instance;
 PlatformFile? pickedpdf;
class SendPdfs {
  
void pickpdfs(chatRoomId,currentUser, frienduid) async{
  final result= await FilePicker.platform.pickFiles(
  type: FileType.custom, allowedExtensions: ['pdf','docx'],
  );
  if (result != null){
    pickedpdf =result.files.first;
    // OpenFile.open(file.path!);
    uploadpdfs(chatRoomId,currentUser, frienduid);
  }
}
Future<void> uploadpdfs(chatRoomId,currentUser, frienduid) async {
    File? pdfFile = File(pickedpdf!.path!);
    String? docid;
    await firestore.collection('chatRoom').doc(chatRoomId).collection('messages').add({
                            'text': "",
                            'sender': currentUser,
                            'time': FieldValue.serverTimestamp(),
                            'receiver': frienduid,
                            'isRead':'',
                            'type': 'pdf',
                        }).then((value) {
                          docid= value.id;
                        });
      
      Reference ref = FirebaseStorage.instance.ref('files/${pdfFile.path}');
      var uploadTask = ref.putFile(pdfFile).whenComplete(() async {
      String pdfUrl = await firebase_storage.FirebaseStorage.instance
        .ref('files/${pdfFile.path}')
        .getDownloadURL();
await firestore.collection('chatRoom').doc(chatRoomId).collection('messages').doc(docid).update({'text': pdfUrl,});
      }
      );
  }
}