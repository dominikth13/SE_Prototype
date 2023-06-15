import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:smart_shopping_list/models/inventory_item.dart';

class InventoryItemWidget extends StatefulWidget {
  final InventoryItem inventoryItem;

  const InventoryItemWidget(this.inventoryItem, {super.key});

  @override
  State<StatefulWidget> createState() => _InventoryItemWidgetState();
}

class _InventoryItemWidgetState extends State<InventoryItemWidget> {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Row(
        children: <Widget>[
          Expanded(
            child: ListTile(
              title: Text(widget.inventoryItem.name),
              subtitle: Text(widget.inventoryItem.brand),
              tileColor: Colors.blue, //TODO
              textColor: Colors.white, //TODO
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(5),
                      topRight: Radius.circular(5),
                      bottomRight: Radius.circular(5),
                      bottomLeft: Radius.circular(5))),
              trailing: Icon(Icons.abc), //TODO
              leading: Icon(Icons.abc), //TODO
            ),
          ),
        ],
      ),
    );
  }
}
