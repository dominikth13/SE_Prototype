import 'package:smart_shopping_list/models/unit.dart';

class InventoryItem implements Comparable {
  String name;
  String brand;
  Unit unit;
  double size;
  double remainingAmount = 1;

  InventoryItem(this.name, this.brand, this.unit, this.size);

  double getRemainingSize() {
    return remainingAmount * size;
  }

  void setRemainingAmountBySize(double remainingSize) {
    remainingAmount = remainingSize / size;
  }

  @override
  int compareTo(other) {
    return ((this.remainingAmount - (other as InventoryItem).remainingAmount) *
            100)
        .toInt();
  }
}
