import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Kids Task Tracker',
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
        // This makes the visual density adapt to the platform that you run
        // the app on. For desktop platforms, the controls will be smaller and
        // closer together (more dense) than on mobile platforms.
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: TasksListPage(title: 'Tasks list'),
    );
  }
}

class TasksListPage extends StatefulWidget {
  TasksListPage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _TasksListPageState createState() => _TasksListPageState();
}

class _TasksListPageState extends State<TasksListPage> {
  final activeItems = List<String>.generate(10, (i) => "Active Item $i");
  final subtitle = List<String>.generate(10, (i) => "Subtitle $i");
  final completedItems = List<String>.generate(10, (i) => "Completed Item $i");

  void _addNewTask() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            // Here we take the value from the MyHomePage object that was created by
            // the App.build method, and use it to set our appbar title.
            bottom: TabBar(tabs: [Tab(text: "ACTIVE"), Tab(text: "COMPLETED")]),
            title: Text(widget.title),
            leading: IconButton(icon: Icon(Icons.menu), onPressed: _menuPushed),
            actions: [
              IconButton(icon: Icon(Icons.search), onPressed: _menuPushed),
              IconButton(icon: Icon(Icons.group_add), onPressed: _menuPushed)
            ],
          ),
          body: TabBarView(
            children: [
              ListView.separated(
                separatorBuilder: (context, index) => Divider(
                  color: Colors.black,
                  height: 0,
                  thickness: 0,
                ),
                itemCount: activeItems.length,
                itemBuilder: (context, index) {
                  return Dismissible(
                      key: Key(activeItems[index]),
                      background: slideRightBackground(),
                      secondaryBackground: slideLeftBackground(),
                      onDismissed: (direction) {
                        if (direction == DismissDirection.endToStart) {
                          setState(() {
                            activeItems.removeAt(index);
                          });
                        }
                      },
                      child: ListTile(
                        onTap: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return DetailScreen(item: activeItems[index]);
                          }));
                        },
                        leading: Icon(Icons.home),
                        title: Text(activeItems[index]),
                        subtitle: Text(subtitle[index]),
                      ));
                },
              ),
              ListView.separated(
                separatorBuilder: (context, index) => Divider(
                  color: Colors.black,
                ),
                itemCount: completedItems.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: Icon(Icons.home),
                    title: Text(completedItems[index]),
                    subtitle: Text(subtitle[index]),
                  );
                },
              )
            ],
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: _addNewTask,
            tooltip: 'Add new task',
            child: Icon(Icons.add),
          ), // This trailing comma makes auto-formatting nicer for build methods.
        ));
  }

  void _menuPushed() {}

  Widget slideRightBackground() {
    return Container(
      color: Colors.green,
      child: Align(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              width: 20,
            ),
            Icon(
              Icons.done,
              color: Colors.white,
            ),
            Text(
              " Complete",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w700,
              ),
              textAlign: TextAlign.left,
            ),
          ],
        ),
        alignment: Alignment.centerLeft,
      ),
    );
  }

  Widget slideLeftBackground() {
    return Container(
      color: Colors.red,
      child: Align(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Icon(
              Icons.delete,
              color: Colors.white,
            ),
            Text(
              " Delete",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w700,
              ),
              textAlign: TextAlign.right,
            ),
            SizedBox(
              width: 20,
            ),
          ],
        ),
        alignment: Alignment.centerRight,
      ),
    );
  }
}

class DetailScreen extends StatelessWidget {
  final String item;

  const DetailScreen({Key key, this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: FlatButton(
          child: Text(item),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
    );
  }
}
