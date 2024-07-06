import 'package:flutter/material.dart';

import '../model/itemClass.dart';

class ItemViewModel extends ChangeNotifier {
  List<ItemClass> mainList = [];

  addItemToList(ItemClass item) {
    mainList.add(item);
    notifyListeners();
  }

  removeItem(int index) {
    mainList.removeAt(index);
    notifyListeners();
  }

  editItem(int index, ItemClass item) {
    mainList[index].itemName = item.itemName;
    mainList[index].itemDesc = item.itemDesc;
    notifyListeners();
  }
}
