import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';


 FirebaseFirestore firestore= FirebaseFirestore.instance;
 PlatformFile? pickedpdf;
 String uid =FirebaseAuth.instance.currentUser!.uid;
class SendPdfToClass {
void pickpdfs( classId,) async{
  final result= await FilePicker.platform.pickFiles(
  type: FileType.custom, allowedExtensions: ['pdf','docx'],
  );
  if (result != null){
    pickedpdf =result.files.first;
    // OpenFile.open(file.path!);
    uploadpdfs(classId);
  }
}
Future<void> uploadpdfs(classId) async {
    List<Map<String, dynamic>> memberList= await getAllStudents();
    late String postId;
    File? pdfFile = File(pickedpdf!.path!);
   
    await FirebaseFirestore.instance.collection('courses').doc(classId).collection('posts').add({
                            'postDate' :FieldValue.serverTimestamp(),
                            'type': 'studentsPost',
                            'title': '',
                            'dueDate': '',
                            'description': '',
                            'attachment': '',
                            'StudentId': uid,
                            'attachmentType': 'pdf',
                            'points': '',
                            'toStudents': memberList,

                        }).then((value) {
                         postId = value.id;
                        });
      
      Reference ref = FirebaseStorage.instance.ref('files/${pdfFile.path}');
      var uploadTask = ref.putFile(pdfFile).whenComplete(() async {
      String pdfUrl = await firebase_storage.FirebaseStorage.instance
        .ref('files/${pdfFile.path}')
        .getDownloadURL();
await FirebaseFirestore.instance.collection('courses').doc(classId).collection('posts').doc(postId).update({'attachment': pdfUrl,
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
