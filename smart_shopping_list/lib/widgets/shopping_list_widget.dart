import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:flutter/material.dart';
import 'package:smart_shopping_list/models/inventory_item.dart';
import 'package:smart_shopping_list/models/item_state.dart';
import 'package:smart_shopping_list/models/product.dart';
import 'package:smart_shopping_list/widgets/shopping_list_item_widget.dart';

import '../models/shopping_list_item.dart';
import '../main.dart';
import '../models/unit.dart';

class ShoppingListWidget extends StatefulWidget {
  const ShoppingListWidget({super.key});

  @override
  State<StatefulWidget> createState() => _ShoppingListWidgetState();
}

class _ShoppingListWidgetState extends State<ShoppingListWidget> {
  final TextEditingController _addProductNameController =
      TextEditingController();
  final SingleValueDropDownController _svdc = SingleValueDropDownController();
  List<ShoppingListItem> _items = [];
  List<ShoppingListItem> _meitems = [];

  @override
  void initState() {
    super.initState();

    _items = _sortedItems();
    _meitems = _maybeEmpty();

    if (!_meitems.isEmpty) {
      WidgetsBinding.instance.addPostFrameCallback((_) async {
        await _showSimpleModalDialog();
      });
    }
  }

  void _addProduct() {
    Product? product = _svdc.dropDownValue?.value;
    if (product == null) {
      return;
    }

    MyApp.shoppingList.add(ShoppingListItem(product.name, product.brand,
        product.unit, product.size, ItemState.CUSTOM));
    _svdc.dropDownValue = null;

    setState(() {
      MyApp.shoppingList;
    });
    _onChangeItems();
  }

  void _onChangeItems() {
    _items = _sortedItems();
    _meitems = _maybeEmpty();
    setState(() {
      _items;
      _meitems;
    });
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    _addProductNameController.dispose();
    _svdc.dispose();
    super.dispose();
  }

  List<DropDownValueModel> _options() {
    final List<Product> _optionMock = [
      Product("Feinschmecker-Salami", "Wiltmann", Unit.GRAM, 80),
      Product("Salami Kralovsky", "Kostelec", Unit.GRAM, 380),
      Product("Salami", "Wilhelm Brandenburg", Unit.GRAM, 80),
      Product("Salami", "Die Thüringer", Unit.GRAM, 100),
      Product("Waschmittel Renew Schwarz", "Perwoll", Unit.LITRE, 1.375),
      Product("Colorwaschmittel Renew", "Perwoll", Unit.LITRE, 1.375),
      Product("Vollwaschmittel Universal Kraft-Gel", "Persil", Unit.LITRE, 0.9),
      Product("Colorwaschmittel All-in-1 Pods", "Ariel", Unit.GRAM, 306),
    ];
    _optionMock.sort();

    return _optionMock
        .map((e) => DropDownValueModel(
              name: e.toString(),
              value: e,
            ))
        .toList();
  }

  List<ShoppingListItem> _sortedItems() {
    List<ShoppingListItem> items = List.from(MyApp.shoppingList);
    items.sort();
    items.removeWhere((element) => element.state == ItemState.MAYBE_EMPTY);

    return items;
  }

  List<ShoppingListItem> _maybeEmpty() {
    List<ShoppingListItem> items = [];
    for (ShoppingListItem item in List.of(MyApp.shoppingList)) {
      if (item.state == ItemState.MAYBE_EMPTY) {
        items.add(item);
      }
    }
    items.sort();

    return items;
  }

  _showSimpleModalDialog() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return StatefulBuilder(builder: (context, setModalState) {
            return Dialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0)),
              child: Container(
                constraints: BoxConstraints(maxHeight: 350),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(children: [
                    Text("Die folgenden Produkte sind evetuell leer:",
                        style: TextStyle(fontSize: 18)),
                    Expanded(
                      child: ListView(
                        children: _meitems
                            .map((e) =>
                                ShoppingListItemWidget(e, onChangeItem: () {
                                  _onChangeItems();
                                  setModalState(
                                    () {
                                      _meitems;
                                    },
                                  );
                                  if (_meitems.isEmpty) {
                                    Navigator.pop(context);
                                  }
                                }))
                            .toList(),
                      ),
                    ),
                  ]),
                ),
              ),
            );
          });
        });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Expanded(
          child: ListView(
            children: _sortedItems()
                .map((e) =>
                    ShoppingListItemWidget(e, onChangeItem: _onChangeItems))
                .toList(),
          ),
        ),
        Container(
          height: 100,
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
            color: Colors.blue,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                padding: EdgeInsets.fromLTRB(10, 5, 5, 5),
                child: SizedBox(
                  width: 300,
                  child: DropDownTextField(
                    dropDownList: _options(),
                    enableSearch: true,
                    controller: _svdc,
                    dropDownItemCount: 4,
                    searchDecoration:
                        InputDecoration(hintText: "Produktname, Marke etc."),
                    textFieldDecoration: InputDecoration(
                        hintText: "Produktname, Marke etc.",
                        constraints: BoxConstraints(maxWidth: 200)),
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.fromLTRB(10, 5, 5, 5),
                child: ElevatedButton(
                  onPressed: _addProduct,
                  style: ElevatedButton.styleFrom(
                    shape: const CircleBorder(),
                    padding: const EdgeInsets.all(20),
                    backgroundColor: Colors.blue, // <-- Button color
                    foregroundColor: Colors.grey, // <-- Splash color
                  ),
                  child: const Icon(Icons.add, color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
