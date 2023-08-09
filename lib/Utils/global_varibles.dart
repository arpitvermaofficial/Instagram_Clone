import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone/Screens/Search_screen.dart';
import 'package:instagram_clone/Screens/add_post_screen.dart';
import 'package:instagram_clone/Screens/feed_screen.dart';
import 'package:instagram_clone/Screens/profile_screen.dart';

const webScreenSize=600;
List<Widget> homeScreenItems=[
  FeedScreen(),
  SearchScreen(),
  AddPostScreen(),
  Text(''),
  ProfileScreen(uid:FirebaseAuth.instance.currentUser!.uid),
];