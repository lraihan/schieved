import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:schieved/app/data/models/tag_model.dart';
import 'package:schieved/app/data/service/base_service.dart';
import 'package:schieved/app/data/shared/shared_variables.dart';

class TagService extends BaseService {
  Future<bool> fetchTags(RxList tagList) async {
    try {
      QuerySnapshot snapshot =
          await FirebaseFirestore.instance.collection('users').doc(userMaster.value.uid ?? '').collection('tags').get();
      tagList.value = snapshot.docs.map((doc) {
        return Tag.fromFirestore(doc);
      }).toList();
      return true;
    } catch (e) {
      debugPrint('error fetchTags : ${e.toString()}');
      return false;
    }
  }
}
