import 'package:flutter/material.dart';
import 'package:smart_shopping_list/models/inventory_filter.dart';
import 'package:smart_shopping_list/models/inventory_item.dart';
import 'package:smart_shopping_list/widgets/inventory_item_widget.dart';
import 'package:smart_shopping_list/widgets/inventory_overview_item_widget.dart';

import '../main.dart';

class InventoryWidget extends StatefulWidget {
  // Could be FRIDGE, UTILITY_ROOM,
  final InventoryFilter filter;
  final Function() onClickGoBack;
  const InventoryWidget(
      {super.key, required this.filter, required this.onClickGoBack});

  @override
  State<StatefulWidget> createState() => _InventoryWidgetState();
}

class _InventoryWidgetState extends State<InventoryWidget> {
  List<InventoryItem> _itemsRendered = [];

  @override
  void initState() {
    super.initState();
    _itemsRendered = _filteredList();
    _onChangeItemsRendered(null);
  }

  List<InventoryItem> _filteredList() {
    List<InventoryItem> items = List.from(MyApp.inventory);
    items.removeWhere((item) => !item.storageLocation.equals(widget.filter));
    return items;
  }

  void _onChangeSearchBar(query) {
    if (query == "") {
      _itemsRendered = _filteredList();
    } else {
      _itemsRendered = _filteredList();
      _itemsRendered.retainWhere((element) =>
          element.product.name.contains(query) ||
          element.product.brand.contains(query));
    }

    _onChangeItemsRendered(null);
  }

  void _onChangeItemsRendered(InventoryItem? deleteMe) {
    if (deleteMe != null) {
      MyApp.inventory.remove(deleteMe);
      _itemsRendered = _filteredList();
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
        ListTile(
          title: Text(widget.filter.displayName),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(5),
              topRight: Radius.circular(5),
              bottomRight: Radius.circular(5),
              bottomLeft: Radius.circular(5),
            ),
          ),
          leading: const Icon(Icons.navigate_before),
          onTap: widget.onClickGoBack,
        ),
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
