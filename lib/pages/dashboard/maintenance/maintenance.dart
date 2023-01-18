import 'package:flutter/material.dart';
import 'package:grocery_manager/models/item.dart';
import 'package:grocery_manager/pages/dashboard/maintenance/registeritem.dart';
import 'package:grocery_manager/pages/dashboard/maintenance/removeitem.dart';
import 'package:grocery_manager/constants/entryMode.dart';

class Maintenance extends StatefulWidget {
  const Maintenance({Key? key}) : super(key: key);

  @override
  _MaintenanceState createState() => _MaintenanceState();
}

class _MaintenanceState extends State<Maintenance> {

  int _selectedIndex = 0;

  static final List _pageList = [
    RegisterItem(
      id: "",
      itemModel: ItemModel(),
      mode: EntryMode.add,
    ),
    const RemoveItem(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pageList[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (int index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
              label: "New Item",
              icon: Icon(Icons.add_shopping_cart)
          ),
          BottomNavigationBarItem(
              label: "Edit/Delete Item",
              icon: Icon(Icons.delete)
          ),

        ],
      ),
    );
  }
}
