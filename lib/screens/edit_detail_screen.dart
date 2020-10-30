import 'package:flutter/material.dart';
import 'package:kids_task_tracker/model/task.dart';
import 'form_date_picker.dart';

class EditDetailScreen extends StatefulWidget {
  final List<Task> tasks;
  final int index;

  EditDetailScreen({Key key, this.tasks, this.index}) : super(key: key);

  _EditDetailScreenState createState() => _EditDetailScreenState();
}

class _EditDetailScreenState extends State<EditDetailScreen> {
  final _formKey = GlobalKey<FormState>();
  String taskName = '';
  String prize = '';
  DateTime date = DateTime.now();
  double maxValue = 0;

  Task actualTask;

  static final List<String> kidsName = ["Jeremi", "Nero"];
  static final List<String> types = ["Deadline", "Count"];

  String assigneeDropdownValue = kidsName.first;

  String typeDropdownValue;

  int counter;

  @override
  void initState() {
    actualTask = widget.tasks.elementAt(widget.index);
    taskName = actualTask.taskName;
    date = actualTask.deadline;
    typeDropdownValue = actualTask.maxCount == null ? types.first : types.last;
    print(typeDropdownValue);
    counter = actualTask.maxCount == null ? 0 : actualTask.maxCount;
    print(counter);
    prize = actualTask.prize;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Task"),
        actions: [
          ...activeTaskAction(actualTask),
          IconButton(
              icon: Icon(Icons.delete_forever_outlined),
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text("Confirm delete"),
                        content: Text("Would you like to delete this task?"),
                        actions: [
                          FlatButton(
                            child: Text("Cancel"),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                          ),
                          FlatButton(
                            child: Text("Delete"),
                            onPressed: () {
                              widget.tasks.removeAt(widget.index);
                              int count = 0;
                              Navigator.popUntil(context, (route) {
                                return count++ == 2;
                              });
                            },
                          )
                        ],
                      );
                    });
              }),
        ],
      ),
      body: Form(
        key: _formKey,
        child: Scrollbar(
          child: Align(
            alignment: Alignment.topCenter,
            child: Card(
              child: SingleChildScrollView(
                padding: EdgeInsets.all(16),
                child: ConstrainedBox(
                  constraints: BoxConstraints(maxWidth: 400),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      ...[
                        TextFormField(
                          decoration: InputDecoration(
                            filled: true,
                            hintText: 'Enter a task name...',
                            labelText: 'Name',
                          ),
                          readOnly: actualTask.completed,
                          initialValue: taskName,
                          onChanged: (value) {
                            setState(() {
                              taskName = value;
                              actualTask.taskName = taskName;
                            });
                          },
                        ),
                        TextFormField(
                          decoration: InputDecoration(
                            // border: const OutlineInputBorder(),
                            filled: true,
                            hintText: 'Enter a prize...',
                            labelText: 'Prize',
                          ),
                          readOnly: actualTask.completed,
                          initialValue: prize,
                          onChanged: (value) {
                            prize = value;
                            actualTask.prize = prize;
                          },
                          maxLines: 2,
                        ),
                        DropdownButton<String>(
                          value: assigneeDropdownValue,
                          icon: Icon(Icons.arrow_downward),
                          isExpanded: true,
                          // iconSize: 24,
                          // elevation: 16,
                          // style: TextStyle(color: Colors.deepPurple),
                          underline: Container(
                            height: 1,
                            color: Colors.grey,
                          ),
                          onChanged: (String newValue) {
                            setState(() {
                              assigneeDropdownValue = newValue;
                            });
                          },
                          items: kidsName
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                        ),
                        DropdownButton<String>(
                          value: typeDropdownValue,
                          icon: Icon(Icons.arrow_downward),
                          isExpanded: true,
                          // iconSize: 24,
                          // elevation: 16,
                          // style: TextStyle(color: Colors.deepPurple),
                          underline: Container(
                            height: 1,
                            color: Colors.grey,
                          ),
                          onChanged: (String newValue) {
                            setState(() {
                              typeDropdownValue = newValue;
                            });
                          },
                          items: types
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                        ),
                        ...getWidgetByType(),
                      ].expand(
                        (widget) => [
                          widget,
                          SizedBox(
                            height: 24,
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  List<Widget> getWidgetByType() {
    List<Widget> widgets = new List<Widget>();
    switch (typeDropdownValue) {
      case "Deadline":
        {
          actualTask.maxCount = null;
          widgets.add(FormDatePicker(
            date: date,
            onChanged: (value) {
              setState(() {
                date = value;
                actualTask.deadline = date;
              });
            },
          ));
        }
        break;
      case "Count":
        {
          widgets.add(Container(
            padding: EdgeInsets.all(10.0),
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(width: 1.0, color: Colors.grey),
              ),
            ),
            child: new Center(
              child: new Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  new FloatingActionButton(
                    heroTag: "Remove",
                    onPressed: () => {
                      setState(() {
                        counter--;
                        actualTask.maxCount = counter;
                      })
                    },
                    child: new Icon(
                      Icons.remove,
                      color: Colors.black,
                    ),
                    backgroundColor: Colors.white,
                  ),
                  new Text(counter.toString(),
                      style: new TextStyle(fontSize: 35.0)),
                  new FloatingActionButton(
                    heroTag: "Add",
                    onPressed: () => {
                      setState(() {
                        counter++;
                        actualTask.maxCount = counter;
                      })
                    },
                    child: new Icon(
                      Icons.add,
                      color: Colors.black,
                    ),
                    backgroundColor: Colors.white,
                  ),
                ],
              ),
            ),
          ));
        }
        break;
    }
    return widgets;
  }

  List<Widget> activeTaskAction(Task task) {
    List<Widget> widgets = new List<Widget>();
    if (!task.completed) {
      widgets.add(IconButton(
          icon: Icon(Icons.check),
          onPressed: () {
            showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text("Confirm complete"),
                    content: Text("Would you like to complete this task?"),
                    actions: [
                      FlatButton(
                        child: Text("Cancel"),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                      FlatButton(
                        child: Text("Complete"),
                        onPressed: () {
                          actualTask.completed = true;
                          int count = 0;
                          Navigator.popUntil(context, (route) {
                            return count++ == 2;
                          });
                        },
                      )
                    ],
                  );
                });
          }));
    }
    return widgets;
  }
}
