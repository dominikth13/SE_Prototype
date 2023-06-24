import 'package:smart_shopping_list/models/product.dart';
import 'package:smart_shopping_list/models/unit.dart';

class InventoryItem implements Comparable {
  late Product product;
  double remainingAmount = 1;

  InventoryItem(String name, String brand, Unit unit, double size) {
    product = Product(name, brand, unit, size);
  }
  InventoryItem.forTesting(
      String name, String brand, Unit unit, double size, this.remainingAmount) {
    product = Product(name, brand, unit, size);
  }

  double getRemainingSize() {
    return remainingAmount * product.size;
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
