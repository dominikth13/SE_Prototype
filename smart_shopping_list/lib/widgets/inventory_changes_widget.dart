import 'package:flutter/widgets.dart';
import 'package:smart_shopping_list/models/inventory_item.dart';

import 'inventory_item_widget.dart';

class InventoryChangesWidget extends StatefulWidget {
  final List<InventoryItem> itemsToAdd;

  const InventoryChangesWidget({super.key, required this.itemsToAdd});

  @override
  State<StatefulWidget> createState() => _InventoryChangesWidgetState();
}

class _InventoryChangesWidgetState extends State<InventoryChangesWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Expanded(
          child: ListView(
              children: widget.itemsToAdd
                  .map((item) => InventoryItemWidget(item))
                  .toList()),
        ),
      ],
    );
  }
}
