import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:schieved/app/data/service/base_service.dart';
import 'package:schieved/app/data/shared/shared_variables.dart';

class TaskService extends BaseService {
  Future<bool> addTask() async {
    try {
      await BaseService.firebase.collection('users').doc(userMaster.value.uid ?? '').collection('tasks').add({
        'title': 'AQWERTY',
        'description': 'just to populate the collections',
        'createdAt': Timestamp.now(),
        'updatedAt': Timestamp.now(),
        'date': Timestamp.now(),
        'priority': 'high',
        'status': 'open',
        'tagIds': ['sRdnYnxpDvKdQMZNcT5z', 'ezIbzw32Y0LHxZkSnerm']
      });
      return true;
    } catch (e) {
      debugPrint('Error addTask : ${e.toString()}');
      return false;
    }
  }

  Future<bool> updateTask() async {
    try {
      await BaseService.firebase.collection('users').doc(userMaster.value.uid ?? '').collection('tasks').doc().update({
        'priority': 'high',
        'status': 'open',
      });
      return true;
    } catch (e) {
      debugPrint('Error updateTask : ${e.toString()}');
      return false;
    }
  }

  Future<bool> taskChangeStatus(String id, String status) async {
    try {
      if (status == 'open') {
        await FirebaseFirestore.instance
            .collection('users')
            .doc(userMaster.value.uid ?? '')
            .collection('tasks')
            .doc(id)
            .update({'status': 'done'});
      } else {
        await FirebaseFirestore.instance
            .collection('users')
            .doc(userMaster.value.uid ?? '')
            .collection('tasks')
            .doc(id)
            .update({'status': 'open'});
      }
      return true;
    } catch (e) {
      debugPrint('Error overdueTaskChangeStatus : ${e.toString()}');
      return false;
    }
  }
}
