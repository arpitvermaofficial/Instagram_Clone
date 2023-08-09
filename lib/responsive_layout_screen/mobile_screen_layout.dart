import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone/Providers/user_provider.dart';
import 'package:instagram_clone/Utils/color.dart';
import 'package:instagram_clone/Utils/global_varibles.dart';
import 'package:provider/provider.dart';
import 'package:instagram_clone/Models/user.dart' as model;

class MobileScreenLayout extends StatefulWidget {
  const MobileScreenLayout({Key? key}) : super(key: key);

  @override
  State<MobileScreenLayout> createState() => _MobileScreenLayoutState();
}

class _MobileScreenLayoutState extends State<MobileScreenLayout> {
  String username = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUserName();
    pageController=PageController();
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    pageController.dispose();
  }
  void getUserName() async {
    DocumentSnapshot snap = await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get();
    setState(() {
      username = (snap.data() as Map<String, dynamic>)['username'];
    });
  }

  int _page = 0;
  late PageController pageController;
  
  void navigationtap(int page){
    pageController.jumpToPage(page);
  }
  void onPageChanged(int page){
    setState(() {
        _page=page;
    });
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body:PageView(
        children:
          homeScreenItems
        ,
        controller: pageController,
        onPageChanged: onPageChanged,
        physics: const NeverScrollableScrollPhysics(),
      ),
      // Text(user.username),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: mobileBackgroundColor,
        items: [
          BottomNavigationBarItem(
              icon: Icon(
                Icons.home,
                color: _page == 0 ? primaryColor : secondaryColor,
              ),
              label: '',
             ),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.search,
                color: _page == 1 ?   primaryColor:secondaryColor,
              ),
              label: '',
              ),

          BottomNavigationBarItem(
              icon: Icon(
                Icons.add_circle,
                color: _page == 2 ? primaryColor : secondaryColor,
              ),
              label: '',
             ),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.favorite,
                color: _page == 3? primaryColor : secondaryColor,
              ),
              label: '',
              ),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.person,
                color: _page == 4? primaryColor : secondaryColor,
              ),
              label: '',
              ),
        ],
        onTap: navigationtap,
      ),
    );
  }
}
