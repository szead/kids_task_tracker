import 'package:flutter/material.dart';
import '../model/task.dart';

class CongratulationScreen extends StatelessWidget {
  final Task task;

  CongratulationScreen({Key key, this.task}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("\"${task.taskName}\""),
      ),
      body: new Align(
          alignment: FractionalOffset.center,
          child: new Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              new Text(
                "Task Completed",
                style: Theme.of(context).textTheme.headline4
              ),new Text(
                "Congratulations!",
                style: Theme.of(context).textTheme.headline3,
              ),
              new Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  new Text("Your kids prize is a ${task.prize}"),
                  new Image.network(
                    "https://i.pinimg.com/736x/3b/06/ef/3b06efe25fed62de2960090ff2b8d83a--cute-cartoon-drawings-drawings-of.jpg",
                    height: 42.0,
                    width: 42.0,
                  ),
                ],
              )
            ],
          )),
    );

    // return Scaffold(
    //   appBar: AppBar(),
    //   body:
    //   Text("Congratulations your kid is awesome: $task has been completed"),
    // );
  }
}
