import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:grocery_manager/services/database.dart';

import '../constants/paths.dart';
import '../constants/routes.dart';
import '../models/item.dart';
import '../pages/dashboard/maintenance/registeritem.dart';
import '../constants/entryMode.dart';

class AllItemListTile extends StatefulWidget {
  const AllItemListTile({Key? key, required this.id, required this.itemModel}) : super(key: key);

  final String id;
  final ItemModel itemModel;

  @override
  _AllItemListTileState createState() => _AllItemListTileState();
}

class _AllItemListTileState extends State<AllItemListTile> {

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
                ItemModel.fieldAmount : widget.itemModel.amount + 1,
                ItemModel.fieldTag : ItemModel.getTag(amount: widget.itemModel.amount + 1, threshold: widget.itemModel.threshold)
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
                    ItemModel.fieldAmount : widget.itemModel.amount - 1,
                    ItemModel.fieldTag : ItemModel.getTag(amount: widget.itemModel.amount - 1, threshold: widget.itemModel.threshold)
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
