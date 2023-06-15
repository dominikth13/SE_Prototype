import 'package:smart_shopping_list/models/unit.dart';

class InventoryItem {
  String name;
  String brand;
  Unit unit;
  int size;
  double remainingAmount = 1;

  InventoryItem(this.name, this.brand, this.unit, this.size);
}
