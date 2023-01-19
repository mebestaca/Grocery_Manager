import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:grocery_manager/pages/authentication/authcontroller.dart';
import 'package:grocery_manager/pages/dashboard/dashboard.dart';
import 'package:grocery_manager/pages/dashboard/items/items.dart';
import 'package:grocery_manager/pages/dashboard/lowitems/lowitems.dart';
import 'package:grocery_manager/pages/dashboard/maintenance/maintenance.dart';
import 'package:grocery_manager/services/authentication.dart';
import 'package:grocery_manager/shared/sharedScaffold.dart';
import 'package:grocery_manager/shared/sharedThemes.dart';
import 'package:provider/provider.dart';

import 'constants/routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Grocery Observer',
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {
    return StreamProvider.value(
      initialData: null,
      value: AuthenticationService().userInfo,
      child: MaterialApp(
        theme: mainTheme,
        home: const AuthController(),
        routes: {
          Routes.lowItems : (context) => const LowItems(),
          Routes.dashboard : (context) => const Dashboard(),
          Routes.maintenance : (context) => const Maintenance(),
          Routes.allItems : (context) => const Items(),
          Routes.sharedScaffold : (context) => const SharedScaffold()
        },
      ),
    );
  }
}
