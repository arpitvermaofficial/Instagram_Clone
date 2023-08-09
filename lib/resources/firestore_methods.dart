import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:instagram_clone/Models/post.dart';
import 'package:instagram_clone/resources/storage_methos.dart';
import 'package:uuid/uuid.dart';

class FireStoreMethods {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  Future<String> uploadPost(String description, Uint8List file, String uid,
      String username, String profImg) async {
    String res = "Some error has occured";
    String postid = const Uuid().v1();
    try {
      String PhotoUrl =
          await StorageMethods().uploadImageToStorage('posts', file, true);
      Post post = Post(
          description: description,
          uid: uid,
          username: username,
          postid: postid,
          datePublished: DateTime.now().toString(),
          posturl: PhotoUrl,
          profImg: profImg,
          likes: []);
      _firestore.collection('posts').doc(postid).set(post.toJson());
      res="Success";
    } catch (err) {
      res=err.toString();
    }
    return res;
  }

  Future<void>likePost(String postId,String uid,List likes)async{
    try{
      if(likes.contains(uid)){
        await _firestore.collection('posts').doc(postId).update({
          'likes':FieldValue.arrayRemove([uid])
        });
      }else{
        await _firestore.collection('posts').doc(postId).update({
          'likes':FieldValue.arrayUnion([uid])
        });
      }

    }catch(err){
      print(err.toString());
    }
  }
  Future<void>postComments(String postId,String Comment,String uid,String name,String profilrPic)async {
    try{
      if(Comment.isNotEmpty){
        String commentId=Uuid().v1();
        await _firestore.collection('posts').doc(postId).collection('comments').doc(commentId).set({
          'profilePic':profilrPic,
          'name':name,
          'uid':uid,
          'text':Comment,
          'commentId':commentId,
          'datePublished':DateTime.now().toString(),
        });
      }else{
        print('text is empty');
      }
    }catch(e){
      print(e.toString());
    }
  }


  Future<void>deletePost(String postid)async{
   try{
     await _firestore.collection('posts').doc(postid).delete();
   }catch(e){
     print(e.toString());
   }
  }


  Future<void>followUser(
      String uid,
      String followid
      )async{
    try{
      DocumentSnapshot snap= await _firestore.collection('users').doc(uid).get();
      List following =(snap.data()! as dynamic)['following'];
      if(following.contains(followid)){
        await _firestore.collection('users').doc(followid).update({
          'followers':FieldValue.arrayRemove([uid])
        });
        await _firestore.collection('users').doc(uid).update({
          'following':FieldValue.arrayRemove([followid])
        });
    }
      else{
        await _firestore.collection('users').doc(followid).update({
          'followers':FieldValue.arrayUnion([uid])
        });
        await _firestore.collection('users').doc(uid).update({
          'following':FieldValue.arrayUnion([followid])
        });
      }
    }
    catch(err){
      print(err.toString());
    }
  }


}
