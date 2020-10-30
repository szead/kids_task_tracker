import 'package:flutter/material.dart';
import '../model/task.dart';

class CompletedDetailScreen extends StatelessWidget {
  final Task task;
  final _formKey = GlobalKey<FormState>();

  CompletedDetailScreen({Key key, this.task}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Task"),
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
                          ),
                          readOnly: true,
                          initialValue: task.taskName,
                        ),
                        TextFormField(
                          decoration: InputDecoration(
                            filled: true,
                          ),
                          readOnly: true,
                          initialValue: task.prize,
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
    List<Widget> widgets = List<Widget>();
    if (task.isDeadline()) {
      widgets.add(TextFormField(
        decoration: InputDecoration(
          labelText: "Type",
          filled: true,
        ),
        readOnly: true,
        initialValue: "Deadline",
      ));
      widgets.add(TextFormField(
        decoration: InputDecoration(
          labelText: "Deadline",
          filled: true,
        ),
        readOnly: true,
        initialValue:
            "${task.deadline.day}/${task.deadline.month}/${task.deadline.year}",
      ));
    } else {
      widgets.add(TextFormField(
        decoration: InputDecoration(
          labelText: "Type",
          filled: true,
        ),
        readOnly: true,
        initialValue: "Count",
      ));
      widgets.add(TextFormField(
        decoration: InputDecoration(
          labelText: "Count",
          filled: true,
        ),
        readOnly: true,
        initialValue: task.maxCount.toString(),
      ));
    }
    widgets.add(TextFormField(
      decoration: InputDecoration(
        labelText: "Completed at",
        filled: true,
      ),
      readOnly: true,
      initialValue:
          "${task.completedAt.day}/${task.completedAt.month}/${task.completedAt.year}",
    ));

    return widgets;
  }
}
