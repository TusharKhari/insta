import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:insta/screens/profile_screen.dart';
import 'package:insta/utils/colors.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
// ignore_for_file: prefer_const_literals_to_create_immutables,prefer_const_constructors_in_immutables, camel_case_types,prefer_const_constructors

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController searchController = TextEditingController();
  bool isShowUser = false;
  

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    searchController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: mobileBackgroundColor,
        title: TextFormField(
          controller: searchController,
          decoration: InputDecoration(labelText: 'search for a user'),
          onFieldSubmitted: (String _) {
            //    print('kddk');
            setState(() {
              isShowUser = true;
              
            });
          },
        ),
      ),
      body: 
      // isLoading? Center(
      //   child: CircularProgressIndicator(color: primaryColor,),
      // ):
      isShowUser
          ? FutureBuilder(
              future: FirebaseFirestore.instance
                  .collection('users')
                  .where('username',
                      isGreaterThanOrEqualTo: searchController.text)
                  .get(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Center(
                    child: CircularProgressIndicator(
                      color: primaryColor,
                    ),
                  );
                }
                return ListView.builder(
                    itemCount: (snapshot.data! as dynamic).docs.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () => Navigator.of(context).push(
                          MaterialPageRoute(
                            
                            builder: (context) => ProfileScreen(
                              
                              uid: (snapshot.data! as dynamic).docs[index]
                                  ['uid'],
                            ),
                          ),
                        ),
                        child: ListTile(
                          
                          leading: CircleAvatar(
                            backgroundImage: NetworkImage(
                                (snapshot.data! as dynamic).docs[index]
                                    ['photoUrl']),
                          ),
                          title: Text((snapshot.data! as dynamic).docs[index]
                              ['username']),
                        ),
                      );
                    });
              },
            )
          : FutureBuilder(
              future: FirebaseFirestore.instance
                  .collection('posts')
                  .orderBy('datePublished')
                  .get(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
                return
                    // StaggeredGridView.countBuilder(
                    //   crossAxisCount: 3,
                    //   itemCount: (snapshot.data! as dynamic).docs.length,
                    //   itemBuilder: (context, index) => Image.network(
                    //     (snapshot.data! as dynamic).docs[index]['postUrl'],
                    //     fit: BoxFit.cover,
                    //   ),
                    //   staggeredTileBuilder: (index) => MediaQuery.of(context)
                    //               .size
                    //               .width >
                    //           webScreenSize
                    //       ? StaggeredTile.count(
                    //           (index % 7 == 0) ? 1 : 1, (index % 7 == 0) ? 1 : 1)
                    //       : StaggeredTile.count(
                    //           (index % 7 == 0) ? 2 : 1, (index % 7 == 0) ? 2 : 1),
                    //   mainAxisSpacing: 8.0,
                    //   crossAxisSpacing: 8.0,
                    // );

                    //     StaggeredGrid.count(
                    //   crossAxisCount: 3,
                    //   children: [Text('data')],
                    // );

                    GridView.custom(
                  shrinkWrap: true,
                  //   semanticChildCount: 0,
                  gridDelegate: SliverQuiltedGridDelegate(
                    // crossAxisCount: (snapshot.data! as dynamic).docs.length,
                    // mainAxisSpacing: (snapshot.data! as dynamic).docs.length,
                    // crossAxisSpacing: (snapshot.data! as dynamic).docs.length,
                    crossAxisCount: 4,
                    mainAxisSpacing: 4,
                    crossAxisSpacing: 4,
                    repeatPattern: QuiltedGridRepeatPattern.inverted,
                    pattern: [
                      QuiltedGridTile(2, 2),
                      QuiltedGridTile(1, 1),
                      QuiltedGridTile(1, 1),
                      QuiltedGridTile(1, 2),
                    ],
                  ),
                  childrenDelegate: SliverChildBuilderDelegate(
                    (context, index) => Image.network(
                      (snapshot.data! as dynamic).docs[index]['postUrl'],
                      fit: BoxFit.cover,
                    ),
                    // childCount: 4,
                    childCount: (snapshot.data! as dynamic).docs.length,
                  ),
                );
              }),
    );
  }
}
