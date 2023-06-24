import 'package:flutter/material.dart';
import 'package:smart_shopping_list/main.dart';
import 'package:smart_shopping_list/models/item_state.dart';

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

  void _delete(ShoppingListItem product) {
    MyApp.shoppingList.remove(product);

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
            Text("Added"),
          ],
        );
      case ItemState.MAYBE_EMPTY:
        return const Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(Icons.question_mark),
            Text("Maybe\nempty"),
          ],
        );
      default:
        return const Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(Icons.disabled_by_default),
            Text("Empty"),
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
            IconButton(
              icon: const Icon(Icons.close),
              onPressed: () => _delete(widget.shoppingListItem),
            ),
            IconButton(
              icon: const Icon(Icons.check),
              onPressed: _addSuggestion,
            ),
          ],
        );
      default:
        return ButtonBar(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () => _delete(widget.shoppingListItem),
            ),
          ],
        );
    }
  }

  Color _tileColor() {
    switch (widget.shoppingListItem.state) {
      case ItemState.EMPTY:
        return const Color.fromARGB(178, 141, 25, 7);
      case ItemState.MAYBE_EMPTY:
        return const Color.fromRGBO(228, 130, 3, 0.575);
      default:
        return const Color.fromARGB(142, 33, 149, 243);
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
                leading: _icon()),
          )
        ],
      ),
    );
  }
}
