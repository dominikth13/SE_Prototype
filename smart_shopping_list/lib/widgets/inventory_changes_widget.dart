import 'package:flutter/material.dart';
import '../main.dart';
import 'package:smart_shopping_list/models/inventory_item.dart';

import 'inventory_item_widget.dart';

class InventoryChangesWidget extends StatefulWidget {
  List<InventoryItem> itemsToAdd;
  final Function() onPressAbort;
  final Function() proceedToInventory;

  InventoryChangesWidget(
      {super.key,
      required this.itemsToAdd,
      required this.onPressAbort,
      required this.proceedToInventory});

  @override
  State<StatefulWidget> createState() => _InventoryChangesWidgetState();
}

class _InventoryChangesWidgetState extends State<InventoryChangesWidget> {
  @override
  void initState() {
    super.initState();
  }

  void _addProducts() {
    MyApp.inventory.addAll(widget.itemsToAdd);

    widget.proceedToInventory();
    setState(() {
      MyApp.inventory;
    });
  }

  void _onChangeItems() {
    widget.itemsToAdd = _sortedItems();

    setState(() {
      widget.itemsToAdd;
    });
  }

  List<InventoryItem> _sortedItems() {
    widget.itemsToAdd.sort();
    return widget.itemsToAdd;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Expanded(
          flex: 10,
          child: ListView(
              children: widget.itemsToAdd
                  .map((item) => InventoryItemWidget(
                        item,
                        onChangeItem: _onChangeItems,
                      ))
                  .toList()),
        ),
        Expanded(
          flex: 2,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              ElevatedButton.icon(
                onPressed: widget.onPressAbort,
                icon: const Icon(Icons.refresh),
                label: const Text("Abort"),
              ),
              ElevatedButton.icon(
                onPressed: _addProducts,
                icon: const Icon(Icons.check),
                label: const Text("Add Products To Inventory"),
              )
            ],
          ),
        ),
      ],
    );
  }
}
