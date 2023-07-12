import 'package:flutter/material.dart';
import 'package:smart_shopping_list/main.dart';
import 'package:smart_shopping_list/models/inventory_item.dart';
import 'package:smart_shopping_list/models/item_state.dart';
import 'package:smart_shopping_list/models/product.dart';

import '../models/shopping_list_item.dart';

class ShoppingListItemWidget extends StatefulWidget {
  final ShoppingListItem shoppingListItem;
  final Function() onChangeItem;

  const ShoppingListItemWidget(
    this.shoppingListItem, {
    super.key,
    required this.onChangeItem,
  });

  @override
  State<StatefulWidget> createState() => _ShoppingListItemWidgetState();
}

class _ShoppingListItemWidgetState extends State<ShoppingListItemWidget> {
  void _addSuggestion() {
    widget.shoppingListItem.state = ItemState.EMPTY;

    setState(() {
      widget.shoppingListItem.state;
    });
    widget.onChangeItem();
  }

  void _removeSuggestion() {
    _delete();
    Product product = widget.shoppingListItem.product;
    MyApp.inventory.add(InventoryItem.forTesting(
        product.name, product.brand, product.unit, product.size, 0.2));
    setState(() {
      MyApp.inventory;
    });
  }

  void _delete() {
    MyApp.shoppingList.remove(widget.shoppingListItem);

    setState(() {
      MyApp.shoppingList;
    });
    widget.onChangeItem();
  }

  Column _icon() {
    switch (widget.shoppingListItem.state) {
      case ItemState.CUSTOM:
        return const Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(Icons.add_task),
            Text("Hinzugefügt"),
          ],
        );
      case ItemState.MAYBE_EMPTY:
        return const Column(
          mainAxisSize: MainAxisSize.min,
        );
      default:
        return const Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(Icons.disabled_by_default),
            Text("Leer"),
          ],
        );
    }
  }

  ButtonBar _iconButton() {
    switch (widget.shoppingListItem.state) {
      case ItemState.MAYBE_EMPTY:
        return ButtonBar(
          mainAxisSize: MainAxisSize.min,
          children: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                shape: const CircleBorder(),
                backgroundColor: Colors.red, // <-- Button color
                foregroundColor: Colors.white, // <-- Splash color
              ),
              child: const Icon(Icons.remove_circle_outline),
              onPressed: _removeSuggestion,
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                shape: const CircleBorder(),
                backgroundColor: Colors.blue, // <-- Button color
                foregroundColor: Colors.white, // <-- Splash color
              ),
              child: const Icon(Icons.add_shopping_cart),
              onPressed: _addSuggestion,
            ),
          ],
        );
      default:
        return ButtonBar(
          mainAxisSize: MainAxisSize.min,
          children: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                shape: const CircleBorder(),
                backgroundColor: Colors.red, // <-- Button color
                foregroundColor: Colors.white, // <-- Splash color
              ),
              child: const Icon(Icons.delete_forever),
              onPressed: _delete,
            ),
          ],
        );
    }
  }

  Color _tileColor() {
    return const Color.fromARGB(142, 33, 149, 243);
  }

  Color _textColor() {
    return Colors.white;
  }

  ListTile _tile() {
    if (widget.shoppingListItem.state == ItemState.MAYBE_EMPTY) {
      return ListTile(
        title: Text(widget.shoppingListItem.product.name),
        subtitle: Text(widget.shoppingListItem.product.brand),
        tileColor: _tileColor(),
        textColor: _textColor(),
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(5),
                topRight: Radius.circular(5),
                bottomRight: Radius.circular(5),
                bottomLeft: Radius.circular(5))),
        trailing: _iconButton(),
      );
    }
    return ListTile(
      title: Text(widget.shoppingListItem.product.name),
      subtitle: Text(widget.shoppingListItem.product.brand),
      tileColor: _tileColor(),
      textColor: _textColor(),
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(5),
              topRight: Radius.circular(5),
              bottomRight: Radius.circular(5),
              bottomLeft: Radius.circular(5))),
      trailing: _iconButton(),
      leading: _icon(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Row(
        children: <Widget>[
          Expanded(
            child: _tile(),
          )
        ],
      ),
    );
  }
}
