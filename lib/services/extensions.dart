import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:grocery_manager/models/item.dart';

enum ItemQueryModes {
  low,
  itemName
}

extension ItemQuery on Query<ItemModel> {
  Query<ItemModel> queryBy(ItemQueryModes query, {String queryText=""}){
    switch (query) {
      case ItemQueryModes.low :
        return where(ItemModel.fieldName,  isGreaterThanOrEqualTo: queryText, isLessThanOrEqualTo: "${queryText}z").
        where(ItemModel.fieldTag, isEqualTo: ItemModel.tagLow).
        orderBy(ItemModel.fieldName, descending: false);
      case ItemQueryModes.itemName :
        return where(ItemModel.fieldName,  isGreaterThanOrEqualTo: queryText, isLessThanOrEqualTo: "${queryText}z").
        orderBy(ItemModel.fieldName, descending: false);
    }

  }
}