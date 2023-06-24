import 'package:flutter/material.dart';
import 'package:rainbow_color/rainbow_color.dart';
import 'package:smart_shopping_list/main.dart';
import 'package:smart_shopping_list/models/inventory_item.dart';
import 'package:smart_shopping_list/models/item_state.dart';
import 'package:smart_shopping_list/models/product.dart';
import 'package:smart_shopping_list/models/shopping_list_item.dart';

import '../models/unit.dart';

class InventoryItemWidget extends StatefulWidget {
  final InventoryItem inventoryItem;
  final Function(InventoryItem? deleteMe) onChangeItem;

  const InventoryItemWidget(this.inventoryItem,
      {super.key, required this.onChangeItem});

  @override
  State<StatefulWidget> createState() => _InventoryItemWidgetState();
}

class _InventoryItemWidgetState extends State<InventoryItemWidget> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _brandController = TextEditingController();
  String _unitValue = "";
  final TextEditingController _sizeController = TextEditingController();
  final TextEditingController _remainingController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _nameController.text = widget.inventoryItem.product.name;
    _brandController.text = widget.inventoryItem.product.brand;
    _unitValue = widget.inventoryItem.product.unit.code;
    _sizeController.text = widget.inventoryItem.product.size.toString();
    _remainingController.text =
        widget.inventoryItem.getRemainingSize().toString();
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    _nameController.dispose();
    _brandController.dispose();
    _sizeController.dispose();
    _remainingController.dispose();
    super.dispose();
  }

  void _changeValues() {
    widget.inventoryItem.product.name = _nameController.text;
    widget.inventoryItem.product.brand = _brandController.text;
    widget.inventoryItem.product.unit = Unit.findByCode(_unitValue)!;
    widget.inventoryItem.product.size = double.parse(_sizeController.text);
    widget.inventoryItem
        .setRemainingAmountBySize(double.parse(_remainingController.text));
    if (widget.inventoryItem.remainingAmount == 0) {
      Product product = widget.inventoryItem.product;
      MyApp.shoppingList.add(ShoppingListItem(product.name, product.brand,
          product.unit, product.size, ItemState.EMPTY));
      widget.onChangeItem(widget.inventoryItem);
    }
    Navigator.pop(context);

    setState(() {
      widget.inventoryItem;
    });
    widget.onChangeItem(null);
  }

  List<DropdownMenuItem<String>> _units() {
    return Unit.values
        .map((e) => DropdownMenuItem<String>(
              value: e.code,
              child: Text(e.code),
            ))
        .toList();
  }

  void _onChangeUnit(code) {
    setState(() {
      _unitValue = code;
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
            Expanded(
              child: TextField(
                controller: _brandController,
                decoration: const InputDecoration(
                  constraints: BoxConstraints(maxWidth: 100),
                  border: OutlineInputBorder(),
                  labelText: "Brand",
                ),
              ),
            ),
            Expanded(
              child: SizedBox(
                width: 100,
                child: DropdownButtonFormField<String>(
                  decoration: const InputDecoration(
                    constraints: BoxConstraints(maxWidth: 100),
                    border: OutlineInputBorder(),
                    labelText: "Unit",
                  ),
                  items: _units(),
                  value: _unitValue,
                  onChanged: _onChangeUnit,
                  onSaved: _onChangeUnit,
                ),
              ),
            ),
            Expanded(
              child: TextField(
                controller: _sizeController,
                decoration: const InputDecoration(
                  constraints: BoxConstraints(maxWidth: 100),
                  border: OutlineInputBorder(),
                  labelText: "Size",
                ),
              ),
            ),
            Expanded(
              child: TextField(
                controller: _remainingController,
                decoration: const InputDecoration(
                  constraints: BoxConstraints(maxWidth: 100),
                  border: OutlineInputBorder(),
                  labelText: "Remaining",
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

  Color _tileColor() {
    var rb = Rainbow(spectrum: [
      const Color.fromARGB(255, 22, 184, 1),
      const Color.fromARGB(255, 161, 197, 1),
      const Color.fromARGB(255, 218, 185, 1),
      const Color.fromARGB(255, 252, 169, 2),
      const Color.fromARGB(255, 230, 92, 0)
    ], rangeStart: 1.0, rangeEnd: 0.0);

    return rb[widget.inventoryItem.remainingAmount];
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Row(
        children: <Widget>[
          Expanded(
            child: ListTile(
              title: Text(widget.inventoryItem.product.name),
              subtitle: Text(widget.inventoryItem.product.brand),
              tileColor: _tileColor(), //TODO
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
                    icon: const Icon(Icons.edit),
                    label: const Text(""),
                  ),
                ],
              ),
              leading: SizedBox(
                  width: 50,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(widget.inventoryItem.getRemainingSize().toString()),
                      Text(
                        widget.inventoryItem.product.unit.getOutputName(),
                        style: const TextStyle(
                            fontSize: 12,
                            color: Color.fromARGB(255, 211, 210, 210)),
                      ),
                    ],
                  )),
            ),
          ),
        ],
      ),
    );
  }
}
