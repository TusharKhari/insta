import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:insta/models/post.dart';
import 'package:insta/resources/storage_methods.dart';
import 'package:uuid/uuid.dart';

class FirestoreMethods {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // upload post
  Future<String> uploadPost(
    String description,
    Uint8List file,
    String uid,
    String username,
    String profImage,
    // String likes,
  ) async {
    String res = "some error occurred";
    try {
      String photoUrl =
          await StorageMethods().uploadImageToStorage('posts', file, true);

      String postid = const Uuid().v1();

      Post post = Post(
        description: description,
        uid: uid,
        postId: postid,
        username: username,
        datePublished: DateTime.now(),
        postUrl: photoUrl,
        profImage: profImage,
        likes: [],

        //  likes: likes
      );

      _firestore.collection('posts').doc(postid).set(post.toJson());
      res = "success";
    } catch (e) {
      res = e.toString();
    }
    return res;
  }

  Future<void> likePost(String postId, String uid, List likes) async {
    try {
      if (likes.contains(uid)) {
        await _firestore.collection('posts').doc(postId).update({
          'likes': FieldValue.arrayRemove([uid]),
        });
      } else {
        await _firestore.collection('posts').doc(postId).update({
          'likes': FieldValue.arrayUnion([uid]),
        });
      }
    } catch (e) {
      print(e.toString());
    }
  }

  // Future<void> postComment(String postId, String text, String uid, String name,
  //     String profilePic) async {
  //   try {
  //     if (text.isNotEmpty) {
  //       String commentId = Uuid().v1();
  //       await _firestore
  //           .collection('posts')
  //           .doc(postId)
  //           .collection('comments')
  //           .doc(commentId)
  //           .set({
  //         'profilePic': profilePic,
  //         'name': name,
  //         'uid': uid,
  //         'datePublished': DateTime.now(),
  //       });
  //     } else {
  //       print('text is empty');
  //     }
  //   } catch (e) {
  //     print(e.toString());
  //   }
  // }
  // Post comment
  Future<String> postComment(String postId, String text, String uid,
      String name, String profilePic) async {
    String res = "Some error occurred";
    try {
      if (text.isNotEmpty) {
        // if the likes list contains the user uid, we need to remove it
        String commentId = const Uuid().v1();
        _firestore
            .collection('posts')
            .doc(postId)
            .collection('comments')
            .doc(commentId)
            .set({
          'profilePic': profilePic,
          'name': name,
          'uid': uid,
          'text': text,
          'commentId': commentId,
          'datePublished': DateTime.now(),
        });
        res = 'success';
      } else {
        res = "Please enter text";
      }
    } catch (err) {
      res = err.toString();
    }
    return res;
  }

  // deleting a post

  // Future<void> deletPost(String posdId) async {
  //   try {
  //     //  await  _firestore.collection('posts').doc('postId').delete();
  //     await _firestore.collection('posts').doc(postId).delete();
  //   } catch (e) {
  //     print(e.toString());
  //   }
  // }
  // Delete Post
  Future<String> deletePost(String postId) async {
    String res = "Some error occurred";
    try {
      await _firestore.collection('posts').doc(postId).delete();
      res = 'success';
    } catch (err) {
      res = err.toString();
      // showSnakBar(res, context);
    }
    return res;
  }

  // // follow user
  // Future<void> followUser(String uid, String followId) async {
  //   try {
  //     DocumentSnapshot snap =
  //         await _firestore.collection('users').doc(uid).get();
  //     List following = (snap.data()! as dynamic)['following'];

  //     // if (following.contains('followId')) {
  //     //   await _firestore.collection('users').doc(followId).update(
  //     //     'followers' : FieldValue.arrayRemove([uid])
  //     //   );
  //     // }
      
  //   } catch (e) {
  //     //  showSnakBar(e.toString(), context);
  //     print(e);
  //   }
  // }

    Future<void> followUser(
    String uid,
    String followId
  ) async {
    try {
      DocumentSnapshot snap = await _firestore.collection('users').doc(uid).get();
      List following = (snap.data()! as dynamic)['following'];

      if(following.contains(followId)) {
        await _firestore.collection('users').doc(followId).update({
          'followers': FieldValue.arrayRemove([uid])
        });

        await _firestore.collection('users').doc(uid).update({
          'following': FieldValue.arrayRemove([followId])
        });
      } else {
        await _firestore.collection('users').doc(followId).update({
          'followers': FieldValue.arrayUnion([uid])
        });

        await _firestore.collection('users').doc(uid).update({
          'following': FieldValue.arrayUnion([followId])
        });
      }

    } catch(e) {
     // print(e.toString());
    }
  }


}
