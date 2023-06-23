import 'package:flutter/material.dart';
import 'package:smart_shopping_list/models/inventory_item.dart';
import 'package:smart_shopping_list/widgets/inventory_item_widget.dart';

import '../main.dart';

class InventoryWidget extends StatefulWidget {
  const InventoryWidget({super.key});

  @override
  State<StatefulWidget> createState() => _InventoryWidgetState();
}

class _InventoryWidgetState extends State<InventoryWidget> {
  List<InventoryItem> _itemsRendered = List.from(MyApp.inventory);

  void _onChangeSearchBar(query) {
    if (query == "") {
      _itemsRendered = List.from(MyApp.inventory);
    } else {
      _itemsRendered = List.from(MyApp.inventory);
      _itemsRendered.retainWhere((element) =>
          element.name.contains(query) || element.brand.contains(query));
    }

    setState(() {
      _itemsRendered;
    });
  }

  List<InventoryItem> _sortedItems() {
    _itemsRendered.forEach((element) {
      print(element.name);
    });
    //TODO change sorting
    _itemsRendered.sort();
    _itemsRendered.forEach((element) {
      print(element.name);
    });
    return _itemsRendered;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        SearchBar(
          onChanged: _onChangeSearchBar,
        ),
        Expanded(
          child: ListView(
              children: _sortedItems()
                  .map((item) => InventoryItemWidget(item))
                  .toList()),
        ),
      ],
    );
  }
}
