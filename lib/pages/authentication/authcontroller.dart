import 'package:flutter/material.dart';
import 'package:grocery_manager/pages/authentication/pagetoggler.dart';
import 'package:grocery_manager/pages/dashboard/dashboard.dart';
import 'package:provider/provider.dart';
import '../../models/user.dart';

class AuthController extends StatefulWidget {
  const AuthController({Key? key}) : super(key: key);

  @override
  _AuthControllerState createState() => _AuthControllerState();
}

class _AuthControllerState extends State<AuthController> {
  @override
  Widget build(BuildContext context) {

    final loginInfo = Provider.of<UserModel?>(context);

    if (loginInfo == null) {
      return const PageToggler();
    }
    else{
      return const Dashboard();
    }
  }
}
