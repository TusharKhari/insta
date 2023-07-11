import 'package:flutter/material.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  @override
  Widget build(BuildContext context) {
    return  const Scaffold(
      body: Center(
        child: Text("c o m i n g  s o o n", style: TextStyle(fontSize: 20),),
      ),
    );
  }
}