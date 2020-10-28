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
  String description = '';
  DateTime date = DateTime.now();
  double maxValue = 0;
  bool enableFeature = false;
  String dropdownValue = 'Alma';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Task"),
        actions: [
          IconButton(icon: Icon(Icons.check), onPressed: () {}),
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
                          initialValue: widget.tasks.elementAt(widget.index).taskName,
                          onChanged: (value) {
                            setState(() {
                              taskName = value;
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
                          onChanged: (value) {
                            description = value;
                          },
                          // maxLines: 5,
                        ),
                        DropdownButton<String>(
                          value: dropdownValue,
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
                              dropdownValue = newValue;
                            });
                          },
                          items: <String>['Alma', 'Two', 'Free', 'Four']
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                        ),
                        _FormDatePicker(
                          date: date,
                          onChanged: (value) {
                            setState(() {
                              date = value;
                            });
                          },
                        ),
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

      // onPressed: () {
      // Navigator.pop(context, items);
    );
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
