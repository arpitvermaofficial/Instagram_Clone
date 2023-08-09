import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:instagram_clone/Utils/global_varibles.dart';

import '../Utils/color.dart';

class WebScreenLayout extends StatefulWidget {
  const WebScreenLayout({Key? key}) : super(key: key);

  @override
  State<WebScreenLayout> createState() => _WebScreenLayoutState();
}

class _WebScreenLayoutState extends State<WebScreenLayout> {
  String username = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUserName();
    pageController = PageController();
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

  void navigationtap(int page) {
    pageController.jumpToPage(page);
    setState(() {
      _page = page;
    });
  }

  void onPageChanged(int page) {
    setState(() {
      _page = page;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: mobileBackgroundColor,
        centerTitle: false,
        title: SvgPicture.asset(
          "assets/ic_instagram.svg",
          color: primaryColor,
          height: 32,
        ),
        actions: [
          IconButton(
            onPressed: () {
              navigationtap(0);
            },
            icon: Icon(Icons.home,
            color: _page==0?primaryColor:secondaryColor,),
          ),
          IconButton(
            onPressed: () {
              navigationtap(1);
            },
            icon: Icon(Icons.search,
              color: _page==1?primaryColor:secondaryColor,),
          ),
          IconButton(
            onPressed: () {
              navigationtap(2);
            },
            icon: Icon(Icons.add_a_photo,
              color: _page==2?primaryColor:secondaryColor,),
          ),
          IconButton(
            onPressed: () {
              navigationtap(3);
            },
            icon: Icon(Icons.favorite,
              color: _page==3?primaryColor:secondaryColor,),
          ),
          IconButton(
            onPressed: () {
              navigationtap(4);
            },
            icon: Icon(Icons.person,
              color: _page==4?primaryColor:secondaryColor,),
          ),
        ],
      ),
      body: PageView(
        physics: NeverScrollableScrollPhysics(),
        children:
          homeScreenItems,
        controller: pageController,
        onPageChanged: onPageChanged
        ,
      ),

    );
  }
}
