import 'package:flutter/material.dart';

class MyAppbar extends StatefulWidget implements PreferredSizeWidget{
  _MyAppbar createState(){
    return _MyAppbar();
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _MyAppbar extends State<MyAppbar> {
  Widget build(BuildContext context) {
    return AppBar();
  }
}