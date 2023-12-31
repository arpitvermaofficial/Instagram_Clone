import 'dart:typed_data';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:uuid/uuid.dart';

class StorageMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;

  Future<String> uploadImageToStorage(
      String ChildName, Uint8List file, bool isPost) async {
    Reference ref =
        _storage.ref().child(ChildName).child(_auth.currentUser!.uid);
    print("ho"+ref.toString());
    if(isPost){
      print("ho"+ref.toString());
      String id=const Uuid().v1();
      ref=ref.child(id);
      print("ho"+ref.toString());
    }

    UploadTask uploadTask = ref.putData(file);
    TaskSnapshot snap = await uploadTask;
    String downloadUrl = await snap.ref.getDownloadURL();
    return downloadUrl;
  }
}
