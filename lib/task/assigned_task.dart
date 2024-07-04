/// # Assigned Task
///
/// Since task can be assigned to multiple users,
/// it should be handled as subcollection under the
/// task document under `assigned`
class AssignedTask {
  String id;
  String taskId;

  /// [status] is the assigned status
  ///
  /// It tells what is the assignee doing with
  /// the assigned task.
  ///
  /// by defaut, it should be todo.
  String status;

  /// [approvalStatus] is the status if the creator
  /// of the task approves the work.
  String approvalStatus;

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
  ///   },
  ///   13333333: {
  ///     comment: 'I have already uploaded the document file. Here is my proof, Mam, as attached. Also I updated the explanation as instructed.',
  ///     urls: [
  ///       'https://example-pic.uploaded-doc.com',
  ///     ]
  ///   }
  /// }
  /// ```
  Map<String, Map<String, String>> comments;

  AssignedTask({
    required this.id,
    required this.taskId,
    required this.status,
    required this.approvalStatus,
    required this.comments,
  });

  AssignedTask.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        taskId = json['taskId'],
        status = json['status'] ?? 'todo',
        approvalStatus = json['approvalStatus'],
        comments = json['comments'] ?? {};
}
