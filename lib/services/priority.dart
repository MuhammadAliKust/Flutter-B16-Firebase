import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fltuter_b16/models/priority.dart';

class PriorityServices {
  ///Stream All Priorities
  Stream<List<PriorityModel>> getAllPriorities() {
    return FirebaseFirestore.instance
        .collection('priorityCollection')
        .snapshots()
        .map(
          (priorityList) => priorityList.docs
              .map(
                (priorityJson) => PriorityModel.fromJson(priorityJson.data()),
              )
              .toList(),
        );
  }
}
