import 'package:flutter/material.dart';
import 'package:instagram_clone/Providers/user_provider.dart';
import 'package:instagram_clone/Utils/dimension.dart';
import 'package:provider/provider.dart';


class ResponsiveLayout extends StatefulWidget {
  final Widget webScreenLayout;
  final Widget mobileScreenLayout;
  const ResponsiveLayout({Key? key,required this.mobileScreenLayout,required this.webScreenLayout}) : super(key: key);

  @override
  State<ResponsiveLayout> createState() => _ResponsiveLayoutState();
}

class _ResponsiveLayoutState extends State<ResponsiveLayout> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    addData();
  }
  void addData()async{
    UserProvider _userprovider=Provider.of(context,listen: false);
    await _userprovider.refreshUser();
  }
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context,constrains){
      if(constrains.maxWidth>webScreenSize){
        return widget.webScreenLayout;
      }
      return widget.mobileScreenLayout;
    });
  }
}
