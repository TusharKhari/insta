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

  final Shader linearGradient = LinearGradient(
      // colors: <Color>[Color(0xffDA44bb), Color(0xff8921aa),],
      colors: [
        Colors.pink,
        // Colors.yellow.shade100,
        Colors.pink.shade900,
      ]).createShader(Rect.fromLTWH(0.0, 0.0, 200.0, 70.0));
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Column(
        //  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          const SizedBox(
            // width: double.infinity,
            height: 150,
          ),
          Image.asset('assets/Instagram-Logo.wine.png'),
          const SizedBox(
            //  width: double.infinity,
            height: 200,
          ),
          const Text(
            'From',
            style: TextStyle(fontSize: 18, color: Colors.black54),
          ),
          Text(
            "K H A R I",
            style: TextStyle(
              fontStyle: FontStyle.italic,
              fontSize: 60,
              foreground: Paint()..shader = linearGradient,
              fontWeight: FontWeight.w500,
            ),
          ),
          const Text(
            "Made with love in Flutter",
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.w400,
            ),
          )
        ],
      )),
    );
  }
}
