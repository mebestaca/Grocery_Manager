import 'package:flutter/material.dart';
import 'package:grocery_manager/pages/authentication/register.dart';

import 'login.dart';

class PageToggler extends StatefulWidget {
  const PageToggler({Key? key}) : super(key: key);

  @override
  _PageTogglerState createState() => _PageTogglerState();
}

class _PageTogglerState extends State<PageToggler> {
  bool toggleView = true;

  void toggle(){
    setState(() {
      toggleView = !toggleView;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (toggleView) {
      return Login(toggleView: toggle);
    }
    else{
      return Register(toggleView: toggle);
    }
  }
}
