import 'dart:async';

import 'package:flutter/material.dart';
import 'package:insta/main.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(
        const Duration(seconds: 2),
        () => Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => FirstScreen())));
  }

  @override
  Widget build(BuildContext context) {
    return  Center(
        child:  Column(
      children: [
        const SizedBox(
          width: double.infinity,
          height: 210,
        ),
        const Text('instagram'),
        const SizedBox(
          width: double.infinity,
          height: 90,
        ),
        Row(
          children: [
            const Text('made with '),
            const Icon(
              Icons.favorite,
              color: Colors.green,
            ),
            const Text('by'),
          ],
        ),
        const SizedBox(
          width: double.infinity,
          height: 90,
        ),
        const Text("KHARI")
      ],
    ));
  }
}
