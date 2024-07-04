import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:model_house/model_house.dart';

/// # Assignee Status
///
/// The status of the task that indicates the status of what
/// the doer is doing to it (the task).
///
/// Answers the question what is the assignee doing with the task,
/// Or how is the assignee doing with the task.
class AssigneeStatus {
  static const String todo = 'todo';
  static const String paused = 'paused';
  static const String ongoing = 'ongoing';
  static const String review = 'review';
  static const String ended = 'ended';
}

/// # Assigned Task
///
/// Since task can be assigned to multiple users,
/// it should be handled as subcollection under the
/// task document under `assigned`
class AssignedTask {
  static const subcollectionName = 'assigned';

  // CollectionReference get subCol =>
  //     Task.col.doc(taskId).collection(subcollectionName);

  static CollectionReference subCol(String taskId) =>
      Task.col.doc(taskId).collection(subcollectionName);

  static Query<Map<String, dynamic>> colGroup =
      FirebaseFirestore.instance.collectionGroup(subcollectionName);

  /// Document Reference for the Firestore Document
  /// That is `todos/{id}/{...}`
  DocumentReference get doc => subCol(taskId).doc(id);

  /// [id] is the key of the assigned task in the firestore.
  String id;

  /// [taskId] is the id of the task.
  ///
  /// Since assigned task are subcollection,
  /// we have to save the taskId here.
  String taskId;

  /// the user uid who assigned the task.
  String assignerUid;

  /// the user uid who is assigned to the task
  /// or the user that was chosen by the assigner
  /// to do the task.
  String assigneeUid;

  /// [status] is the assigned status. The value
  /// should be from `AssigneeStatus`.
  ///
  /// It tells what is the assignee doing with
  /// the assigned task.
  ///
  /// by defaut, it should be todo.
  String status;

  /// [approvalStatus] is the status if the creator
  /// of the task approves the work.
  String? approvalStatus;

  Timestamp? createdAt;

  // TODO review
  /// [comments] is for feedbacks
  ///
  /// This can be used by task's creator's request to enhance
  /// the work of the assignee to the task. Assignee can
  /// reply as well to explain or show proof.
  ///
  /// Example:
  ///
  /// ```json
  /// comments: {
  ///   123123123: {
  ///     comment: 'This needs a different output. Update the title. Revised the explanation. Upload document file.',
  ///     uid: 'uid-creator'
  ///   },
  ///   13333333: {
  ///     comment: 'I have already uploaded the document file. Here is my proof, Mam, as attached. Also I updated the explanation as instructed.',
  ///     urls: [
  ///       'https://example-pic.uploaded-doc.com',
  ///     ],
  ///     uid: 'uid-assignee'
  ///   }
  /// }
  /// ```
  Map<String, Map<String, String>> comments;

  AssignedTask({
    required this.id,
    required this.taskId,
    required this.assignerUid,
    required this.assigneeUid,
    required this.status,
    this.approvalStatus,
    required this.comments,
    required this.createdAt,
  });

  AssignedTask.fromJson(Map<String, dynamic> json, {required this.id})
      : taskId = json['taskId'],
        assignerUid = json['assignerUid'],
        assigneeUid = json['assigneeUid'],
        status = json['status'] ?? 'todo',
        approvalStatus = json['approvalStatus'],
        comments = Map<String, Map<String, String>>.from(
            (json['comments'] ?? {}) as Map<dynamic, dynamic>),
        createdAt = json['createdAt'];

  static AssignedTask fromSnapshot(QueryDocumentSnapshot<Object?> doc) {
    final data = Map<String, dynamic>.from((doc.data() ?? {}) as Map);
    return AssignedTask.fromJson(data, id: doc.id);
  }

  /// This will assign a task to a user
  static Future<AssignedTask> create({
    required String taskId,
    required String uid,
    String status = AssigneeStatus.todo,
  }) async {
    final subCol = Task.col.doc(taskId).collection(subcollectionName);

    final myUid = FirebaseAuth.instance.currentUser!.uid;

    final createData = {
      'taskId': taskId,
      'assignerUid': myUid,
      'assigneeUid': uid,
      'status': status,
      'comments': {},
      'createdAt': FieldValue.serverTimestamp(),
    };

    final ref = await subCol.add(createData);
    return AssignedTask(
      id: ref.id,
      taskId: taskId,
      assignerUid: myUid,
      assigneeUid: uid,
      status: status,
      comments: {},
      createdAt: Timestamp.now(),
    );
  }
}
