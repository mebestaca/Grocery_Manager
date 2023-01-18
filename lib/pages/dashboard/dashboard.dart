import 'package:flutter/material.dart';
import 'package:grocery_manager/pages/dashboard/items/items.dart';
import 'package:grocery_manager/pages/dashboard/lowitems/shoppingList.dart';
import 'package:grocery_manager/pages/dashboard/maintenance/maintenance.dart';
import 'package:grocery_manager/pages/dashboard/movement/movement.dart';
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
    // const Movement()
  ];

  final List<String> _widgetTitles = [
    "Shopping List",
    "All Items",
    "Maintenance",
    "Movement"
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
                decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor
                ),
                child: Text("Grocery Observer",
                  style: TextStyle(
                      fontSize: 30.0,
                      color: Theme.of(context).canvasColor
                  ),
                )
            ),
            ListTile(
              title: const Text("Shopping List"),
              leading: const Icon(Icons.checklist_rounded),
              onTap: () {
                updatePage(0);
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text("All Items"),
              leading: const Icon(Icons.category_rounded),
              onTap: () {
                updatePage(1);
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text("Maintenance"),
              leading: const Icon(Icons.build_rounded),
              onTap: () {
                updatePage(2);
                Navigator.pop(context);
              },
            ),
            /*
            ListTile(
              title: const Text("Movement"),
              onTap: () {
                updatePage(3);
                Navigator.pop(context);
              },
            ),
            */
          ],
        ),
      ),
      body: _widgetList[_currentIndex],
    );
  }

  void updatePage(int index) {
    setState(() {
      _currentIndex = index;
    });
  }
}
