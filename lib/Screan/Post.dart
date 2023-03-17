
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';



class PostScreen extends StatefulWidget {
  PostScreen({this.postId,this.title, this.type, this.classId,this.teacherId, this.description,this.attachment, this.points, super.key});
  String? postId;
  String? classId;
  String? teacherId;
 String? type;
 String? title;
 String? description;
 String? attachment;
 String? points;
  @override
  State<PostScreen> createState() => _PostScreenState(this.postId,this.title, this.type, this.teacherId, this.classId, this.description,this.attachment, this.points,);
}

class _PostScreenState extends State<PostScreen> {
    String? postId;
  String? classId;
  String? teacherId;
 String? type;
 String? title;
  String? description;
  String? attachment;
  String? points;
    _PostScreenState(this.postId,this.title,this.type, this.teacherId, this.classId,  this.description,this.attachment, this.points,);


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
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
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
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
                            icon: const Icon(Icons.more_vert,
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
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 34,),
                  child: Column(
                  
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                    Text(type!,
                     style: TextStyle(
                                           fontFamily: 'HP Simplified Light', fontWeight: FontWeight.bold,
                                          color: Color.fromARGB(255, 8, 61, 104),
                                          fontSize:50,
                                        ),
                    ),
                     Text(title!,
                     style: TextStyle(
                                           fontFamily: 'HP Simplified Light', fontWeight: FontWeight.bold,
                                          color: Color.fromARGB(255, 8, 61, 104),
                                          fontSize:30,
                                        ),
                    ),
                     Text('I/O Interface',
                     style: TextStyle(
                                           fontFamily: 'HP Simplified Light', fontWeight: FontWeight.bold,
                                          color: Color.fromARGB(255, 8, 61, 104),
                                          fontSize:30,
                                        ),
                    )
                  ],),
                ),
                 Expanded(
                  flex: 8,
                  child: Padding(
                    padding: const EdgeInsets.all(24),
                    child: Stack(
                      children: [
                        Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25),
                            ),
                            elevation: 0,
                            color: const Color.fromARGB(255, 8, 61, 104),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                 Padding(
                                   padding: const EdgeInsets.all(8.0),
                                   child: Row(
                                     children: [
                                       StreamBuilder<DocumentSnapshot>(
                            stream:FirebaseFirestore.instance.collection("users").doc(teacherId).snapshots(),
                             builder: (context, snapshot) {
                              if (snapshot.data != null) {
                              return  Row(
                             mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                               Padding(
                                 padding: const EdgeInsets.all(8.0),
                                 child: CircleAvatar(
                                  radius: 24,
                                  backgroundColor: Colors.white,
                                 backgroundImage: NetworkImage(snapshot.data?['imgUrl']),
                                  ),
                               ),
                              
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text( '${snapshot.data?['Name']} :' ,
                                   style: const TextStyle(color: Colors.white,
                                          fontFamily: 'HP Simplified Light', fontWeight: FontWeight.bold,
                                          fontSize: 18,)),
                              )      
                              ],
                              );
                            } else{
                             return  Container();
                             }
                          } 
                          ),
                                     
                                     ],
                                   ),
                                 ),
                                 Padding(
                                   padding: const EdgeInsets.all(10),
                                   child: Text(description ?? '',
                                    style: TextStyle(color: Colors.white,
                                          fontFamily: 'HP Simplified Light', fontWeight: FontWeight.bold,
                                          fontSize: 24,
                                         ),),
                                 ),
                                 Padding(
                                   padding: const EdgeInsets.all(8.0),
                                   child: Container(
                                    height: 100,
                                    width: 100,
                                    color: Colors.white,
                                    child: Image.asset('images/note-taking.png'),
                                   ),
                                 ),
                                 Padding(
                                   padding: const EdgeInsets.all(8.0),
                                   child: Text('$points points',
                                     style: TextStyle(color: Colors.white,
                                            fontFamily: 'HP Simplified Light', fontWeight: FontWeight.bold,
                                            fontSize: 16,
                                           ),
                                   ),
                                 ),
                                 Padding(
                                   padding: const EdgeInsets.symmetric(horizontal:8.0),
                                   child: Text('due 9:15 A.M.',
                                   style: TextStyle(color: Colors.white,
                                              fontFamily: 'HP Simplified Light', fontWeight: FontWeight.bold,
                                              fontSize: 16,
                                             ),),
                                 ),
                               
                                ],
                              ),
                            )),
                              Positioned(
                                left: 230,
                                top: 420,
                                child: Container(
                                    width: 95,
                                    height: 50,
                                     child: Material(
                                      elevation: 4,
                                      
                                      borderRadius: const BorderRadius.all(
                                       Radius.circular(35),
                                       ),
                                      color:  const Color(0xFFCCCED3),
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
                                        child: Text('Submit',
                                        style: TextStyle(
                                          fontSize: 20,
                                          color: const Color.fromARGB(255, 8, 61, 104), fontFamily: 'HP Simplified Light', fontWeight: FontWeight.bold ),
                                        ),
                                      ),
                                     ),
                                   ),
                              ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal:24),
                  child: Text(
                  'your score: -/10',
                  style: TextStyle(
                     fontFamily: 'HP Simplified Light', fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 8, 61, 104),
                    fontSize:16,
                  ),
                              ),
                ),
                Expanded(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                              children: [
                                const Expanded(
                                  flex: 4,
                                  child: Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Text(
                                      'Comments',
                                      style: TextStyle(
                                         fontFamily: 'HP Simplified Light', fontWeight: FontWeight.bold,
                                        color: Color.fromARGB(255, 8, 61, 104),
                                        fontSize:24,
                                      ),
                                    ),
                                  ),
                                ),
                                const Expanded(
                                  flex: 1,
                                  child: Icon(
                                    Icons.arrow_drop_down,
                                    size: 40,
                                    color: Color.fromARGB(255, 8, 61, 104),
                                  ),
                                ),
                              ],
                            ),
                      ),
                    ],
                  ),
                ),
                
            ],
          ),
        ),
      ),
    ) ;
  }
}