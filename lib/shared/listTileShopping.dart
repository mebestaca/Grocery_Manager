import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import '../constants/entryMode.dart';
import '../constants/paths.dart';
import '../constants/routes.dart';
import '../models/item.dart';
import '../pages/dashboard/maintenance/registeritem.dart';
import '../services/database.dart';

class ShoppingListTile extends StatefulWidget {
  const ShoppingListTile({Key? key, required this.id, required this.itemModel}) : super(key: key);

  final String id;
  final ItemModel itemModel;

  @override
  _ShoppingListTileState createState() => _ShoppingListTileState();
}

class _ShoppingListTileState extends State<ShoppingListTile> {

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2.0, horizontal: 10.0),
      child: Slidable(
        key: GlobalKey(),
        endActionPane: ActionPane(
          motion: const ScrollMotion(),
          children: [
            SlidableAction(
              label: "Update",
              icon: Icons.create_rounded,
              foregroundColor: Theme.of(context).primaryColor,
              backgroundColor: Theme.of(context).canvasColor,
              onPressed: (val) {

                Navigator.pushNamed(context, Routes.sharedScaffold,
                    arguments: {
                      "widget" : RegisterItem(
                        itemModel:widget.itemModel,
                        id: widget.id,
                        mode: EntryMode.edit,
                      ),
                      "title" : "Edit Item"
                    }
                );
              },
            ),
            SlidableAction(
              label: "Dismiss",
              icon: Icons.cancel_presentation,
              foregroundColor: Theme.of(context).primaryColor,
              backgroundColor: Theme.of(context).canvasColor,
              onPressed: (val) async {
                Map<String, dynamic> data = {
                  ItemModel.fieldTag : ""
                };

                await DatabaseService(path: Paths.items).updateEntry(data, widget.id);
              },
            ),
          ],
        ),
        child: ListTile(
          tileColor: Theme.of(context).primaryColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5),
          ),
          title: Text(widget.itemModel.name,
            style: TextStyle(
                color: Theme.of(context).canvasColor
            ),
          ),
          trailing: IconButton(
            onPressed: () async {

              Map<String, dynamic> data = {
                ItemModel.fieldAmount : widget.itemModel.amount + 1
              };

              await DatabaseService(path: Paths.items).updateEntry(data, widget.id);
            },
            icon: Icon(Icons.add,
              color: Theme.of(context).canvasColor,
            ),
          ),
          leading: IconButton(
              onPressed: () async {
                if (widget.itemModel.amount > 0) {
                  Map<String, dynamic> data = {
                    ItemModel.fieldAmount : widget.itemModel.amount - 1
                  };
                  await DatabaseService(path: Paths.items).updateEntry(data, widget.id);
                }
              },
              icon: Icon(Icons.remove,
                color: Theme.of(context).canvasColor,
              )
          ),
          subtitle: Text("Remaining: ${widget.itemModel.amount.toString()} ${widget.itemModel.uom}/Threshold: ${widget.itemModel.threshold.toString()} ${widget.itemModel.uom}",
            textAlign: TextAlign.end,
            style: TextStyle(
                color: Theme.of(context).canvasColor
            ),
          ),
        ),
      ),
    );
  }
}
