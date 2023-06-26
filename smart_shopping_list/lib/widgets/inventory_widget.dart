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
  List<InventoryItem> _itemsRendered = [];

  @override
  void initState() {
    super.initState();
    _itemsRendered = List.from(MyApp.inventory);
    _onChangeItemsRendered(null);
  }

  void _onChangeSearchBar(query) {
    if (query == "") {
      _itemsRendered = List.from(MyApp.inventory);
    } else {
      _itemsRendered = List.from(MyApp.inventory);
      _itemsRendered.retainWhere((element) =>
          element.product.name.contains(query) ||
          element.product.brand.contains(query));
    }

    _onChangeItemsRendered(null);
  }

  void _onChangeItemsRendered(InventoryItem? deleteMe) {
    if (deleteMe != null) {
      MyApp.inventory.remove(deleteMe);
      _itemsRendered = List.from(MyApp.inventory);
    }
    _itemsRendered = _sortedItems();

    setState(() {
      _itemsRendered;
    });
  }

  List<InventoryItem> _sortedItems() {
    _itemsRendered.sort();
    return _itemsRendered;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        SearchBar(
          onChanged: _onChangeSearchBar,
          hintText: "Produktname, Marke etc.",
        ),
        Expanded(
          child: ListView(
              children: _itemsRendered
                  .map((item) => InventoryItemWidget(
                        item,
                        onChangeItem: _onChangeItemsRendered,
                      ))
                  .toList()),
        ),
      ],
    );
  }
}
