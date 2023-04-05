import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:image_picker/image_picker.dart';
 import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:io';

class SendImageToClass {
String uid =FirebaseAuth.instance.currentUser!.uid;
XFile? photo;
 void pickImagefromCamera( classId,  ) async {
    photo = await ImagePicker()
        .pickImage(source: ImageSource.camera, imageQuality: 25,);
        File? imagefile = File(photo!.path);
        uploadpfp(classId );

  }

  void pickImagefromGalery( classId,  ) async {
    photo = await ImagePicker()
        .pickImage(source: ImageSource.gallery, imageQuality: 25,);
        File? imagefile = File(photo!.path);
        uploadpfp(classId);

  }
   Future<void> uploadpfp(classId ) async {
     List<Map<String, dynamic>> memberList= await getAllStudents();
    late String postId;
    File? imagefile = File(photo!.path);

    await FirebaseFirestore.instance.collection('courses').doc(classId).collection('posts').add({
                            'postDate' :FieldValue.serverTimestamp(),
                            'type': 'studentsPost',
                            'title': '',
                            'dueDate': '',
                            'description': '',
                            'attachment': '',
                            'StudentId': uid,
                            'attachmentType': 'image',
                            'points': '',
                            'toStudents': memberList,

                        }).then((value) {
                         postId = value.id;
                        });
      
      Reference ref = FirebaseStorage.instance.ref('files/${imagefile.path}');
      var uploadTask = ref.putFile(imagefile).whenComplete(() async {
      String imgUrl = await firebase_storage.FirebaseStorage.instance
        .ref('files/${imagefile.path}')
        .getDownloadURL();
await FirebaseFirestore.instance.collection('courses').doc(classId).collection('posts').doc(postId).update({'attachment': imgUrl,
 'postId': postId,});
      }
      );
      
  }

Future getAllStudents() async {
     List<Map<String, dynamic>> memberList =[];
    await FirebaseFirestore.instance
        .collection('users').where('position', isEqualTo: 'Student')
         .get().then((QuerySnapshot querySnapshot){
            for (var element in querySnapshot.docs) {
         memberList.add({'name':element['Name'], 'uid': element['uid']});
            }
         });
         return(memberList);
  }
}