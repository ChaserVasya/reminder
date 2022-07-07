import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ChangeNotifierProvider<ItemsViewModel>(
        create: (_) => ItemsViewModel(),
        child: const MyScaffold(
          child: MyPage(),
        ),
      ),
    );
  }
}

class MyScaffold extends StatelessWidget {
  const MyScaffold({required this.child, Key? key}) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: context.read<ItemsViewModel>().add,
        child: const Icon(Icons.add),
      ),
      body: child,
    );
  }
}

class MyPage extends StatelessWidget {
  const MyPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: context.read<ItemsViewModel>().fetching,
      builder: (_, snap) {
        if (snap.connectionState != ConnectionState.done) return const ItemPlug();

        final ids = context.watch<ItemsViewModel>().ids;
        return Center(
          child: (ids.isEmpty)
              ? const Text("Create item")
              : ListView.builder(
                  itemCount: ids.length,
                  itemBuilder: (_, i) => MyCard(ids[i]),
                ),
        );
      },
    );
  }
}

class MyCard extends StatelessWidget {
  const MyCard(this.id, {Key? key}) : super(key: key);

  final int id;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<CardViewModel>(
      create: (_) => CardViewModel(id),
      builder: (context, _) => FutureBuilder(
        future: context.read<CardViewModel>().fetching,
        builder: (context, snap) {
          if (snap.connectionState != ConnectionState.done) return const ItemPlug();

          final item = context.watch<CardViewModel>().item;
          return Card(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text("${item.id}"),
                Text(item.content),
                TextButton(
                  onPressed: () => context.read<ItemsViewModel>().delete(item.id),
                  child: const Text("Delete"),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class CardViewModel extends ChangeNotifier {
  CardViewModel(int id) {
    fetching = fetch(id);
  }

  late final Future<void> fetching;

  late final Item item;

  Future<void> fetch(int id) async {
    item = await ItemsRepo.getItem(id);
  }
}

class ItemsViewModel extends ChangeNotifier {
  ItemsViewModel() {
    fetching = fetch();
  }

  late Future<void> fetching;
  late List<int> ids;

  Future<void> fetch() async {
    ids = await ItemsRepo.getItemsIds();
  }

  Future<void> delete(int id) async {
    await ItemsRepo.deleteItem(id);
    fetching = fetch();
    notifyListeners();
  }

  Future<void> add() async {
    final item = Item(IdGenerator.generate());
    await ItemsRepo.setItem(item);
    fetching = fetch();
    notifyListeners();
  }
}

class ItemsRepo {
  static final List<Item> _items = [];

  static Future<List<int>> getItemsIds() async {
    return _items.map((e) => e.id).toList();
  }

  static Future<Item> getItem(int id) {
    return Future.value(_items.singleWhere((e) => e.id == id));
  }

  static Future<void> setItem(Item item) async {
    _items.add(item);
  }

  static Future<void> deleteItem(int id) async {
    _items.removeWhere((e) => e.id == id);
  }
}

class Item {
  int id;
  String content = "I`m an item";

  Item(this.id);
}

class IdGenerator {
  static int _currentId = 0;

  static generate() => _currentId++;
}

class ItemPlug extends StatelessWidget {
  const ItemPlug({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }
}
