import 'package:flutter/material.dart';
import 'package:smart_shopping_list/models/inventory_item.dart';
import 'package:smart_shopping_list/widgets/camera_widget.dart';
import 'package:smart_shopping_list/widgets/inventory_item_widget.dart';

import '../models/unit.dart';

class InventoryWidget extends StatefulWidget {
  final camera;

  const InventoryWidget(this.camera, {super.key});

  @override
  State<StatefulWidget> createState() => _InventoryWidgetState();
}

class _InventoryWidgetState extends State<InventoryWidget> {
  bool _isCameraOpen = false;

  final List<InventoryItem> _items = [
    InventoryItem("Staubmagnet Ersatztücher", "Swiffer", Unit.PARTS, 20),
    InventoryItem("Strauchtomaten", "Lidl", Unit.GRAMS, 300)
  ];

  void _openCamera() {
    _isCameraOpen = true;

    setState(() {
      _isCameraOpen;
    });
  }

  Widget _camera() {
    if (_isCameraOpen) {
      return CameraWidget(camera: widget.camera);
    }

    return Text("data");
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        const SearchBar(),
        Expanded(
          child: ListView(
              children:
                  _items.map((item) => InventoryItemWidget(item)).toList()),
        ),
        IconButton(
            onPressed: () => CameraWidget(camera: widget.camera),
            icon: const Icon(Icons.camera)),
        _camera()
      ],
    );
  }
}
