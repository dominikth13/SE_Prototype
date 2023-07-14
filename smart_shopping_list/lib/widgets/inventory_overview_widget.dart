import 'package:flutter/material.dart';

import '../models/inventory_filter.dart';
import 'inventory_overview_item_widget.dart';
import 'inventory_widget.dart';

class InventoryOverviewWidget extends StatefulWidget {
  final bool goToInventory;
  String title = "Mein Inventar";

  InventoryOverviewWidget({super.key, required this.goToInventory});

  @override
  State<StatefulWidget> createState() => _InventoryOverviewWidgetState();
}

class _InventoryOverviewWidgetState extends State<InventoryOverviewWidget> {
  InventoryFilter _filter = InventoryFilter.ALL;
  bool _applyFilter = false;

  @override
  void initState() {
    super.initState();
    _applyFilter = widget.goToInventory;
  }

  @override
  Widget build(BuildContext context) {
    return _applyFilter
        ? InventoryWidget(
            filter: _filter,
            onClickGoBack: () => setState(() {
                  _applyFilter = false;
                }))
        : ListView(
            children: InventoryFilter.values
                .map((filter) => InventoryOverviewItemWidget(
                      name: filter.displayName,
                      onClick: () => setState(() {
                        widget.title = filter.displayName;
                        _filter = filter;
                        _applyFilter = true;
                      }),
                    ))
                .toList(),
          );
  }
}
