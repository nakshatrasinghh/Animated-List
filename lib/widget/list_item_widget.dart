import 'package:animated_list/model/list_item.dart';
import 'package:flutter/material.dart';

class ListItemWidget extends StatelessWidget {
  final ListItem item;
  final Animation<double> animation;
  final VoidCallback onClicked;

  const ListItemWidget(
      {Key? key,
      required this.item,
      required this.animation,
      required this.onClicked})
      : super(key: key);

  @override

  // //Slide Transition Animation for ListItem Widget
  // Widget build(BuildContext context) => SizeTransition(
  //       key: ValueKey(item.urlImage),
  //       sizeFactor: animation,
  //       child: buildItem(),
  //     );

  Widget build(BuildContext context) => SlideTransition(
      key: ValueKey(item.urlImage), // fixing the issue of the animation in images
      child: buildItem(),
      position: Tween<Offset>(
        begin: const Offset(-1.0, 0), //right to left
        end: Offset.zero,
      ).animate(CurvedAnimation(
        parent: animation,
        curve: Curves.ease,
      )));

  Widget buildItem() => Container(
        margin: EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
        ),
        child: ListTile(
          contentPadding: EdgeInsets.all(8),
          leading: CircleAvatar(
            radius: 32,
            backgroundImage: NetworkImage(item.urlImage),
          ),
          title: Text(
            item.title,
            style: TextStyle(fontSize: 22, color: Colors.black),
          ),
          trailing: IconButton(
            icon: Icon(Icons.delete, color: Colors.black, size: 28),
            onPressed: onClicked,
          ),
        ),
      );
}
