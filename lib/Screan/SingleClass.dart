import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:graduating_project_transformed/hiddenScreens/NewPost.dart';

import '../hiddenScreens/createClass.dart';

import 'Post.dart';
String uid =FirebaseAuth.instance.currentUser!.uid;
String? imageUrl;
  final TextEditingController _shareWithClass=TextEditingController();
class SingleClassScreen extends StatefulWidget {
   SingleClassScreen({ this.classId, this.className,  this.teacherId, this.classSubject, super.key});
  String? classId;
  String? className;
  String? teacherId;
  String? classSubject;

  @override
  State<SingleClassScreen> createState() => _SingleClassScreenState(classId, className, teacherId, classSubject);
}

class _SingleClassScreenState extends State<SingleClassScreen> {
  String? classId;
  String? className;
  String? teacherId;
  String? classSubject;

  _SingleClassScreenState(this.classId, this.className, this.teacherId, this.classSubject);

  Future<void> fetchData() async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get()
        .then((snapshot) async {
      if (snapshot.exists) {
          imageUrl = snapshot.data()!['imgUrl'];
  
      }
    });
  }

   @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       floatingActionButton: Container(
        width: 75,
                  height: 50,
         child: FloatingActionButton(
          child: const Icon(Icons.add,  color: Color.fromARGB(255, 8, 61, 104)),
             backgroundColor:  const Color(0xFFCCCED3),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
          onPressed: (){
            if (classId != null){
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (contex) =>  NewPostScreen(classId: classId)));
            }
          },
         ),
       ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
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
            child: Padding(
          padding:
              const EdgeInsets.only(left: 25, right: 15, bottom: 5, top: 5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children:  [
             
                Padding(
                  padding: const EdgeInsets.symmetric(vertical:10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        
                      Expanded(
                        flex: 1,
                        child: IconButton(
                                icon: const Icon(Icons.arrow_back_ios,
                                    size: 30,
                                    color: Color.fromARGB(255, 8, 61, 104)),
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                              ),
                      ),
                          const Expanded(
                            flex: 4,
                            child: SizedBox(width: 30,)),
                        Expanded(
                          flex: 1,
                          child: PopupMenuButton(
                            icon: const Icon(Icons.menu,
                            size: 35,
                                color: Color.fromARGB(255, 8, 61, 104)),
                                 itemBuilder: (context) => [ const PopupMenuItem(
                            child: Text('Edit group Details', style: TextStyle(color: Color.fromARGB(255, 8, 61, 104), fontSize: 20),), value: '1'),
                         const PopupMenuItem<String>(
                             child: Text('Leave Group', style: TextStyle(color: Color.fromARGB(255, 8, 61, 104), fontSize: 20),), value: '2'),
                         const PopupMenuItem<String>(
                             child: Text('Delete group', style: TextStyle(color: Color.fromARGB(255, 8, 61, 104), fontSize: 20),), value: '3'),
                       ],
                             elevation: 4,
                         shape: const RoundedRectangleBorder(
                           borderRadius: BorderRadius.all(
                   Radius.circular(35),
                           ),
                               ),
                               onSelected: (result) {
                               },
                          ),
                        ),
                      ],
                    ),
                ),
               
             
           Material(
                  elevation: 10,
                  borderRadius: const BorderRadius.all(Radius.circular(35)),
                  child: Container(
                    decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(35)),
                        boxShadow: [
                          BoxShadow(
                              color: Color.fromARGB(255, 8, 61, 104), //New
                              blurRadius: 0,
                              offset: Offset(-10, 0)),
                        ]),
                    child: Material(
                      color: Colors.white,
                      elevation: 1, //shadows
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(35),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(25),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(className!,
                                style: TextStyle(
                                  fontSize: 25,
                                   fontFamily: 'HP Simplified Light', fontWeight: FontWeight.bold,
                                  color: Colors.indigo[900],
                                )),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              classSubject!,
                              style: TextStyle(
                                 fontFamily: 'HP Simplified Light', fontWeight: FontWeight.bold,
                                fontSize: 15,
                                color: Colors.indigo[900],
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                           StreamBuilder<DocumentSnapshot>(
                            stream:firestore.collection("users").doc(teacherId).snapshots(),
                             builder: (context, snapshot) {
                              if (snapshot.data != null) {
                              return  Row(
                             mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                               CircleAvatar(
                                radius: 20,
                               backgroundImage: NetworkImage(snapshot.data?['imgUrl']),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                              Text( snapshot.data?['Name'] ,
                                 style: const TextStyle(fontSize: 15, color: Colors.black45, fontFamily: 'HP Simplified Light', fontWeight: FontWeight.bold))      
                              ],
                              );
                            } else{
                             return  Container();
                             }
                          } 
                          )
                          ],
                        ),
                      ),
                    ),
                  ),
                             ),
               
              const SizedBox(height: 10,),
              Expanded(
                flex: 6,
                child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25),
                        ),
                        elevation: 0,
                        color: const Color.fromARGB(255, 8, 61, 104),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              Padding(
                              padding: const EdgeInsets.symmetric(horizontal:8.0, vertical: 15),
                              child: Material(
                                color: Colors.white,
                                elevation: 4,
                                shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(35),
                                  ),
                                ),
                                child: Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(left:12,top: 10, bottom: 10),
                                      child: CircleAvatar(
                                        radius: 25,
                                        backgroundImage: imageUrl != null
                                      ? NetworkImage(imageUrl!)
                                      : null,
                                        child: imageUrl == null
                                      ? const Icon(
                                          Icons.person,
                                       
                                          color: Colors.white,
                                        )
                                      : null,
                                        ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 12,
                                        vertical: 16,
                                      ),
                                      child: Container(
                                        height: 50,
                                        width: 180,
                                        child: TextField(controller: _shareWithClass ,
                                        decoration: const InputDecoration(hintText: 'share with your class..' ,
                                        hintStyle: TextStyle(color: Colors.black38)
                                          ),
                                          ),
                                      )
                                        ),
                                  ],
                                ),
                                  ),
                                      ),
                            PostStreamBuilder(classId: classId, teacherId:teacherId),
                            ],
                          ),
                        )),
              ),
            ],
          ),
        )),
      ),
    );
  }
}

 

