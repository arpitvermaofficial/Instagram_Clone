import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  final String email;
  final String photoUrl;
  final String bio;
  final List following;
  final List followers;
  final String uid;
  final String username;

  const User({
    required this.email,
    required this.photoUrl,
    required this.uid,
    required this.bio,
    required this.followers,
    required this.following,
    required this.username,
  });
  Map<String, dynamic> toJson() => {
        "username": username,
        "email": email,
        "uid": uid,
        "bio": bio,
        "photoUrl": photoUrl,
        "follower": followers,
        "following": following,
      };

  static User fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;
    return User(
        email: snapshot['email'],
        photoUrl: snapshot['photoUrl'],
        uid: snapshot['uid'],
        bio: snapshot['bio'],
        followers: snapshot['followers'],
        following: snapshot['following'],
        username: snapshot['username']);
  }
}
