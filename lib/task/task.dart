import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

/// # Task Status
///
/// The status of the task that indicates the status of what
/// the doer is doing to it (the task).
enum TaskStatus {
  todo,
  ongoing,
  review,
  done,
}

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

  /// This [assigned] is a Map<{String uid}, TaskStatus>. This
  /// is used to assign and track the statuses of
  Map<String, TaskStatus> assigned;
  // groupId

  /// The status if it is assigned to the current user.
  TaskStatus? get status => assigned[FirebaseAuth.instance.currentUser!.uid];

  /// Check if status is done
  bool get isCompleted => status == TaskStatus.done;

  Task({
    required this.id,
    this.title,
    // this.completed = false,
    this.creatorUid,
    // this.status = TaskStatus.todo,
    this.assigned = const {},
    this.createdAt,
  });

  factory Task.fromJson(Map<String, dynamic> json, {required String id}) {
    // final assigned = Map<String, TaskStatus>.from(json['assigned']);
    return Task(
      id: id,
      title: json['title'],
      // completed: json['completed'],
      creatorUid: json['creatorUid'],
      assigned: _assignedFromMap(json['assigned'] ?? {}),
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
        'assigned': assigned.map((uid, status) => MapEntry(uid, status.name)),
      };

  @override
  String toString() => toJson().toString();

  /// Helper to map the assigned map value from Map<dynamic, String>
  static Map<String, TaskStatus> _assignedFromMap(Object map) =>
      (Map<String, dynamic>.from(map as Map<dynamic, dynamic>))
          .map((uid, e) => MapEntry(uid, TaskStatus.values.byName(e)));

  /// Create a new Task
  ///
  /// This will create a doc in Firestore.
  ///
  /// Returns `Task`.
  static Future<Task> create({
    required String title,
    String? creatorUid,
    TaskStatus status = TaskStatus.todo,
    Map<String, TaskStatus> assigned = const {},
  }) async {
    final createData = {
      'title': title,
      'creatorUid': creatorUid,
      'assigned': assigned.map((uid, status) => MapEntry(uid, status.name)),
      'createdAt': FieldValue.serverTimestamp(),
    };
    final ref = await col.add(createData);
    return Task(
      id: ref.id,
      title: title,
      creatorUid: creatorUid,
      assigned: assigned,
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
    // TaskStatus? status,
    Map<String, TaskStatus>? assigned,
  }) async {
    final updateData = {
      if (title != null) 'title': title,
      if (creatorUid != null) 'creatorUid': creatorUid,
      if (assigned != null) 'assigned': assigned,
    };

    await doc.update(updateData);

    this.title = title;
    //   this.completed = completed ?? this.completed;
    this.creatorUid = creatorUid;
    // this.status = status ?? this.status;
    this.assigned = assigned ?? this.assigned;
    return this;
  }

  /// [updateStatus] updates status in Firestore
  ///
  /// This status is for the current user.
  Future<void> updateStatus(TaskStatus status) async {
    await doc.set({
      'assigned': {
        FirebaseAuth.instance.currentUser!.uid: status.name,
      }
    }, SetOptions(merge: true));
    assigned[FirebaseAuth.instance.currentUser!.uid] = status;
  }

  delete() {}
}
