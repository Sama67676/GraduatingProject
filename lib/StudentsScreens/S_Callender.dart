import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';
import 'S_hiddenScreens/S_AddNewNote.dart';
final uid = FirebaseAuth.instance.currentUser!.uid;
  DateTime today = DateTime.now();
  String? databaseDay;
    String? databaseMonth;
class S_calender extends StatefulWidget {
  const S_calender({ super.key});

  @override
  State<S_calender> createState() => _S_calenderState();
}

// ignore: camel_case_types
class _S_calenderState extends State<S_calender> {

  void _ondayselected(DateTime day, DateTime focused) {
    final DateTime convtime= DateTime.parse(day.toString());
String outputTime = DateFormat.d().format(convtime);
String outputTimeMonth = DateFormat.M().format(convtime);
    setState(() {
      today = day;
      databaseDay =outputTime;
      databaseMonth =outputTimeMonth;
    });
    
    print(outputTime);
    print(outputTimeMonth);
  }

  @override
  // ignore: dead_code
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
          child: Padding(
              padding: const EdgeInsets.only(
                  left: 15, right: 15, bottom: 2, top: 25),
              child: 
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Column(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(bottom: 18, top: 28),
                          child: Container(
                            decoration: BoxDecoration(
                               boxShadow: const [
                                 BoxShadow(
                                   color: Colors.grey,
                                    blurRadius: 7.0, 
                                    spreadRadius: 1.0,
                                    offset: Offset(
                                     0.0, // Move to right 5  horizontally
                                      5.0, // Move to bottom 5 Vertically
                                   ),
                                 )
                               ],
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(35)),
                            child: TableCalendar(
                              weekendDays: const [DateTime.friday, DateTime.saturday],
                                calendarStyle: const CalendarStyle(
                                    defaultTextStyle: TextStyle(
                                      fontFamily: 'HP Simplified Light', fontWeight: FontWeight.bold,
                                        color: Color.fromARGB(255, 8, 61, 104)),
                                        
                                    selectedDecoration: BoxDecoration(
                                        boxShadow: [
                                         BoxShadow(
                                            color: Colors.grey,
                                           blurRadius: 4.0, 
                                            spreadRadius: 1.0,
                                            offset: Offset(
                                              0.0, // Move to right 5  horizontally
                                              3.0, // Move to bottom 5 Vertically
                                            ),
                                         )
                                       ],
                                        shape: BoxShape.circle,
                                        color:
                                            Color.fromARGB(255, 77, 135, 182)),
                                    todayDecoration: BoxDecoration(
                                           boxShadow: [
                                            BoxShadow(
                                             color: Colors.grey,
                                             blurRadius: 4.0, 
                                             spreadRadius: 1.0,
                                             offset: Offset(
                                                0.0, // Move to right 5  horizontally
                                               3.0, // Move to bottom 5 Vertically
                                              ),
                                            )
                                          ],
                                        shape: BoxShape.circle,
                                        color:
                                            Color.fromARGB(255, 8, 61, 104))),
                                daysOfWeekStyle: const DaysOfWeekStyle(
                                  weekendStyle: TextStyle(
                                    fontSize: 15,
                           
                                      fontFamily: 'HP Simplified Light', fontWeight: FontWeight.bold,
                                        color:
                                            Color.fromARGB(255, 8, 61, 104)
                                  ),
                                    weekdayStyle: TextStyle(
                                      fontSize: 15,
                           
                                      fontFamily: 'HP Simplified Light', fontWeight: FontWeight.bold,
                                        color:
                                            Color.fromARGB(255, 8, 61, 104))
                                            
                                            ),
                                            
                                headerStyle: const HeaderStyle(
                                  headerPadding: EdgeInsets.only(bottom: 20, top: 16),
                                    formatButtonVisible: false,
                                    titleCentered: true,
                                    titleTextStyle: TextStyle(
                                      fontSize: 22,
                                      fontFamily: 'HP Simplified Light', fontWeight: FontWeight.bold,
                                        color:
                                            Color.fromARGB(255, 8, 61, 104))),
                                onDaySelected: _ondayselected,
                                selectedDayPredicate: (day) =>
                                    isSameDay(day, today),
                                availableGestures: AvailableGestures.all,
                                focusedDay: today,
                                firstDay: DateTime(1990),
                                lastDay: DateTime(2070),
                             
                                
                                ),
                          ),
                        )
                        
                      ],
                    ),
                    Expanded(
                        flex: 8,
                        child: Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25),
                            ),
                            elevation: 0,
                            color: const Color.fromARGB(255, 8, 61, 104),
                            child: Padding(padding: const EdgeInsets.all(8.0),
                              child: Stack(
                                children: [
                                  Column(
                                    children: const [
                                    notesStreamBuilder()
                                  ],),
                                 Positioned(
                                    left: 268,
                                    bottom: 30,
                                    child: InkWell(
                                        child: Container(
                                          width: 75,
                                          height: 50,
                                          child: const Material(
                                            elevation: 4,
                                            borderRadius: BorderRadius.all(
                                              Radius.circular(35),
                                            ),
                                            color: Color(0xFFCCCED3),
                                            child: Icon(Icons.add,
                                                color: Color.fromARGB(
                                                    255, 8, 61, 104)),
                                          ),
                                        ),
                                        onTap: () {
                                         Navigator.push(
                                                context,
                                                 MaterialPageRoute(
                                                 builder: (contex) => S_Addevent()));
                                        }),
                                  
                                ),
                              ]),
                            )
                            )
                            )
                  ],
                ),
              )
              ),
    );
  }
}

