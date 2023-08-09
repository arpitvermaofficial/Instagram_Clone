import 'package:cloud_firestore/cloud_firestore.dart';

class Post{
  final String description;
  final String uid;
  final String username;
  final String postid;
  final String datePublished;
  final String posturl;
  final String profImg;
  final likes;

  const Post({
    required this.description,
    required this.uid,
    required this.username,
    required this.postid,
    required this.datePublished,
    required this.posturl,
    required this.profImg,
    required this.likes
  });
  Map<String, dynamic> toJson() => {
    "description": description,
    "uid": uid,
    "username":username,
    "postid": postid,
    "datePublished": datePublished,
    "posturl": posturl,
    "profImg": profImg,
    "likes":likes,
  };

  static Post fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;
    return Post(
        description: snapshot['description'],
        uid: snapshot['uid'],
        username: snapshot['username'],
        postid: snapshot['postid'],
        datePublished: snapshot['datePublished'],
        profImg: snapshot['profImg'],
        posturl: snapshot['posturl'],
      likes: snapshot["likes"]
    );
  }
}
