import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';



  DateTime today = DateTime.now();
  String? databaseDay;
    String? databaseMonth;
class GuestCalender extends StatefulWidget {
  const GuestCalender({ super.key});

  @override
  State<GuestCalender> createState() => _GuestCalenderState();
}

// ignore: camel_case_types
class _GuestCalenderState extends State<GuestCalender> {

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
                              weekendDays: [DateTime.friday, DateTime.saturday],
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
                               SizedBox(height: 10,)
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

