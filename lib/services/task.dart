import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fltuter_b16/models/task.dart';

class TaskServices {
  ///Create Task
  Future createTask(TaskModel model) async {
    DocumentReference docRef = FirebaseFirestore.instance
        .collection('taskCollection')
        .doc();
    return await FirebaseFirestore.instance
        .collection('taskCollection')
        .doc(docRef.id)
        .set(model.toJson(docRef.id));
  }

  ///Update Task
  Future updateTask(TaskModel model) async {
    return await FirebaseFirestore.instance
        .collection('taskCollection')
        .doc(model.docId)
        .update({"title": model.title, "description": model.description});
  }

  ///Delete Task
  Future deleteTask(String taskID) async {
    return await FirebaseFirestore.instance
        .collection('taskCollection')
        .doc(taskID)
        .delete();
  }

  ///Mark Task as Complete
  Future markTaskAsComplete(String taskID) async {
    return await FirebaseFirestore.instance
        .collection('taskCollection')
        .doc(taskID)
        .update({'isCompleted': true});
  }

  ///Get All Task
  Stream<List<TaskModel>> getAllTask() {
    return FirebaseFirestore.instance
        .collection('taskCollection')
        .snapshots()
        .map(
          (taskList) => taskList.docs
              .map((taskJson) => TaskModel.fromJson(taskJson.data()))
              .toList(),
        );
  }

  ///Get Completed Task
  Stream<List<TaskModel>> getCompletedTask() {
    return FirebaseFirestore.instance
        .collection('taskCollection')
        .where('isCompleted', isEqualTo: true)
        .snapshots()
        .map(
          (taskList) => taskList.docs
              .map((taskJson) => TaskModel.fromJson(taskJson.data()))
              .toList(),
        );
  }

  ///Get InCompleted Task
  Stream<List<TaskModel>> getInCompletedTask() {
    return FirebaseFirestore.instance
        .collection('taskCollection')
        .where('isCompleted', isEqualTo: false)
        .snapshots()
        .map(
          (taskList) => taskList.docs
              .map((taskJson) => TaskModel.fromJson(taskJson.data()))
              .toList(),
        );
  }
}
