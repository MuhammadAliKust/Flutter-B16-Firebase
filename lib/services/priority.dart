import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/priority.dart';

class PriorityServices {
  ///Get All Priorities
  Stream<List<PriorityModel>> getAllPriorities() {
    return FirebaseFirestore.instance
        .collection('priorityCollection')
        .snapshots()
        .map(
          (taskList) => taskList.docs
              .map((taskJson) => PriorityModel.fromJson(taskJson.data()))
              .toList(),
        );
  }

  ///Get All Priorities
  Future<List<PriorityModel>> getAllFuturePriorities() {
    return FirebaseFirestore.instance
        .collection('priorityCollection')
        .get()
        .then(
          (taskList) => taskList.docs
              .map((taskJson) => PriorityModel.fromJson(taskJson.data()))
              .toList(),
        );
  }
}
