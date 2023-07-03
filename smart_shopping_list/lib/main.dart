import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:smart_shopping_list/models/inventory_item.dart';
import 'package:smart_shopping_list/models/shopping_list_item.dart';
import 'package:smart_shopping_list/widgets/camera_widget.dart';
import 'package:smart_shopping_list/widgets/inventory_widget.dart';
import 'package:smart_shopping_list/widgets/shopping_list_widget.dart';

import 'models/item_state.dart';
import 'models/unit.dart';

Future<void> main() async {
  // Ensure that plugin services are initialized so that `availableCameras()`
  // can be called before `runApp()`
  WidgetsFlutterBinding.ensureInitialized();

  // Obtain a list of the available cameras on the device.
  final List<CameraDescription> cameras = await availableCameras();
  runApp(MyApp(cameras));
}

class MyApp extends StatelessWidget {
  const MyApp(this.cameras, {super.key});

  final List<CameraDescription> cameras;
  static List<InventoryItem> inventory = [
    InventoryItem("Staubmagnet Ersatztücher", "Swiffer", Unit.PART, 20),
    InventoryItem.forTesting("Strauchtomaten", "Lidl", Unit.GRAM, 300, 0.75),
  ];
  static List<ShoppingListItem> shoppingList = [
    ShoppingListItem("Butter", "Kerrygold", Unit.GRAM, 250, ItemState.EMPTY),
    ShoppingListItem(
        "Classic Tabs", "Denkmit (DM)", Unit.PART, 65, ItemState.EMPTY),
    ShoppingListItem(
        "Weizenmehl", "Bioland", Unit.GRAM, 1000, ItemState.MAYBE_EMPTY),
    ShoppingListItem("Toilettenpapier 4-lagig", "Floralys", Unit.PART, 10,
        ItemState.MAYBE_EMPTY),
    ShoppingListItem(
        "Goldbären", "Haribo", Unit.GRAM, 75, ItemState.MAYBE_EMPTY),
  ];

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Shopventory',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(
        cameras: cameras,
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.cameras});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final cameras;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;
  bool _showCamera = false;

  String _title() {
    final titleOptions = [
      "Einkaufsliste",
      "Dein Inventar",
      "Smart Scanner",
    ];
    return titleOptions.elementAt(_selectedIndex);
  }

  Widget _page() {
    final widgetOptions = [
      const ShoppingListWidget(),
      const InventoryWidget(),
      CameraWidget(
        cameras: widget.cameras,
        show: _showCamera,
        proceedToInventory: () => _onItemTapped(1),
      ),
    ];
    return widgetOptions.elementAt(_selectedIndex);
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(_title()),
      ),
      body: _page(),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.shopping_bag), label: "Einkaufsliste"),
          BottomNavigationBarItem(
              icon: Icon(Icons.inventory), label: "Dein Inventar"),
          BottomNavigationBarItem(
              icon: Icon(Icons.camera_alt), label: "Smart Scanner")
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