class notesStreamBuilder extends StatelessWidget {
  const notesStreamBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('users')
            .doc(uid).collection('Notes')
            .where('toTime.day', isEqualTo:  databaseDay)
            .where('toTime.month', isEqualTo:  databaseMonth)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<noteLine> noteWidgets = [];
            final notes = snapshot.data!.docs;
            for (var note in notes) {
              final noteType = note.get('noteType');
              final creator = note.get('creator');
              final title = note.get('title');
              final noteId= note.get('noteId');
  
              final noteWidget = noteLine(
              noteType: noteType,
              noteId: noteId,
              creator: creator,
              title: title,

      );
              noteWidgets.add(noteWidget);
            }
            return Expanded(
              child: ListView(
                children: noteWidgets,
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


class noteLine extends StatelessWidget {
   noteLine(
      {  this.noteType,  this.noteId, this.creator, this.title,  });

  final String? noteType;
  final String? noteId;
  final String? creator;
  final String? title;


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10, bottom: 6, top: 6),
      child:  InkWell(
        child: Material(
          color: Colors.white,
          elevation: 4,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(30),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 5,
              vertical: 10,
            ),
            child: Row(children: [
             Padding(
             padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 12),
               child: CircleAvatar(radius: 35,
                      backgroundColor: Color.fromRGBO(255, 255, 255, 1),
                      child:  Image.asset('images/$noteType.png'),),
             ),
                  
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8,),
                child: SizedBox(
                  width: 180,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '$title',
                        style: const TextStyle(
                           fontFamily: 'HP Simplified Light', fontWeight: FontWeight.bold,
                          fontSize: 20, color:const Color.fromARGB(255, 8, 61, 104)
                          ),
                        maxLines: 2,
                        overflow: TextOverflow.fade,
                      ),
                       Text(
                        '$noteType',
                        style: const TextStyle(
                           fontFamily: 'HP Simplified Light', fontWeight: FontWeight.bold,
                          fontSize: 15, color: Colors.black45),
                        maxLines: 2,
                        overflow: TextOverflow.fade,
                      ),
                       StreamBuilder<DocumentSnapshot>(
                          stream:FirebaseFirestore.instance.collection("users").doc(creator).snapshots(),
                           builder: (context, snapshot) {
                            if (snapshot.data != null) {
                            return  Row(
                           mainAxisAlignment: MainAxisAlignment.start,
                            children: [
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
            Expanded(
                              flex: 1,
                              child: IconButton(
                                onPressed: () {},
                                icon: const Icon(
                                  Icons.more_vert,
                                  color: Colors.black26,
                                  size: 35,
                                ),
                              ),
                            ),
            ]),
          ),
        ),
          onTap: () {
             
        },
      ),
    );
  }
}
