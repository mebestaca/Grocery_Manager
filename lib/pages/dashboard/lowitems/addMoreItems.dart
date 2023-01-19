import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:grocery_manager/services/extensions.dart';
import 'package:grocery_manager/shared/listTileAddMoreItems.dart';

import '../../../constants/entryMode.dart';
import '../../../constants/paths.dart';
import '../../../constants/routes.dart';
import '../../../models/item.dart';
import '../../../services/database.dart';
import '../../../shared/sharedDecoration.dart';
import '../maintenance/registeritem.dart';

class AddMoreItems extends StatefulWidget {
  const AddMoreItems({Key? key}) : super(key: key);

  @override
  _AddMoreItemsState createState() => _AddMoreItemsState();
}

class _AddMoreItemsState extends State<AddMoreItems> {

  String _itemName = "";

  final _nameController = TextEditingController();
  final _globalKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Column(
        children: [
          Container(
            color: Theme.of(context).canvasColor,
            child: Form(
              key: _globalKey,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: TextFormField(
                  controller: _nameController,
                  decoration: fieldStyle.copyWith(
                      hintText: "search",
                      labelText: "search",
                      suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              _itemName = "";
                              _nameController.clear();
                            });
                          },
                          icon: _itemName.isNotEmpty ? const Icon(Icons.cancel_outlined) : Container()
                      )
                  ),
                  onChanged: (val) {
                    setState(() {
                      _itemName = val;
                    });
                  },
                ),
              ),
            ),
          ),
          Flexible(
            child: StreamBuilder<QuerySnapshot<ItemModel>>(
                stream: DatabaseService(path: Paths.items).getItemModelReference().
                queryBy(ItemQueryModes.itemName, queryText: _itemName).snapshots(),
                builder: (context, itemList) {
                  if (itemList.hasData) {

                    final data = itemList.requireData;

                    if (data.size > 0) {
                      return ListView.builder(
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          itemCount: data.size,
                          itemBuilder: (context, index) {
                            return AddMoreItemListTile(
                              itemModel: ItemModel(
                                name: data.docs[index][ItemModel.fieldName],
                                amount: data.docs[index][ItemModel.fieldAmount],
                                threshold: data.docs[index][ItemModel.fieldThreshold],
                                uom: data.docs[index][ItemModel.fieldUOM],
                                tag: data.docs[index][ItemModel.fieldTag],
                              ),
                              id: data.docs[index].id,
                            );
                          }
                      );
                    }
                    else{
                      return const Center(
                        child: Text("No Items Found"),
                      );
                    }
                  }
                  else{
                    return Container();
                  }
                }),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, Routes.sharedScaffold,
              arguments: {
                "widget" : RegisterItem(
                  itemModel: ItemModel(
                      uom: "LB"
                  ),
                  id: "",
                  mode: EntryMode.add,
                ),
                "title" : "Add Item"
              }
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

