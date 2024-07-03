import 'package:cloud_firestore/cloud_firestore.dart';

/// # Task Status
///
/// The status of the task that indicates the status of what
/// the doer is doing to it (the task).
enum TaskStatus {
  todo,
  ongoing,
  review,
  completed,
}

/// # Task entity class
///
/// This class provides all the functionalities of the entity itself. If the
/// app needs a functionality that is not for the entity itself, it should be
/// served by [TaskService].
///
/// ## Logic
///
/// ### Status (Todo, Ongoing, Review, Completed)
///
/// The status of an Entity can be Todo, Ongoing, Review, Completed.
/// This indicates the status of what the doer is doing.
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
/// it will have a status of `Review`, instead of `Completed`. The assigner (or
/// the creator) of the task will approve or reject the task.
///
/// Approved Tasks
///   - They will simply have the status of `Completed`.
///
/// Rejected Tasks
///   - They will have the status of `Todo` but the assigner must
///     write feedback.
class Task {
  final CollectionReference col =
      FirebaseFirestore.instance.collection('tasks');

  String? title;
  bool completed;

  Task({
    this.title,
    this.completed = false,
  });

  Task.fromJson(Map<String, dynamic> json)
      : title = json['title'],
        completed = json['completed'];

  Map<String, dynamic> toJson() => {
        'title': title,
        'completed': completed,
      };

  create() {}

  update() {}

  delete() {}
}
