import 'package:cloud_firestore/cloud_firestore.dart';

enum Status {
  todo,
  ongoing,
  done,
}

/// To-do model class
///
///
///
class Todo {
  static CollectionReference col =
      FirebaseFirestore.instance.collection('todos');

  DocumentReference get doc =>
      FirebaseFirestore.instance.collection('todos').doc(key);

  String key;
  String? title;
  // bool completed;
  String? creatorUid;
  // groupId
  Status status;

  Todo({
    required this.key,
    this.title,
    // this.completed = false,
    this.creatorUid,
    this.status = Status.todo,
  });

  Todo.fromJson(Map<String, dynamic> json, this.key)
      : title = json['title'],
        // completed = json['completed']
        creatorUid = json['creatorUid'],
        status = json['status'] == null
            ? Status.todo
            : Status.values.byName(json['status']);

  Map<String, dynamic> toJson() => {
        'title': title,
        // 'completed': completed,
        'creatorUid': creatorUid,
        'status': status.name,
      };

  static create({
    required String title,
    required String creatorUid,
    Status status = Status.todo,
  }) async {
    final createData = {
      'title': title,
      // 'completed': false,
      'creatorUid': creatorUid,
      'status': status.name,
    };
    final ref = await col.add(createData);
    return Todo(
      key: ref.id,
      title: title,
      creatorUid: creatorUid,
      status: status,
    );
  }

  /// [updateStatus] updates status in Firestore and model.
  void updateStatus(Status status) {
    doc.update({'status': status.name});
    this.status = status;
  }
}
