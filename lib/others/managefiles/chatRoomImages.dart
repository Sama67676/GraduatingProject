import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:open_file/open_file.dart';
 FirebaseFirestore firestore= FirebaseFirestore.instance;
XFile? photo;
class SendImage {
   void pickImagefromGalery(context, chatRoomId,currentUser, frienduid) async {
    photo = await ImagePicker()
        .pickImage(source: ImageSource.gallery, imageQuality: 25,);
        File? imagefile = File(photo!.path);
        OpenFile.open(imagefile.path);
    uploadpfp(chatRoomId,currentUser, frienduid);
  }

   void pickImagefromcamera(context, chatRoomId,currentUser, frienduid) async {
    photo = await ImagePicker()
        .pickImage(source: ImageSource.camera, imageQuality: 25);
    uploadpfp(chatRoomId,currentUser, frienduid);
  }

  Future<void> uploadpfp(chatRoomId,currentUser, frienduid) async {
    File? imagefile = File(photo!.path);
    String? docid;
    await firestore.collection('chatRoom').doc(chatRoomId).collection('messages').add({
                            'text': "",
                            'sender': currentUser,
                            'time': FieldValue.serverTimestamp(),
                            'receiver': frienduid,
                            'type': 'image',
                            'isRead':''
                        }).then((value) {
                          docid= value.id;
                        });
      
      Reference ref = FirebaseStorage.instance.ref('files/${imagefile.path}');
      var uploadTask = ref.putFile(imagefile).whenComplete(() async {
      String imgUrl = await firebase_storage.FirebaseStorage.instance
        .ref('files/${imagefile.path}')
        .getDownloadURL();
await firestore.collection('chatRoom').doc(chatRoomId).collection('messages').doc(docid).update({'text': imgUrl,});
      }
      );
  }
}