import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class UnderInstructions extends StatelessWidget {
  const UnderInstructions({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Center(child: Container(
          height: 50,
          width: 50,
          child: ListWheelScrollView.useDelegate(
            perspective: 0.005,
           
            physics: FixedExtentScrollPhysics(),
            itemExtent: 20, 
          childDelegate: ListWheelChildBuilderDelegate(
            
            childCount: 100,
            builder: (context, index){
              return MyTile(index: index.toString());
          })),
        )
        )
      )
    ) ;
  }
}
class MyTile extends StatelessWidget {
  const MyTile({required this.index, super.key});
   final String index;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(index, style: TextStyle(fontSize: 20),),
    );
    
  }
}