class PostStreamBuilder extends StatelessWidget {
   PostStreamBuilder({this.classId, this.teacherId, super.key});
  String? classId;
  String? teacherId;
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('courses').doc(classId).collection('posts')
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<postLine> postWidgets = [];
            
            final posts = snapshot.data!.docs;
           
            for (var post in posts) {
              List toStudents= post['toStudents'];
               int lengthofList= toStudents.length;
               for (int i=0; i<lengthofList; i++) {
                 String uid= toStudents[i]['uid'];
                 if (uid== FirebaseAuth.instance.currentUser!.uid) {
                   final type = post.get('type');
              final title = post.get('title');
              final postId = post.get('postId');
              final description= post.get('description');
              final attachment= post.get('attachment');
              final attachmentType = post.get('attachmentType');
              final points = post.get('points');

              final postWidget = postLine(
                  type: type,
                  title: title,
                  postId: postId,
                  classId: classId,
                  teacherId:teacherId,
                  description:description,
                  attachment: attachment,
                  attachmentType:attachmentType,
                  points:points,
                 );
              postWidgets.add(postWidget);
                 }
               }
              
            }
            return Expanded(
              child: ListView(
                children: postWidgets,
              ),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        });
  }
}
class postLine extends StatelessWidget {
   postLine({this.type, this.title, super.key, this.description, this.postId, this.classId, this.teacherId, this.attachment, this.attachmentType, this.points});
  final String? type;
  final String? title;
  final String? postId;
  final String? classId;
  final String? teacherId;
  final String? description;
  final String? attachment;
  final String? attachmentType;
  final String? points;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
      child: InkWell(
        child: Material(
          color: Colors.white,
          elevation: 4,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(35),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 5,
              vertical: 10,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal:5, vertical: 20),
                    child: CircleAvatar(radius: 40,
                    backgroundColor: Color.fromRGBO(255, 255, 255, 1),
                    child:  Image.asset('images/$type.png'),),
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                    
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical:8),
                          child: Text(
                              'New $type : $title',
                              style: const TextStyle(
                                 fontFamily: 'HP Simplified Light', fontWeight: FontWeight.bold,
                                fontSize: 18, color: Colors.black45),
                             
                              overflow: TextOverflow.fade,
                            ),
                          
                        ),
                    
                      Padding(
                        padding: const EdgeInsets.only(right: 10),
                        child: Divider(
                            thickness:2,
                            color: Colors.black45,
                        ),
                      ),
                       Padding(
                          padding: const EdgeInsets.symmetric(vertical:8),
                          child: Text(
                              'Comments (2)',
                              style: const TextStyle(
                                 fontFamily: 'HP Simplified Light', fontWeight: FontWeight.bold,
                                fontSize: 16, color: Colors.black45),
                             
                              overflow: TextOverflow.fade,
                            ),
                          
                        ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (contex) =>  PostScreen(postId: postId, classId: classId, teacherId:teacherId, type:type, title: title, description:description, attachment:attachment ,points: points)));
        },
      ),
    );
  }
}
