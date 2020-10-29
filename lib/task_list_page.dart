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
  static final tasksSnapshot = [
    {
      "task_name": "Homework",
      "completed": false,
      "current_count": 0,
      "deadline": "2002-02-27T14:00:00-0500",
      "kid_id": "1",
      "max_count": null,
      "actual_count": null,
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
      "actual_count": 0,
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
      "actual_count": 0,
      "parent_id": "1",
      "prize": "toy",
    },
    {
      "task_name": "Hanging the cloths",
      "completed": false,
      "current_count": 0,
      "deadline": "2002-02-27T14:00:00-0500",
      "kid_id": "1",
      "max_count": 1,
      "actual_count": 0,
      "parent_id": "1",
      "prize": "toy",
    },
    {
      "task_name": "Hoovering",
      "completed": false,
      "current_count": 0,
      "deadline": "2020-10-30T14:00:00-0500",
      "kid_id": "1",
      "max_count": null,
      "actual_count": null,
      "parent_id": "1",
      "prize": "toy",
    },
    {
      "task_name": "Setting the table",
      "completed": false,
      "current_count": 0,
      "deadline": "2002-02-27T14:00:00-0500",
      "kid_id": "1",
      "max_count": 1,
      "actual_count": 0,
      "parent_id": "1",
      "prize": "toy",
    }
  ];
  List<Task> tasks = tasksSnapshot.map((task) => Task.fromMap(task)).toList();
  List<Task> completedTasks;
  List<Task> activeTasks;

  @override
  void initState() {
    completedTasks = tasks.where((element) => element.completed).toList();
    activeTasks = tasks.where((element) => !element.completed).toList();
    super.initState();
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
          //Active tasks:
          body: TabBarView(
            children: [
              ListView.separated(
                  separatorBuilder: (context, index) => Divider(
                        color: Colors.black,
                        height: 0,
                        thickness: 0,
                      ),
                  itemCount: activeTasks.length,
                  itemBuilder: (context, index) {
                    return _buildActiveListItem(context, index, activeTasks);
                  }),
              //Completed Tasks:
              ListView.separated(
                separatorBuilder: (context, index) => Divider(
                  color: Colors.black,
                ),
                itemCount: completedTasks.length,
                itemBuilder: (context, index) {
                  return _buildCompletedListItem(
                      context, index, completedTasks);
                },
              )
            ],
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () => _addNewTask(context),
            tooltip: 'Add new task',
            child: Icon(Icons.add),
          ), // This trailing comma makes auto-formatting nicer for build methods.
        ));
  }

  void _addNewTask(BuildContext context) {
    activeTasks.add(new Task.fromMap({
      "task_name": "",
      "completed": false,
      "current_count": 0,
      "deadline": DateTime.now().toString(),
      "kid_id": "1",
      "max_count": null,
      "actual_count": 0,
      "parent_id": "1",
      "prize": "",
    }));
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return EditDetailScreen(
          tasks: activeTasks, index: activeTasks.length - 1);
    })).then((value) => setState(() {}));
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

  Widget _buildActiveListItem(
      BuildContext context, int index, List<Task> tasks) {
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
          if (direction == DismissDirection.startToEnd) {
            setState(() {
              tasks.elementAt(index).completed = true;
              completedTasks.add(tasks.removeAt(index));
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
            children: <Widget>[...addCircles(tasks.elementAt(index))],
          ),
        ));
  }

  Widget _buildCompletedListItem(
      BuildContext context, int index, List<Task> tasks) {
    return Dismissible(
        key: Key(tasks.elementAt(index).taskName),
        background: slideLeftBackground(),
        onDismissed: (direction) {
          setState(() {
            tasks.removeAt(index);
          });
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
        ));
  }

  List<Widget> addCircles(Task task) {
    List<Widget> widgets = new List<Widget>();
    if (task.maxCount != null) {
      widgets.add(Text(task.actualCount.toString()));
      widgets.add(IconButton(
        icon: Icon(Icons.remove_circle_outline),
        onPressed: () {
          setState(() {
            task.actualCount--;
          });
        },
      ));
      widgets.add(IconButton(
        icon: Icon(Icons.add_circle_outline),
        onPressed: () {
          setState(() {
            if (task.actualCount == task.maxCount - 1) {
              activeTasks.remove(task);
              completedTasks.add(task);
              _completed(context,task);
            } else {
              task.actualCount++;
            }
          });
        },
      ));
    }
    return widgets;
  }

  void _completed(BuildContext context, Task task) {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return CongratulationScreen(task: task);
    }));
  }
}

class CongratulationScreen extends StatelessWidget {
  final Task task;

  CongratulationScreen({Key key, this.task}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

      ),
      body: Text("Congratulations your kid is awesome: $task has been completed"),
    );
  }
}
