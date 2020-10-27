import 'package:flutter/material.dart';

class EditDetailScreen extends StatelessWidget {
  final List<String> items;
  final int i;

  const EditDetailScreen({Key key, this.items, this.i}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(items[i]),
        actions: [
          IconButton(icon: Icon(Icons.check), onPressed: () {}),
          IconButton(
              icon: Icon(Icons.delete_forever_outlined),
              onPressed: () {
                items.removeAt(i);
                Navigator.pop(context);
              }),
        ],
      ),
      body: Center(
        child: FlatButton(
          child: Text(items[i]),
          onPressed: () {
            Navigator.pop(context, items);
          },
        ),
      ),
    );
  }
}
