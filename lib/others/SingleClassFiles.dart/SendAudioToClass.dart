import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';


 FirebaseFirestore firestore= FirebaseFirestore.instance;
PlatformFile? pickedAudio;
 String uid =FirebaseAuth.instance.currentUser!.uid;


class SendAudioToClass{

  void pickAudio(classId)async{
    final result= await FilePicker.platform.pickFiles(
  type: FileType.custom, allowedExtensions: ['mp3', 'm4a'],
  );
  if (result != null){
    pickedAudio =result.files.first;
    // OpenFile.open(file.path!);
    uploadAudio(classId);
  }
}
uploadAudio(classId)async {
     List<Map<String, dynamic>> memberList= await getAllStudents();
    late String postId;
   File? AudioFile = File(pickedAudio!.path!);

    await FirebaseFirestore.instance.collection('courses').doc(classId).collection('posts').add({
                            'postDate' :FieldValue.serverTimestamp(),
                            'type': 'studentsPost',
                            'title': '',
                            'dueDate': '',
                            'description': '',
                            'attachment': '',
                            'StudentId': uid,
                            'attachmentType': 'Audio',
                            'points': '',
                            'toStudents': memberList,

                        }).then((value) {
                         postId = value.id;
                        });
      
      Reference ref = FirebaseStorage.instance.ref('files/${AudioFile.path}');
      var uploadTask = ref.putFile(AudioFile).whenComplete(() async {
      String AudioUrl = await firebase_storage.FirebaseStorage.instance
        .ref('files/${AudioFile.path}')
        .getDownloadURL();
await FirebaseFirestore.instance.collection('courses').doc(classId).collection('posts').doc(postId).update({'attachment': AudioUrl,
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
