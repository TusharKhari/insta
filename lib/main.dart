import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:insta/providers/user_provider.dart';
import 'package:insta/responsive/mobile_screen_layout.dart';
import 'package:insta/responsive/responsive_screen_layout.dart';
import 'package:insta/responsive/web_screen_layout.dart';
import 'package:insta/screens/login_screen.dart';
import 'package:insta/screens/splash_screen.dart';
import 'package:insta/utils/colors.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    await Firebase.initializeApp(
      options: const FirebaseOptions(
        apiKey: 'AIzaSyALiBqnYBHbh6YBnxR1xOK6B1AhAiRa1PE',
        appId: '1:970569335467:web:bb5047e3ff3c4585f96dee',
        messagingSenderId: '970569335467',
        projectId: 'insta-c0fbd',
        storageBucket: 'insta-c0fbd.appspot.com',
      ),
    );
  } else {
    await Firebase.initializeApp();
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: SplashScreen(),
    );

    // MultiProvider(
    //   providers: [
    //     ChangeNotifierProvider(
    //       create: (_) => UserProvider(),
    //     )
    //   ],
    //   child: MaterialApp(
    //     //debugShowCheckedModeBanner: false,
    //     title: 'insta',
    //     theme: ThemeData.dark()
    //         .copyWith(scaffoldBackgroundColor: mobileBackgroundColor),
    //     home: StreamBuilder(
    //       stream: FirebaseAuth.instance.authStateChanges(),
    //       builder: (context, snapshot) {
    //         // ========
    //         if (snapshot.connectionState == ConnectionState.active) {
    //           if (snapshot.hasData) {
    //             return ResponsiveLayout(
    //                 mobileScreenLayout: MobileScreenLayout(),
    //                 webScreenLayout: const WebScreenLayout());
    //           } else if (snapshot.hasError) {
    //             return Center(
    //               child: Text('${snapshot.error}'),
    //             );
    //           }
    //         }
    //         if (snapshot.connectionState == ConnectionState.waiting) {
    //           return const Center(
    //             child:  CircularProgressIndicator(
    //               color: Colors.yellow,
    //             ),
    //           );
    //         }
    //         //==========================
    //         return LoginScreen();
    //       },
    //     ),
    //   ),
    // );
  }
}

class FirstScreen extends StatefulWidget {
  const FirstScreen({Key? key}) : super(key: key);

  @override
  _FirstScreenState createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen> {
  @override
  Widget build(BuildContext context) {
    return
    
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => UserProvider(),
        )
      ],
      child: MaterialApp(
        //debugShowCheckedModeBanner: false,
        title: 'insta',
        theme: ThemeData.dark()
            .copyWith(scaffoldBackgroundColor: mobileBackgroundColor),
        home: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            // ======================================
            
            if (snapshot.connectionState == ConnectionState.active) {
              if (snapshot.hasData) {
                return ResponsiveLayout(
                    mobileScreenLayout: MobileScreenLayout(),
                    webScreenLayout: const WebScreenLayout());
              } else if (snapshot.hasError) {
                return Center(
                  child: Text('${snapshot.error}'),
                );
              }
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child:  CircularProgressIndicator(
                  color: Colors.yellow,
                ),
              );
            }
            //==========================
            return LoginScreen();
          },
        ),
      ),
    );
  }
}