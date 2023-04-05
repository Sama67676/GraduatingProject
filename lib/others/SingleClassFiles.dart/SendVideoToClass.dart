import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';


 FirebaseFirestore firestore= FirebaseFirestore.instance;
 PlatformFile? PickedVideo;
 String uid =FirebaseAuth.instance.currentUser!.uid;



class SendVideoToClass {
void pickVideo(classId) async {
   final result= await FilePicker.platform.pickFiles(
  type: FileType.custom, allowedExtensions: ['mp4'],
  );
  if (result != null){
    PickedVideo = result.files.first;
     
    uploadVideo(classId);
  }
  }
  Future<void> uploadVideo(classId) async {
    File? VideoFile = File(PickedVideo!.path!);
    List<Map<String, dynamic>> memberList= await getAllStudents();
    late String postId;
   await FirebaseFirestore.instance.collection('courses').doc(classId).collection('posts').add({
                            'postDate' :FieldValue.serverTimestamp(),
                            'type': 'studentsPost',
                            'title': '',
                            'dueDate': '',
                            'description': '',
                            'attachment': '',
                            'StudentId': uid,
                            'attachmentType': 'Video',
                            'points': '',
                            'toStudents': memberList,

                        }).then((value) {
                         postId = value.id;
                        });
      
      Reference ref = FirebaseStorage.instance.ref('files/${VideoFile.path}');
      var uploadTask = ref.putFile(VideoFile).whenComplete(() async {
      String VideoUrl = await firebase_storage.FirebaseStorage.instance
        .ref('files/${VideoFile.path}')
        .getDownloadURL();
await FirebaseFirestore.instance.collection('courses').doc(classId).collection('posts').doc(postId).update({'attachment': VideoUrl,
 'postId': postId,});
      }
      );
  }
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
