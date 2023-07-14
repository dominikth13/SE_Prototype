import 'package:flutter/material.dart';

class InventoryOverviewItemWidget extends StatefulWidget {
  final String name;
  final Function() onClick;

  const InventoryOverviewItemWidget(
      {super.key, required this.name, required this.onClick});
  @override
  State<StatefulWidget> createState() => _InventoryOverviewItemWidgetState();
}

class _InventoryOverviewItemWidgetState
    extends State<InventoryOverviewItemWidget> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(widget.name),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(5),
          topRight: Radius.circular(5),
          bottomRight: Radius.circular(5),
          bottomLeft: Radius.circular(5),
        ),
      ),
      trailing: const Icon(Icons.navigate_next),
      onTap: widget.onClick,
    );
  }
}
