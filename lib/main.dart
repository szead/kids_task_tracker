import 'package:flutter/material.dart';
import 'task_list_page.dart';


void main() {
  runApp(MyApp());
}

final kidsSnapshot = [
  {"internal_count": 1, "name": "Filip", "parent_id": "1"},
  {"internal_count": 2, "name": "Abraham", "votes": "1"},
  {"internal_count": 3, "name": "Richard", "votes": "2"},
  {"internal_count": 4, "name": "Ike", "votes": "2"},
  {"internal_count": 5, "name": "Justin", "votes": "3"},
];

final parentsSnapshot = [
  {
    "family_name": "Bolsak",
    "gapi_user_ids": ["1", "2"]
  },
  {
    "family_name": "Demon",
    "gapi_user_ids": ["3", "4"]
  },
  {
    "family_name": "Affleck",
    "gapi_user_ids": ["5"]
  },
];



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
      home: TasksListPage(title: 'Tasks'),
    );
  }
}
