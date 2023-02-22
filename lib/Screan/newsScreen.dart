import 'package:flutter/material.dart';

class newsScreen extends StatefulWidget {
  const newsScreen({super.key});

  @override
  State<newsScreen> createState() => _newsScreenState();
}

class _newsScreenState extends State<newsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('myapp'),
      ),
      body: Center(
        child: Text('News Screen is under maintenance'),
      ),
    );
  }
}
