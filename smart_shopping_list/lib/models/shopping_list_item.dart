import 'package:smart_shopping_list/models/item_state.dart';
import 'package:smart_shopping_list/models/product.dart';
import 'package:smart_shopping_list/models/unit.dart';

class ShoppingListItem implements Comparable {
  late Product product;
  ItemState state;

  ShoppingListItem(
      String name, String brand, Unit unit, double size, this.state) {
    product = Product(name, brand, unit, size);
  }

  @override
  int compareTo(other) {
    ShoppingListItem otherItem = other as ShoppingListItem;

    if (state == ItemState.MAYBE_EMPTY) {
      if (otherItem.state == ItemState.MAYBE_EMPTY) {
        return product.compareTo(otherItem.product);
      }

      return -1;
    }

    if (otherItem.state == ItemState.MAYBE_EMPTY) {
      return 1;
    }

    if (state == ItemState.EMPTY) {
      if (otherItem.state == ItemState.EMPTY) {
        return product.compareTo(otherItem.product);
      }

      return -1;
    }

    if (otherItem.state == ItemState.EMPTY) {
      return 1;
    }

    return product.compareTo(otherItem.product);
  }
}
