import 'package:flutter/material.dart';
import 'package:smart_shopping_list/models/item_state.dart';
import 'package:smart_shopping_list/widgets/shopping_list_item_widget.dart';

import '../models/shopping_list_item.dart';

class ShoppingListWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ShoppingListWidgetState();
}

class _ShoppingListWidgetState extends State<ShoppingListWidget> {

  final List<ShoppingListItem> _products = <ShoppingListItem>[];

  final TextEditingController _addProductNameController = TextEditingController();

  void _addProduct(String name) {
    _products.add(ShoppingListItem(name, ItemState.CUSTOM, true));
    
    setState(() {
      _products;
    });
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    _addProductNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Expanded(
          child: ListView(
            children: _products.map((item) => ShoppingListItemWidget(item)).toList()
          ),
        ),
        Container(
          height: 100,
          color: Colors.blue,
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                SizedBox(
                  width: 250,
                  child: TextField(
                    controller: _addProductNameController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "Product",
                    ),
                  ),
                ),
                ElevatedButton(
                child: const Text("Add"),
                  onPressed: () {
                    _addProduct(_addProductNameController.text);
                    _addProductNameController.text = "";
                  },
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}