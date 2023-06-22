import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:smart_shopping_list/models/inventory_item.dart';

import '../models/unit.dart';

class InventoryItemWidget extends StatefulWidget {
  final InventoryItem inventoryItem;

  const InventoryItemWidget(this.inventoryItem, {super.key});

  @override
  State<StatefulWidget> createState() => _InventoryItemWidgetState();
}

class _InventoryItemWidgetState extends State<InventoryItemWidget> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _brandController = TextEditingController();
  final TextEditingController _unitController = TextEditingController();
  final TextEditingController _sizeController = TextEditingController();
  final TextEditingController _remainingController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _nameController.text = widget.inventoryItem.name;
    _brandController.text = widget.inventoryItem.brand;
    _unitController.text = widget.inventoryItem.unit.code;
    _sizeController.text = widget.inventoryItem.size.toString();
    _remainingController.text = widget.inventoryItem.remainingAmount.toString();
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    _nameController.dispose();
    _brandController.dispose();
    _unitController.dispose();
    _sizeController.dispose();
    _remainingController.dispose();
    super.dispose();
  }

  void _changeValues() {
    widget.inventoryItem.name = _nameController.text;
    widget.inventoryItem.brand = _brandController.text;
    widget.inventoryItem.unit = Unit.findByCode(_unitController.text)!;
    widget.inventoryItem.size = double.parse(_sizeController.text);
    widget.inventoryItem.remainingAmount =
        double.parse(_remainingController.text);
    Navigator.pop(context);

    setState(() {
      widget.inventoryItem;
    });
  }

  void _showEditDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: Column(
          children: [
            Expanded(
              child: TextField(
                controller: _nameController,
                decoration: const InputDecoration(
                  constraints: BoxConstraints(maxWidth: 100),
                  border: OutlineInputBorder(),
                  labelText: "Name",
                ),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: _changeValues,
            child: const Text('Approve'),
          ),
        ],
      ),
    );
  }

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
              trailing: ButtonBar(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ElevatedButton.icon(
                    onPressed: _showEditDialog,
                    icon: Icon(Icons.edit),
                    label: Text(""),
                  ),
                ],
              ),
              leading: Icon(Icons.abc), //TODO
            ),
          ),
        ],
      ),
    );
  }
}
