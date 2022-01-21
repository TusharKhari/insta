// ignore_for_file: prefer_const_constructors
// ignore_for_file: prefer_const_literals_to_create_immutables,prefer_const_constructors_in_immutables, camel_case_types,
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:insta/utils/colors.dart';
import 'package:insta/utils/global_variables.dart';

class MobileScreenLayout extends StatefulWidget {
  MobileScreenLayout({Key? key}) : super(key: key);

  @override
  _MobileScreenLayoutState createState() => _MobileScreenLayoutState();
}

class _MobileScreenLayoutState extends State<MobileScreenLayout> {
  int _page = 0;
  late PageController pageController;

  @override
  void initState() {
    // TODO: implement initState
    pageController = PageController();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    pageController.dispose();
  }

  void navigationTapped(int page) {
    pageController.jumpToPage(page);
  }

  void onPageChanged(int page) {
    setState(() {
      _page = page;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        children: homeScreenItems,
        controller: pageController,
        onPageChanged: onPageChanged,
        physics: NeverScrollableScrollPhysics(),
      ),
      bottomNavigationBar: CupertinoTabBar(
        backgroundColor: mobileBackgroundColor,
        items: [
          BottomNavigationBarItem(
              icon: Icon(
                Icons.home,
                color: _page == 0 ? primaryColor : secondaryColor,
              ),
              label: '',
              backgroundColor: primaryColor),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.search,
                color: _page == 1 ? primaryColor : secondaryColor,
              ),
              label: '',
              backgroundColor: primaryColor),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.add_circle,
                color: _page == 2 ? primaryColor : secondaryColor,
              ),
              label: '',
              backgroundColor: primaryColor),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.favorite,
                color: _page == 3 ? primaryColor : secondaryColor,
              ),
              label: '',
              backgroundColor: primaryColor),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.person,
                color: _page == 4 ? primaryColor : secondaryColor,
              ),
              label: '',
              backgroundColor: primaryColor),
        ],
        onTap: navigationTapped,
      ),
    );
  }
}

// class MobileScreenLayout extends StatefulWidget {
//   const MobileScreenLayout({Key? key}) : super(key: key);

//   @override
//   _MobileScreenLayoutState createState() => _MobileScreenLayoutState();
// }

// class _MobileScreenLayoutState extends State<MobileScreenLayout> {
//   String username = "";
//   String email = "";

//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     getUsername();
//     getemail();
//   }

//   void getUsername() async {
//     DocumentSnapshot snap = await FirebaseFirestore.instance
//         .collection('users')
//         .doc(FirebaseAuth.instance.currentUser!.uid)
//         .get();

//     print(snap.data());

//     setState(() {
//       username = (snap.data() as Map<String, dynamic>)['username'];
//     });
//   }

//   void getemail() async {
//     DocumentSnapshot snap = await FirebaseFirestore.instance
//         .collection('users')
//         .doc(FirebaseAuth.instance.currentUser!.uid)
//         .get();

//     print(snap.data());

//     setState(() {
//       email = (snap.data() as Map<String, dynamic>)['email'];
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     //model.User? user = Provider.of<UserProvider>(context).getUser;

//     return Scaffold(
//       // body: Center(child: Text(username)
//       //     //     Column(
//       //     //   children: [
//       //     //     // Text(username),
//       //     //     Text(email)
//       //     //   ],
//       //     // )
//       //     ),
//       body: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Text(username),
//           Text(email),
//           Image.network(
//               'gs://insta-c0fbd.appspot.com/profilePics/2lzH6kbKfIYwTYZfQc8pjb3x2OX2'),
//         ],
//       ),
//     );
//   }
// }
