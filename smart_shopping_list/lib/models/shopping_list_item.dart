import 'package:smart_shopping_list/models/item_state.dart';

class ShoppingListItem {
  String name;
  String brand;
  ItemState state;
  bool addedToShoppingList;

  ShoppingListItem(this.name, this.brand, this.state, this.addedToShoppingList);
}
