import 'dart:ffi';

import 'package:smart_shopping_list/models/inventory_filter.dart';
import 'package:smart_shopping_list/models/unit.dart';

class Product implements Comparable {
  String name;
  String brand;
  Unit unit;
  double size;

  Product(this.name, this.brand, this.unit, this.size);

  String toString() {
    return "$name ($brand)\n $size ${unit.code}";
  }

  @override
  int compareTo(other) {
    Product otherProduct = other as Product;

    if (name.compareTo(otherProduct.name) != 0) {
      return name.compareTo(otherProduct.name);
    }

    if (brand.compareTo(otherProduct.brand) != 0) {
      return brand.compareTo(otherProduct.brand);
    }

    return size - otherProduct.size as int;
  }

  InventoryFilter getFilter() {
    if (name.contains("Cola") ||
        name.contains("mehl") ||
        name.contains("papier") ||
        name.contains("bären")) {
      return InventoryFilter.UTILITY_ROOM;
    } else if (name.contains("milch")) {
      return InventoryFilter.FRIDGE;
    }

    return InventoryFilter.ALL;
  }
}
