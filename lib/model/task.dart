import 'package:cloud_firestore/cloud_firestore.dart';

class Task {
  String taskName;
  bool completed;
  int currentCount;
  DateTime deadline;
  String kidId;
  int maxCount;
  int actualCount;
  String parentId;
  String prize;

  final DocumentReference reference;

  bool isDeadline() {
    return maxCount == null;
  }

  Task.fromMap(Map<String, dynamic> map, {this.reference})
      : assert(map['task_name'] != null),
        assert(map['parent_id'] != null),
        taskName = map['task_name'],
        completed = map['completed'],
        currentCount = map['current_count'],
        deadline = DateTime.parse(map['deadline']),
        kidId = map['kid_id'],
        maxCount = map['max_count'],
        actualCount = map['actual_count'],
        parentId = map['parent_id'],
        prize = map['prize'];

  Task.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data(), reference: snapshot.reference);

  @override
  String toString() =>
      "Task<$taskName:$completed:$currentCount:$deadline:$kidId:$maxCount:$parentId:$prize>";
}
