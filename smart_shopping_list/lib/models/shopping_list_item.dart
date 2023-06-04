import 'package:smart_shopping_list/models/item_state.dart';

class ShoppingListItem {
  String name;
  ItemState state;
  bool addedToShoppingList;

  ShoppingListItem(this.name, this.state, this.addedToShoppingList);
}