import 'package:flutter/material.dart';

import '../models/shopping_list_item.dart';

class ShoppingListItemWidget extends StatefulWidget {
  
  final ShoppingListItem shoppingListItem;

  const ShoppingListItemWidget(this.shoppingListItem, {super.key});

  @override
  State<StatefulWidget> createState() => _ShoppingListItemWidgetState();
}

class _ShoppingListItemWidgetState extends State<ShoppingListItemWidget> {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Row(
        children: <Widget>[
          ListTile(
            title: Text(widget.shoppingListItem.name),
          ),
        ],
      ),
    );
  }
}