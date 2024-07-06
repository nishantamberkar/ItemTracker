import 'package:flutter/material.dart';
import 'package:my_app/view/addItemScreen.dart';
import 'package:my_app/viewmodel/itemViewModel.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey pkey = GlobalKey();
  Size? mysize;
  Offset? position;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => getSize());
  }

  getSize() {
    final RenderBox box = pkey.currentContext!.findRenderObject() as RenderBox;
    mysize = box.size;
    position = box.localToGlobal(Offset.zero);
    print(mysize);
    print(position);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue[900],
        title: const Text(
          'Item Tracker',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Column(
          children: [
            Container(
              key: pkey,
              height: 60,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const AddItemScreen(
                                  type: 'add',
                                  index: 0,
                                )));
                      },
                      child: Container(
                        height: 45,
                        padding: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                            color: Colors.blue[900],
                            borderRadius: BorderRadius.circular(5)),
                        child: const Center(
                          child: Text(
                            '+ Add Item',
                            style: TextStyle(color: Colors.white, fontSize: 16),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Consumer<ItemViewModel>(
              builder:
                  (BuildContext context, ItemViewModel value, Widget? child) {
                return Expanded(
                  child: (value.mainList.isEmpty)
                      ? const Center(
                          child: Text(
                          'Item Tracker Empty',
                          style: TextStyle(color: Colors.black38, fontSize: 19),
                        ))
                      : ListView.builder(
                          shrinkWrap: true,
                          itemCount: value.mainList.length,
                          itemBuilder: (context, index) {
                            return Column(
                              children: [
                                Row(
                                  children: [
                                    Expanded(
                                      child: Card(
                                        child: Container(
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10)),
                                          padding: const EdgeInsets.all(15),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Expanded(
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    const Text('Name'),
                                                    Text(
                                                      value.mainList[index]
                                                          .itemName!,
                                                      style: const TextStyle(
                                                          color:
                                                              Colors.black54),
                                                    ),
                                                    const SizedBox(
                                                      height: 5,
                                                    ),
                                                    const Text('Description'),
                                                    Text(
                                                      value.mainList[index]
                                                          .itemDesc!,
                                                      style: const TextStyle(
                                                          color:
                                                              Colors.black54),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  InkWell(
                                                    onTap: () {
                                                      value.removeItem(index);
                                                      ScaffoldMessenger.of(
                                                              context)
                                                          .showSnackBar(
                                                              const SnackBar(
                                                                  content: Text(
                                                                      'Item Deleted...')));
                                                    },
                                                    child: const Icon(
                                                      Icons.cancel,
                                                      color: Colors.red,
                                                      size: 25,
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    height: 20,
                                                  ),
                                                  InkWell(
                                                    onTap: () {
                                                      Navigator.of(context).push(
                                                          MaterialPageRoute(
                                                              builder: (context) =>
                                                                  AddItemScreen(
                                                                    type:
                                                                        'edit',
                                                                    index:
                                                                        index,
                                                                    item: value
                                                                            .mainList[
                                                                        index],
                                                                  )));
                                                    },
                                                    child: Icon(
                                                      Icons.edit_note,
                                                      color: Colors.green[900],
                                                      size: 25,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            );
                          },
                        ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
