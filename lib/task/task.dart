import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:model_house/task/assigned_task.dart';

// Task Status
// Status about the task if it is currently ongoing (within the schedule) or ended

/// # Task entity class
///
/// TODO revise everything
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
  static const collectionName = 'tasks';

  /// Collection Reference for the Firestore Collection
  static CollectionReference col =
      FirebaseFirestore.instance.collection(collectionName);

  /// Document Reference for the Firestore Document
  /// That is `todos/{id}/{...}`
  DocumentReference get doc => col.doc(id);

  CollectionReference get assignedSubCol =>
      doc.collection(AssignedTask.subcollectionName);

  String id;
  String? title;
  String? description;
  String? creatorUid;
  Timestamp? createdAt;
  Timestamp? startAt;
  Timestamp? endAt;

  // TODO
  // String get status {}

  Task({
    required this.id,
    this.title,
    this.description,
    this.creatorUid,
    this.createdAt,
    this.startAt,
    this.endAt,
  });

  factory Task.fromJson(Map<String, dynamic> json, {required String id}) {
    return Task(
      id: id,
      title: json['title'],
      description: json['description'],
      createdAt: json['createdAt'],
      creatorUid: json['creatorUid'],
      startAt: json['startAt'],
      endAt: json['endAt'],
    );
  }

  static Task fromSnapshot(QueryDocumentSnapshot<Object?> doc) {
    final data = Map<String, dynamic>.from((doc.data() ?? {}) as Map);
    return Task.fromJson(data, id: doc.id);
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'description': description,
        'creatorUid': creatorUid,
        'createdAt': createdAt,
        'startAt': startAt,
        'endAt': endAt,
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
    String? description,
  }) async {
    final creatorUid = FirebaseAuth.instance.currentUser?.uid;
    final createData = {
      'title': title,
      'description': description,
      'creatorUid': creatorUid,
      'createdAt': FieldValue.serverTimestamp(),
    };
    final ref = await col.add(createData);
    AssignedTask.create(
      taskId: ref.id,
      uid: creatorUid!,
    );
    return Task(
      id: ref.id,
      title: title,
      description: description,
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
  // Future<List<AssignedTask>>
  getAssignee() {}

  /// Create a new Assigned Task for each uid
  // Future<List<AssignedTask>>
  assign({required List<String> uids}) {
    // TODO
  }
}
