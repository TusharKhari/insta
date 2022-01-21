import 'package:cloud_firestore/cloud_firestore.dart';

class Post {
  final String description;
  final String uid;
  final String postId;
  final String username;
  final  datePublished;
  final String postUrl;
  final String profImage;
  final likes;

   Post({
    required this.description,
    required this.uid,
    required this.postId,
    required this.username,
    required this.datePublished,
    required this.postUrl,
    required this.profImage,
    required this.likes,
  });

  static Post fromsnap(DocumentSnapshot documentSnapshot) {
    var snapshot = documentSnapshot.data() as Map<String, dynamic>;

    return Post(
      username: snapshot["username"],
      uid: snapshot["uid"],
      postId: snapshot["postid"],
      postUrl: snapshot["postUrl"],
      profImage: snapshot["profImage"],
      description: snapshot["description"],
      datePublished: snapshot["datePublished"],
      likes: snapshot["likes"],

    );
  }

  Map<String, dynamic> toJson() => {
        "username": username,
        "uid": uid,
       "postId": postId,
        "postUrl": postUrl,
        "profImage": profImage,
        "description": description,
        "datePublished": datePublished,
       "likes": likes,
      };
}
