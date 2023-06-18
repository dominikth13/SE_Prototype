import 'package:flutter/material.dart';
import 'package:smart_shopping_list/models/inventory_item.dart';
import 'package:smart_shopping_list/widgets/camera_widget.dart';
import 'package:smart_shopping_list/widgets/inventory_item_widget.dart';

import '../models/unit.dart';
import '../main.dart';

class InventoryWidget extends StatefulWidget {
  const InventoryWidget({super.key});

  @override
  State<StatefulWidget> createState() => _InventoryWidgetState();
}

class _InventoryWidgetState extends State<InventoryWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        const SearchBar(),
        Expanded(
          child: ListView(
              children: MyApp.inventory
                  .map((item) => InventoryItemWidget(item))
                  .toList()),
        ),
      ],
    );
  }
}
