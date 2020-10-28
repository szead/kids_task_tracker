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

  // Task(this.taskName,
  //     {this.completed,
  //     this.currentCount,
  //     this.deadline,
  //     this.kidId,
  //     this.maxCount,
  //     this.parentId,
  //     this.reference});

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

  // factory Task.fromJson(Map<dynamic, dynamic> json) => _TaskFromJson(json);
  //
  // Map<String, dynamic> toJson() => _TaskToJson(this);
  //
  // @override
  String toString() => "Task<$taskName:$completed:$currentCount>";
}

// _TaskFromJson(Map<dynamic, dynamic> json) {
//   return Task(json['task_name'] as String,
//       completed: json['completed'],
//       currentCount: json['current_count'],
//       deadline: json['deadline'],
//       kidId: json['kid_id'],
//       maxCount: json["max_count"],
//       parentId: json["parent_id"]);
// }
//
// Map<String, dynamic> _TaskToJson(Task instance) => <String, dynamic>{
//       'task_name': instance.taskName,
//       'completed': instance.completed,
//       'current_count': instance.currentCount,
//       'deadline': instance.deadline,
//       'kid_id': instance.kidId,
//       'max_count': instance.maxCount,
//       'parent_id': instance.parentId
//     };
