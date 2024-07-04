import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

// Task Status
// Status about the task if it is currently ongoing (within the schedule) or ended

/// # Task entity class
///
/// This class provides all the functionalities of the entity itself. If the
/// app needs a functionality that is not for the entity itself, it should be
/// served by [TaskService].
///
/// ## Logic
///
/// ### Status (Todo, Ongoing, Review, Done)
///
/// The status of an Entity can be Todo, Ongoing, Review, Done.
/// This indicates the status of what the doer is doing.
///
/// However, a Task can be assigned to multiple people. So the structure
/// of `assigned` field is like...
///
/// ```json
/// {
///   'uid-1': 'todo',
///   'uid-2': 'ongoing',
///   'uid-3': 'review',
///   'uid-4': 'ongoing',
///   'uid-5': 'done',
///   ...
/// }
/// ```
///
/// This allows the task to be assigned to multiple people, as well as
/// recording the status of what the doer is doing to the task.
///
/// ### Approval (Accepted, Rejected)
///
/// For Accepted and Rejected, it is considered a separate status since,
/// it indicates if the assigner has accepted or rejected the task. For short,
/// this is approval.
///
/// There is no need to combine it to the status of what the doer is
/// doing (as above mentioned) because it will be more confusing.
///
/// If the user has completed a task, and is not the creator of the task,
/// it should have a status of `Review`, instead of `Done`. The assigner (or
/// the creator) of the task will approve or reject the task.
///
/// Approved Tasks
///   - They will simply have the status of `Completed`.
///
/// Rejected Tasks
///   - They will have the status of `Todo` but the assigner must
///     write feedback.
class Task {
  static CollectionReference col =
      FirebaseFirestore.instance.collection('tasks');

  /// Document Reference for the Firestore Document
  /// That is `todos/{id}/{...}`
  DocumentReference get doc => col.doc(id);

  String id;
  String? title;
  String? creatorUid;
  Timestamp? createdAt;

  Timestamp? startAt;
  Timestamp? endAt;

  Task({
    required this.id,
    this.title,
    // this.completed = false,
    this.creatorUid,
    this.createdAt,
  });

  factory Task.fromJson(Map<String, dynamic> json, {required String id}) {
    // final assigned = Map<String, TaskStatus>.from(json['assigned']);
    return Task(
      id: id,
      title: json['title'],
      // completed: json['completed'],
      createdAt: json['createdAt'],
    );
  }

  static Task fromSnapshot(QueryDocumentSnapshot<Object?> doc) {
    final data = Map<String, dynamic>.from((doc.data() ?? {}) as Map);
    return Task.fromJson(data, id: doc.id);
  }

  Map<String, dynamic> toJson() => {
        'title': title,
        'creatorUid': creatorUid,
      };

  @override
  String toString() => toJson().toString();

  /// Create a new Task
  ///
  /// This will create a doc in Firestore.
  ///
  /// Returns `Task`.
  static Future<Task> create({
    required String title,
    String? creatorUid,
  }) async {
    final createData = {
      'title': title,
      'creatorUid': creatorUid,
      'createdAt': FieldValue.serverTimestamp(),
    };
    final ref = await col.add(createData);
    return Task(
      id: ref.id,
      title: title,
      creatorUid: creatorUid,
      createdAt: Timestamp.now(),
    );
  }

  /// Update the task fields
  ///
  /// Note: This will not be able to nullify the field.
  Future<Task> update({
    String? title,
    // bool? completed,
    String? creatorUid,
  }) async {
    final updateData = {
      if (title != null) 'title': title,
      if (creatorUid != null) 'creatorUid': creatorUid,
    };

    await doc.update(updateData);

    this.title = title;
    this.creatorUid = creatorUid;
    return this;
  }

  delete() {}

  /// This will get and return the assigned tasks
  getAssigned() {}
}
