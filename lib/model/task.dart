import 'package:cloud_firestore/cloud_firestore.dart';

class Task {
  final String taskName;
  final bool completed;
  final int currentCount;
  final DateTime deadline;
  final String kidId;
  final int maxCount;
  final String parentId;

  final DocumentReference reference;

  Task.fromMap(Map<String, dynamic> map, {this.reference})
      : assert(map['task_name'] != null),
        assert(map['parent_id'] != null),
        taskName = map['task_name'],
        completed = map['completed'],
        currentCount = map['current_count'],
        deadline = DateTime.parse(map['deadline']),
        kidId = map['kid_id'],
        maxCount = map['max_count'],
        parentId = map['parent_id'];

  Task.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data(), reference: snapshot.reference);

  @override
  String toString() =>
      "Task<$taskName:$completed:$currentCount:$deadline:$kidId:$maxCount:$parentId>";
}
