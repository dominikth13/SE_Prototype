import 'package:smart_shopping_list/models/inventory_item.dart';

enum InventoryFilter {
  FRIDGE("Kühlschrank"),
  UTILITY_ROOM("Hauswirtschaftsraum"),
  BATHROOM("Badezimmer"),
  ALL("Gesamter Haushalt");

  final String displayName;

  const InventoryFilter(this.displayName);

  bool equals(InventoryFilter item) {
    if (item == ALL || this == ALL) {
      return true;
    }

    return item == this;
  }
}
