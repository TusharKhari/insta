import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:insta/models/user.dart';
import 'package:insta/providers/user_provider.dart';
import 'package:insta/resources/firestore_methods.dart';
import 'package:insta/screens/comments_screen.dart';
import 'package:insta/utils/colors.dart';
import 'package:insta/utils/global_variables.dart';
import 'package:insta/utils/utils.dart';
import 'package:insta/widget/like_animation.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class PostCard extends StatefulWidget {
  final snap;
  const PostCard({Key? key, required this.snap}) : super(key: key);

  @override
  State<PostCard> createState() => _PostCardState();
}

class _PostCardState extends State<PostCard> {
  bool isLikeAnimating = false;
  int commentLen = 0;
   bool isLoading = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getComments();
  }

  void getComments() async {
    setState(() {
      isLoading = true;
    });
    try {
      QuerySnapshot snap = await FirebaseFirestore.instance
          .collection('posts')
          .doc(widget.snap['postId'])
          .collection('comments')
          .get();

      commentLen = snap.docs.length;
    } catch (e) {
      showSnakBar(e.toString(), context);
    }
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final User user = Provider.of<UserProvider>(context).getUser;
    final width = MediaQuery.of(context).size.width;

    return
         isLoading
            ? const Center(
                child: CircularProgressIndicator(
                  
                  color: primaryColor,
                ),
              )
            :
        Container(
      // boundary needed for web
      decoration: BoxDecoration(
          border: Border.all(
        color: width > webScreenSize ? secondaryColor : mobileBackgroundColor,
      ),
      color: mobileBackgroundColor,
      ),
      
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 16)
                .copyWith(right: 0),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 16,
                  backgroundImage: NetworkImage(
// ======================= not getting profile image from firebase
                    widget.snap['profImage'],
                    // snap.profImage,
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          // "username",
                          widget.snap['username'],
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () {
                    //  showSnakBar('delete'.toString(), context);
                    showDialog(
                        context: context,
                        builder: (context) => Dialog(
                              child: InkWell(
                                onTap: () async {
                                  //    print(widget.snap['postId']);
                                  Navigator.of(context).pop();
                                  //    print('delete2');
                                  try {
                                    FirestoreMethods().deletePost(
                                        widget.snap['postId'].toString());
                                  } catch (e) {
                                    showSnakBar(e.toString(), context);
                                  }
                                },
                                child: ListView(
                                    padding: const EdgeInsets.symmetric(vertical: 16),
                                    shrinkWrap: true,
                                    children: [
                                      const Text(
                                        ' delete post',
                                        style: TextStyle(color: primaryColor),
                                      ),
                                      // 'delete'
                                    ]

                                    /// ==================== removed by me ================
                                    //     .map(
                                    //       (e) => InkWell(
                                    //         onTap: () async {
                                    //           print(widget.snap['postId']);
                                    //           Navigator.of(context).pop();
                                    //           print('delete2');
                                    //           try {
                                    //              FirestoreMethods().deletePost(
                                    //                 widget.snap['postId']
                                    //                     .toString());
                                    //           } catch (e) {
                                    //             showSnakBar(e.toString(), context);
                                    //           }
                                    //         },
                                    //         child: Container(
                                    //           padding: EdgeInsets.symmetric(
                                    //               horizontal: 16, vertical: 12),
                                    //         ),
                                    //       ),
                                    //     )
                                    //     .toList(),
                                    // // ==============================
                                    //
                                    ),
                              ),
                              // child: Container(
                              //     height: 90, width: 40, child: Text('data')),
                            ));
                  },
                  icon: const Icon(Icons.more_vert),
                ),
              ],
            ),
          ),
          //image section
          GestureDetector(
            onDoubleTap: () async {
              await FirestoreMethods().likePost(
                widget.snap['postId'],
                user.uid,
                widget.snap['likes'],
              );
              setState(() {
                isLikeAnimating = true;
              });
            },
            child: Stack(
              alignment: Alignment.center,
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.35,
                  width: double.infinity,
                  child: Image.network(
                      // 'https://static.independent.co.uk/s3fs-public/thumbnails/image/2012/05/01/22/pg-28-fcuk-logo-1-getty.jpg'
                      widget.snap['postUrl']),
                ),
                AnimatedOpacity(
                  duration: const Duration(milliseconds: 150),
                  opacity: isLikeAnimating ? 1 : 0,
                  child: LikeAnimation(
                      child: const Icon(
                        Icons.favorite,
                        color: Colors.white,
                        size: 120,
                      ),
                      isAnimating: isLikeAnimating,
                      duration: const Duration(
                        milliseconds: 400,
                      ),
                      onEnd: () {
                        setState(() {
                          isLikeAnimating = false;
                        });
                      }),
                )
              ],
            ),
          ),
          // loke comment section
          Row(
            children: [
              LikeAnimation(
                isAnimating: widget.snap['likes'].contains(user.uid),
                smallLike: true,
                onEnd: () {},
                child: IconButton(
                    onPressed: () async {
                      await FirestoreMethods().likePost(
                        widget.snap['postId'],
                        user.uid,
                        widget.snap['likes'],
                      );
                    },
                    icon: widget.snap['likes'].contains(user.uid)
                        ? const Icon(
                            Icons.favorite,
                            color: Colors.red,
                          )
                        : const Icon(Icons.favorite_border)),
              ),
              IconButton(
                onPressed: () => Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => CommentsScreen(
                      snap: widget.snap,
                    ),
                  ),
                ),
                icon: const Icon(
                  Icons.comment_outlined,
                  //color: Colors.red,
                ),
              ),
              IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.send,
                  //color: Colors.red,
                ),
              ),
              Expanded(
                child: Align(
                  alignment: Alignment.bottomRight,
                  child: IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.bookmark_border,
                      //color: Colors.red,
                    ),
                  ),
                ),
              ),
            ],
          ),

          //description abd no of comments
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                DefaultTextStyle(
                  style: Theme.of(context)
                      .textTheme
                      .subtitle2!
                      .copyWith(fontWeight: FontWeight.w800),
                  child: Text(
                    //'1,231 likes',
                    '${widget.snap['likes'].length} likes',
                    style: Theme.of(context).textTheme.bodyText2,
                  ),
                ),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.only(
                    top: 8,
                  ),
                  child: RichText(
                    text: TextSpan(
                        style: const TextStyle(
                          color: primaryColor,
                        ),
                        children: [
                          TextSpan(
                            text:
                                // 'username',
                                widget.snap['username'],
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          const TextSpan(
                            text: '   ',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          TextSpan(
                            text:
                                // '  hey is some description to be repalced',
                                widget.snap['description'],
                            // style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ]),
                  ),
                ),
                InkWell(
                  onTap: () => Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => CommentsScreen(
                        snap: widget.snap,
                      ),
                    ),
                  ),
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 4),
                    child: Text(
                      'view all $commentLen coments',
                      style: const TextStyle(fontSize: 16, color: secondaryColor),
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  child: Text(
                    // '19/01/2022',
                    DateFormat.yMMMd().format(
                      widget.snap['datePublished'].toDate(),
                    ),
                    style: const TextStyle(fontSize: 16, color: secondaryColor),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// 4:05:22
