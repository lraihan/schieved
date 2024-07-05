import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:schieved/app/data/service/base_service.dart';
import 'package:schieved/app/data/shared/shared_variables.dart';

class StreamService extends BaseService {
  Stream<QuerySnapshot<Object?>>? taskStream(DateTime start, DateTime end) {
    return BaseService.firebase
        .collection('users')
        .doc(userMaster.value.uid ?? '')
        .collection('tasks')
        .where('date', isGreaterThanOrEqualTo: start, isLessThanOrEqualTo: end)
        .snapshots();
  }
}
