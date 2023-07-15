import 'package:smart_shopping_list/models/inventory_filter.dart';
import 'package:smart_shopping_list/models/product.dart';
import 'package:smart_shopping_list/models/unit.dart';

class InventoryItem implements Comparable {
  late Product product;
  double remainingAmount = 1;
  InventoryFilter storageLocation;

  InventoryItem.ofProduct(this.product, this.storageLocation);
  InventoryItem(
      String name, String brand, Unit unit, double size, this.storageLocation) {
    product = Product(name, brand, unit, size);
  }
  InventoryItem.forTesting(String name, String brand, Unit unit, double size,
      this.remainingAmount, this.storageLocation) {
    product = Product(name, brand, unit, size);
  }

  getRemainingSize() {
    double remainingSize = remainingAmount * product.size;
    if (product.unit == Unit.PART) {
      return remainingSize.toInt();
    }
    return remainingSize;
  }

  void setRemainingAmountBySize(double remainingSize) {
    remainingAmount = remainingSize / product.size;
  }

  @override
  int compareTo(other) {
    return ((this.remainingAmount - (other as InventoryItem).remainingAmount) *
            100)
        .toInt();
  }
}
