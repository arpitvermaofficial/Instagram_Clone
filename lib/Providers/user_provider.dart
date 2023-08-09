import 'package:flutter/material.dart';
import 'package:instagram_clone/resources/auth_methods.dart';

import '../Models/user.dart';

class UserProvider with ChangeNotifier{
  User? _user;
  final AuthMethods authMethods=AuthMethods();
  Future<void>refreshUser()async{
    User user=await authMethods.getUserDetails();
    _user=user;
    notifyListeners();
}
  User get getuser=>_user!;

}