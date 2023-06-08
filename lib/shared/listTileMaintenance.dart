import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:grocery_manager/pages/dashboard/maintenance/registeritem.dart';
import 'package:grocery_manager/services/database.dart';
import 'package:grocery_manager/constants/entryMode.dart';

import '../constants/paths.dart';
import '../constants/routes.dart';
import '../models/item.dart';

class MaintenanceListTile extends StatefulWidget {
  const MaintenanceListTile({Key? key, required this.itemModel, required this.id}) : super(key: key);

  final String id;
  final ItemModel itemModel;

  @override
  _MaintenanceListTileState createState() => _MaintenanceListTileState();
}

class _MaintenanceListTileState extends State<MaintenanceListTile> {


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 2.0),
      child: Slidable(
        key: GlobalKey(),
        endActionPane: ActionPane(
          motion: const ScrollMotion(),
          children: [
            SlidableAction(
              label: "Update",
              icon: Icons.create_rounded,
              backgroundColor: Colors.blue,
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
                label: "Delete",
                icon: Icons.delete,
                backgroundColor: Colors.red,
                onPressed: (val) async {
                  await DatabaseService(path: Paths.items).deleteEntry(widget.id);
                }
            )
          ],
        ),
        child: Container(
          color: Colors.white,
          child: ListTile(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5),
            ),
            title: Text(widget.itemModel.name,
            ),
            subtitle: Text("Remaining: ${widget.itemModel.amount.toString()} ${widget.itemModel.uom}/Threshold: ${widget.itemModel.threshold.toString()} ${widget.itemModel.uom}",
              textAlign: TextAlign.end,
            ),
          ),
        ),
      ),
    );
  }
}


