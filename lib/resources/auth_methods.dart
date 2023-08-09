import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:instagram_clone/resources/storage_methos.dart';
import 'package:instagram_clone/Models/user.dart' as Model  ;

class AuthMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore=FirebaseFirestore.instance;
  Future<Model.User>getUserDetails()async{
    User currentUser=_auth.currentUser!;
    DocumentSnapshot snap=await _firestore.collection('users').doc(currentUser.uid).get();
    return Model.User.fromSnap(snap);

  }

  Future<String>signupuser(
      {required String email,
      required String password,
      required String username,
      required String bio,
      required Uint8List file}) async{
    String res="Some error has occured";
    try{
      if(email.isNotEmpty||password.isNotEmpty||username.isNotEmpty||bio.isNotEmpty||file !=null){
        UserCredential cred=await _auth.createUserWithEmailAndPassword(email: email, password: password);
        String  photoUrl=await StorageMethods().uploadImageToStorage('profilePics', file, false);

        Model.User user=Model.User(
          username: username,
          uid: cred.user!.uid,
          bio: bio,
          followers: [],
          following: [],
          email: email,
          photoUrl: photoUrl

        );
        await _firestore.collection('users').doc(cred.user!.uid).set(
        user.toJson());
      }
      res="success";
    }
    catch(err){
      res=err.toString();
    }
    return res;
  }


  Future<String>loginUser({required String email,required String password} )async{
    String res="Some error has occured";
    try{
      if(email.isNotEmpty||password.isNotEmpty){
        await _auth.signInWithEmailAndPassword(email: email, password: password);
        res="success";

      }else{
        res="Please enter all the fields";
      }

    }
    catch(err){
      res=err.toString();
    }
    return res;

  }
  Future<void>signOut()async{
    _auth.signOut();
  }
}
