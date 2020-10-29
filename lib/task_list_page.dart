import 'package:flutter/material.dart';
import 'edit_detail_screen.dart';
import 'model/task.dart';

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
  final activeItems = List<String>.generate(10, (i) => "Active Task $i");
  final childrenName = List<String>.generate(10, (i) => "Kids name $i");
  final completedItems = List<String>.generate(10, (i) => "Completed Task $i");
  static final tasksSnapshot = [
    {
      "task_name": "Homework",
      "completed": false,
      "current_count": 0,
      "deadline": "2002-02-27T14:00:00-0500",
      "kid_id": "1",
      "max_count": null,
      "parent_id": "1",
      "prize": "buzz",
    },
    {
      "task_name": "Cleaning",
      "completed": false,
      "current_count": 0,
      "deadline": "2002-02-27T14:00:00-0500",
      "kid_id": "1",
      "max_count": 5,
      "parent_id": "1",
      "prize": "dino",
    },
    {
      "task_name": "Playing",
      "completed": true,
      "current_count": 0,
      "deadline": "2002-02-27T14:00:00-0500",
      "kid_id": "1",
      "max_count": 1,
      "parent_id": "1",
      "prize": "toy",
    }
  ];
  List<Task> tasks = tasksSnapshot.map((task) => Task.fromMap(task)).toList();

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
    tasks.forEach((element) {
      print(element);
    });
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
                  itemCount: tasks.length,
                  itemBuilder: (context, index) {
                    return _buildListItem(context, index, tasks);
                  }),
              ListView.separated(
                separatorBuilder: (context, index) => Divider(
                  color: Colors.black,
                ),
                itemCount: completedItems.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: Icon(Icons.home),
                    title: Text(completedItems[index]),
                    subtitle: Text(childrenName[index]),
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

  Widget _buildListItem(BuildContext context, int index, List<Task> tasks) {
    return Dismissible(
        key: Key(tasks.elementAt(index).taskName),
        background: slideRightBackground(),
        secondaryBackground: slideLeftBackground(),
        onDismissed: (direction) {
          if (direction == DismissDirection.endToStart) {
            setState(() {
              tasks.removeAt(index);
            });
          }
        },
        child: ListTile(
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return EditDetailScreen(tasks: tasks, index: index);
            })).then((value) => setState(() {}));
          },
          leading: Icon(Icons.home),
          title: Text(tasks.elementAt(index).taskName),
          subtitle: Text(tasks.elementAt(index).kidId),
          trailing: Wrap(
            spacing: 0,
            children: <Widget>[
              IconButton(
                icon: Icon(Icons.add_circle_outline),
                onPressed: () {},
              ),
              IconButton(
                icon: Icon(Icons.remove_circle_outline),
                onPressed: () {},
              ),
            ],
          ),
        ));
  }
}
