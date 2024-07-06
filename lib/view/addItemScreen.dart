import 'dart:math';

import 'package:flutter/material.dart';
import 'package:my_app/model/itemClass.dart';
import 'package:my_app/viewmodel/itemViewModel.dart';
import 'package:provider/provider.dart';

class AddItemScreen extends StatefulWidget {
  final String type;
  final int index;
  final ItemClass? item;
  const AddItemScreen(
      {super.key, required this.type, required this.index, this.item});

  @override
  State<AddItemScreen> createState() => _AddItemScreenState();
}

class _AddItemScreenState extends State<AddItemScreen> {
  String title = '';
  TextEditingController nameController = TextEditingController();
  TextEditingController descController = TextEditingController();
  @override
  void initState() {
    super.initState();
    if (widget.type == 'add') {
      title = 'Add Item';
    } else {
      title = 'Update Item';
      nameController.text = widget.item!.itemName!;
      descController.text = widget.item!.itemDesc!;
    }
  }

  @override
  void dispose() {
    super.dispose();
    nameController.dispose();
    descController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue[900],
        title: Text(
          title,
          style: const TextStyle(color: Colors.white),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  'Name',
                  style: TextStyle(fontSize: 17),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(color: Colors.black12)),
                    child: TextField(
                      controller: nameController,
                      decoration: const InputDecoration(
                          isDense: true,
                          hintText: 'Name',
                          disabledBorder: InputBorder.none,
                          border: InputBorder.none),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 15,
            ),
            const Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  'Description',
                  style: TextStyle(fontSize: 17),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(color: Colors.black12)),
                    child: TextField(
                      controller: descController,
                      maxLines: 4,
                      decoration: const InputDecoration(
                          hintText: 'Description',
                          isDense: true,
                          disabledBorder: InputBorder.none,
                          border: InputBorder.none),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 30,
            ),
            Row(
              children: [
                Expanded(
                  child: Consumer<ItemViewModel>(
                    builder: (BuildContext context, value, Widget? child) {
                      return InkWell(
                        onTap: () {
                          if (widget.type == 'add') {
                            ItemClass item = ItemClass();
                            item.itemName = nameController.text;
                            item.itemDesc = descController.text;
                            item.itemId = Random().nextInt(10000);
                            value.addItemToList(item);
                            Navigator.pop(context);
                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text('Item Added...')));
                          } else {
                            ItemClass item = ItemClass();
                            item.itemName = nameController.text;
                            item.itemDesc = descController.text;
                            value.editItem(widget.index, item);
                            Navigator.pop(context);
                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text('Item Updated...')));
                          }
                        },
                        child: Container(
                          height: 45,
                          padding: const EdgeInsets.all(5),
                          decoration: BoxDecoration(
                              color: Colors.blue[900],
                              borderRadius: BorderRadius.circular(5)),
                          child: Center(
                            child: Text(
                              (widget.type == 'add') ? 'Add' : 'Update',
                              style: const TextStyle(
                                  color: Colors.white, fontSize: 16),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
