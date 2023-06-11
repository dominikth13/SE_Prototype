import 'package:flutter/material.dart';
import 'package:smart_shopping_list/models/item_state.dart';

import '../models/shopping_list_item.dart';

class ShoppingListItemWidget extends StatefulWidget {
  final ShoppingListItem shoppingListItem;
  final Function(ShoppingListItem product) onPressDelete;

  const ShoppingListItemWidget(this.shoppingListItem,
      {super.key, required this.onPressDelete});

  @override
  State<StatefulWidget> createState() => _ShoppingListItemWidgetState();
}

class _ShoppingListItemWidgetState extends State<ShoppingListItemWidget> {
  Color _tileColor() {
    switch (widget.shoppingListItem.state) {
      case ItemState.EMPTY:
        return Color.fromARGB(178, 141, 25, 7);
      default:
        return Color.fromARGB(142, 33, 149, 243);
    }
  }

  Color _textColor() {
    switch (widget.shoppingListItem.state) {
      case ItemState.EMPTY:
        return Colors.white;
      default:
        return Colors.black;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Row(
        children: <Widget>[
          Expanded(
            child: ListTile(
              title: Text(widget.shoppingListItem.name),
              subtitle: Text(widget.shoppingListItem.brand),
              tileColor: _tileColor(),
              textColor: _textColor(),
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(5),
                      topRight: Radius.circular(5),
                      bottomRight: Radius.circular(5),
                      bottomLeft: Radius.circular(5))),
              trailing: IconButton(
                icon: const Icon(Icons.delete),
                onPressed: () => widget.onPressDelete(widget.shoppingListItem),
              ),
            ),
          )
        ],
      ),
    );
  }
}
