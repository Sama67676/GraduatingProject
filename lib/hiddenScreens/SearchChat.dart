import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:graduating_project_transformed/Widgets/search.dart';
import 'package:provider/provider.dart';

import '../Others/auth_notifier.dart';
import '../Screan/Chat_screan.dart';
import 'FriendProfile.dart';

   TextEditingController _searchText=TextEditingController();

class SearchChats extends StatefulWidget {
  const SearchChats({required this.title, this.topic,super.key});
  final String title;
  final String? topic;
  @override
  State<SearchChats> createState() => _SearchChatsState(this.title, this.topic);
}

class _SearchChatsState extends State<SearchChats> {
final String title;
  final String? topic;
_SearchChatsState(this.title, this.topic);

  List <Map<String, dynamic>> searchResult=[];
   void onSearch(String? SearchText) async {
    
    var results= await FirebaseFirestore.instance
        .collection('users')
        .where("lowercaseName", isGreaterThanOrEqualTo: SearchText!.toLowerCase(),  isLessThan: SearchText.substring(0, SearchText.length-1) + String.fromCharCode(SearchText.codeUnitAt(SearchText.length - 1) + 1) )
        .get();
       setState(() {
          searchResult = results.docs.map((doc) => doc.data()).toList();
       });
    
 
       
  }

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
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
             Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    
                  Expanded(
                    
                    child:
                        MaterialButton(
                          child: const Padding(
                            padding:  EdgeInsets.symmetric(horizontal:18, vertical: 28),
                            child:  Icon( Icons.arrow_back_ios,
                                      color: Color.fromARGB(255, 8, 61, 104)),
                          ),
                          onPressed: (){
                            _searchText.clear();
                               Navigator.pop(context);
                          })
                  ),
                  Expanded(
                    flex: 4,
                    child:
                        Padding(
                          padding:const EdgeInsets.symmetric(horizontal:18, vertical: 22),
                          child: Text(title, style: const TextStyle(fontSize: 24, fontFamily: 'HP Simplified Light', fontWeight: FontWeight.bold, color: Color.fromARGB(255, 8, 61, 104), ),),
                        )
                       
                            
                      
                  ),
                  ],
                ),
            Padding(
             padding: const EdgeInsets.only(left:20,right: 20, bottom: 10),
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
                  const Padding(
                    padding: EdgeInsets.only(left:12,top: 10, bottom: 10),
                    child:  Icon(
                        Icons.search,
                        size: 35,
                        color: Colors.black38,
                      )
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 16,
                    ),
                    child: Container(
                      height: 50,
                      width: 220,
                      child: TextField(
                        autofocus: true,
                        onChanged: (SearchText){
                          setState(() {
                           onSearch(SearchText);
                            
                          });
                       
                        },
                        controller: _searchText ,
                      decoration:  InputDecoration(hintText: 'Search chats ...' ,
                      hintStyle: TextStyle(color: Colors.black38)
                        ),
                        ),
                    )
                      ),
                      Container(
                        child: IconButton(
                        onPressed: () {
                      
                        },
                        icon: const Icon(
                          Icons.check,
                           size: 30,
                          color: Colors.black38,
                       ),
                     ),
                      ),
                       ],
                    ),
                       ),
                           ),
                           Expanded(
                            flex: 3,
                             child: Padding(
                               padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 18),
                               child: Card(
                               shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(25),
                                ),
                               elevation: 0,
                               color: const Color.fromARGB(255, 8, 61, 104),
                               child:Padding(
                                 padding: const EdgeInsets.symmetric(vertical:18, horizontal: 8),
                                 child: ListView.separated(
                                   separatorBuilder: (BuildContext context, int index) {
                                  return SizedBox(height: 12);
                                    },
                                  itemCount: searchResult.length,
                                  itemBuilder: (context, Index)
                                  { return searchResult[Index]['position'] == topic?
                                   ListTile(
                                         onTap: () {
                                          Navigator.push(
                                           context,
                                           MaterialPageRoute(
                                               builder: (contex) =>   FriendProfile(friendId:searchResult[Index]['uid'])));
                                        
                                                  },
                                      dense: true,
                              visualDensity: VisualDensity(vertical: 4), 
                                      leading: CircleAvatar(
                                        backgroundColor: Colors.white,
                                        radius: 30,
                                        backgroundImage: NetworkImage(searchResult[Index]['imgUrl'])),
                                      title: Text(searchResult[Index]['Name'].toString(), style: TextStyle(color: Colors.white, fontFamily: 'HP Simplified Light', fontWeight: FontWeight.bold, fontSize: 20),),
                                    ):
                                    Container(
                                      height: 1,
                                      width: 1,
                                    )
                                    ;
                                  }
                                  )
                                  )),
                             ),
                           )
          ],)),
      ),
    );
  }
}




