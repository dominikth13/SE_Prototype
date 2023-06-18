import 'package:flutter/material.dart';
import 'package:smart_shopping_list/models/item_state.dart';
import 'package:smart_shopping_list/widgets/shopping_list_item_widget.dart';

import '../models/shopping_list_item.dart';
import '../main.dart';

class ShoppingListWidget extends StatefulWidget {
  const ShoppingListWidget({super.key});

  @override
  State<StatefulWidget> createState() => _ShoppingListWidgetState();
}

class _ShoppingListWidgetState extends State<ShoppingListWidget> {
  void _delete(ShoppingListItem product) {
    MyApp.shoppingList.remove(product);

    setState(() {
      MyApp.shoppingList;
    });
  }

  final TextEditingController _addProductNameController =
      TextEditingController();

  void _addProduct(String name) {
    //TODO implement
    String brand = "Example Brand";
    MyApp.shoppingList
        .add(ShoppingListItem(name, brand, ItemState.CUSTOM, true));

    setState(() {
      MyApp.shoppingList;
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
              children: MyApp.shoppingList
                  .map((item) => ShoppingListItemWidget(
                        item,
                        onPressDelete: (ShoppingListItem product) =>
                            _delete(product),
                      ))
                  .toList()),
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
