
import 'package:flutter/material.dart';


class ShowFullImage extends StatelessWidget {
   const ShowFullImage({super.key, required this.image});
final String image;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
  body:  Image.network(
   image,
    fit: BoxFit.contain,
    height: double.infinity,
    width: double.infinity,
    alignment: Alignment.center,
  ),
);
  }
}