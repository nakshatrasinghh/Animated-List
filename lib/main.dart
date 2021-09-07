import 'package:animated_list/data/list_data.dart';
import 'package:animated_list/model/list_item.dart';
import 'package:animated_list/widget/list_item_widget.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      home: MainPage(),
    );
  }
}

class MainPage extends StatefulWidget {
  MainPage({Key? key}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final listkey = GlobalKey<AnimatedListState>();
  final List<ListItem> items = List.from(listItems);

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.deepOrange.withOpacity(0.8),
          title: Text('Animated List',
              style: TextStyle(color: Colors.white, fontSize: 25)),
          centerTitle: true,
        ),
        body: AnimatedList(
          key: listkey,
          itemBuilder: (context, index, animation) => ListItemWidget(
              item: items[index],
              animation: animation,
              onClicked: () => removeItem(index)),
          initialItemCount: items.length,
        ),
        floatingActionButton: FloatingActionButton(
            child: Icon(Icons.add), onPressed: () => insertItem()),
      );

  void removeItem(int index) {
    final removeItem = items[index];

    items.removeAt(index);
    listkey.currentState!.removeItem(
        index,
        (context, animation) => ListItemWidget(
            item: removeItem, animation: animation, onClicked: () {}),
        duration: Duration(milliseconds: 600));
  }

  void insertItem() {
    final newIndex = 0;
    final newItem = (List.of(listItems)..shuffle())
        .first; // randomly picks an item from the list and displays it
    items.insert(newIndex, newItem);
    listkey.currentState!.insertItem(
      newIndex,
      duration: Duration(milliseconds: 600),
    );
  }
}
