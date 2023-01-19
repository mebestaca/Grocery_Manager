import 'package:flutter/material.dart';
import 'package:grocery_manager/pages/dashboard/lowitems/addMoreItems.dart';

import 'lowitems.dart';

class ShoppingList extends StatefulWidget {
  const ShoppingList({Key? key}) : super(key: key);

  @override
  _ShoppingListState createState() => _ShoppingListState();
}

class _ShoppingListState extends State<ShoppingList> {

  int _selectedIndex = 0;

  static final List _pageList = [
    const LowItems(),
    const AddMoreItems(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
        Container(
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/grocery_manager_wallpaper.jpg"),
                  fit: BoxFit.fitHeight,
                  alignment: Alignment.center
              )
          ),
          child: _pageList[_selectedIndex],
        ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (int index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
              label: "Buy List",
              icon: Icon(Icons.article_outlined)
          ),
          BottomNavigationBarItem(
              label: "Add More Items",
              icon: Icon(Icons.add_card)
          ),
        ],
      ),
    );
  }
}
