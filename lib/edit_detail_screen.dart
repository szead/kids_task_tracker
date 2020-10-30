import 'package:flutter/material.dart';
import 'package:intl/intl.dart' as intl;
import 'package:kids_task_tracker/model/task.dart';

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

  static final List<String> kidsName = ["Jeremi", "Nero"];
  static final List<String> types = ["Deadline", "Count"];

  String assigneeDropdownValue = kidsName.first;

  String typeDropdownValue;

  int counter;

  @override
  void initState() {
    taskName = widget.tasks.elementAt(widget.index).taskName;
    date = widget.tasks.elementAt(widget.index).deadline;
    typeDropdownValue = widget.tasks.elementAt(widget.index).maxCount == null
        ? types.first
        : types.last;
    print(typeDropdownValue);
    counter = widget.tasks.elementAt(widget.index).maxCount == null
        ? 0
        : widget.tasks.elementAt(widget.index).maxCount;
    print(counter);
    prize = widget.tasks.elementAt(widget.index).prize;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Task"),
        actions: [
          IconButton(
              icon: Icon(Icons.check),
              onPressed: () {
                Navigator.pop(context);
              }),
          IconButton(
              icon: Icon(Icons.delete_forever_outlined),
              onPressed: () {
                widget.tasks.removeAt(widget.index);
                Navigator.pop(context);
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
                          initialValue: taskName,
                          onChanged: (value) {
                            setState(() {
                              taskName = value;
                              widget.tasks.elementAt(widget.index).taskName =
                                  taskName;
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
                          initialValue: prize,
                          onChanged: (value) {
                            prize = value;
                            widget.tasks.elementAt(widget.index).prize = prize;
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
          widget.tasks.elementAt(widget.index).maxCount = null;
          widgets.add(_FormDatePicker(
            date: date,
            onChanged: (value) {
              setState(() {
                date = value;
                widget.tasks.elementAt(widget.index).deadline = date;
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
                        widget.tasks.elementAt(widget.index).maxCount = counter;
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
                        widget.tasks.elementAt(widget.index).maxCount = counter;
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
}

class _FormDatePicker extends StatefulWidget {
  final DateTime date;
  final ValueChanged onChanged;

  _FormDatePicker({
    this.date,
    this.onChanged,
  });

  @override
  _FormDatePickerState createState() => _FormDatePickerState();
}

class _FormDatePickerState extends State<_FormDatePicker> {
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text(
              'Deadline',
              style: Theme.of(context).textTheme.bodyText1,
            ),
            Text(
              intl.DateFormat.yMd().format(widget.date),
              style: Theme.of(context).textTheme.subtitle1,
            ),
          ],
        ),
        FlatButton(
          child: Icon(Icons.calendar_today_outlined),
          onPressed: () async {
            var newDate = await showDatePicker(
              context: context,
              initialDate: widget.date,
              firstDate: DateTime(1900),
              lastDate: DateTime(2100),
            );

            // Don't change the date if the date picker returns null.
            if (newDate == null) {
              return;
            }

            widget.onChanged(newDate);
          },
        )
      ],
    );
  }
}