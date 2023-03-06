import 'package:flutter/material.dart';
import 'package:grocery_manager/pages/dashboard/items/items.dart';
import 'package:grocery_manager/pages/dashboard/lowitems/shoppingList.dart';
import 'package:grocery_manager/pages/dashboard/maintenance/maintenance.dart';
import 'package:grocery_manager/services/authentication.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {

  int _currentIndex = 0;

  final List<Widget> _widgetList = <Widget>[
    const ShoppingList(),
    const Items(),
    const Maintenance(),
  ];

  final List<String> _widgetTitles = [
    "Shopping List",
    "All Items",
    "Manage",
  ];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_widgetTitles[_currentIndex]),
        actions: [
          IconButton(
              onPressed: () async {
                await AuthenticationService().signOut();
              },
              icon: const Icon(Icons.logout_sharp )
          )
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
                decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage("assets/grocery_manager_drawer.jpg"),
                        fit: BoxFit.fill,
                        alignment: Alignment.center
                    )
                ),
                child: Container(
                  alignment: Alignment.bottomLeft,
                  child: Text("Grocery Manager",
                    style: TextStyle(
                        fontSize: 30.0,
                        color: Theme.of(context).canvasColor
                    ),
                  ),
                )
            ),
            ListTile(
              title: Text(_widgetTitles[0]),
              leading: const Icon(Icons.checklist_rounded),
              onTap: () {
                updatePage(0);
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: Text(_widgetTitles[1]),
              leading: const Icon(Icons.category_rounded),
              onTap: () {
                updatePage(1);
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: Text(_widgetTitles[2]),
              leading: const Icon(Icons.build_rounded),
              onTap: () {
                updatePage(2);
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
      body: Container(
        child:_widgetList[_currentIndex],
      )
    );
  }

  void updatePage(int index) {
    setState(() {
      _currentIndex = index;
    });
  }
}
