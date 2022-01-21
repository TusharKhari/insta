import 'package:flutter/material.dart';
import 'package:insta/models/user.dart';
import 'package:insta/providers/user_provider.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class CommentCard extends StatefulWidget {
  final snap;
  const CommentCard({Key? key, required this.snap}) : super(key: key);

  @override
  _CommentCardState createState() => _CommentCardState();
}

class _CommentCardState extends State<CommentCard> {
  @override
  Widget build(BuildContext context) {
    final User user = Provider.of<UserProvider>(context).getUser;
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 16),
      child: Row(
        children: [
          CircleAvatar(
            backgroundImage: NetworkImage(
              // 'https://images.unsplash.com/photo-1642542700300-3c8e4c08073f?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=982&q=80'),
              //  user.photoUrl
              widget.snap['profilePic'],
            ),
            radius: 18,
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  RichText(
                    text: TextSpan(children: [
                      TextSpan(
                        text: widget.snap['name'],
                        // user.username,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      const TextSpan(
                        text: '   ',
                        // style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      TextSpan(
                        text: widget.snap['text'],
                        //'some descrion to insert',
                        // style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ]),
                  ),
                  Padding(
                      padding: const EdgeInsets.only(top: 4),
                      child: Text(
                        // "19/01/21",
                        DateFormat.yMMMd()
                            .format(widget.snap['datePublished'].toDate()),
                        style: const TextStyle(
                            fontSize: 12, fontWeight: FontWeight.w400),
                      )),
                ],
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(8),
            child: const Icon(
              Icons.favorite,
              size: 16,
            ),
          ),
        ],
      ),
    );
  }
}
