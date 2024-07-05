import 'package:cloud_firestore/cloud_firestore.dart';

class Goal {
  String id;
  String title;
  String description;
  String timeframe;
  DateTime startDate;
  DateTime endDate;
  DocumentReference<Map<String, dynamic>> tagIds;
  String status;
  DateTime createdAt;
  DateTime updatedAt;

  Goal({
    required this.id,
    required this.title,
    required this.description,
    required this.timeframe,
    required this.startDate,
    required this.endDate,
    required this.tagIds,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Goal.fromFirestore(DocumentSnapshot doc) {
    Map data = doc.data() as Map;
    return Goal(
      id: doc.id,
      title: data['title'] ?? '',
      description: data['description'] ?? '',
      timeframe: data['timeframe'] ?? '',
      startDate: (data['startDate'] as Timestamp).toDate(),
      endDate: (data['endDate'] as Timestamp).toDate(),
      tagIds: data['tagIds'],
      status: data['status'] ?? '',
      createdAt: (data['createdAt'] as Timestamp).toDate(),
      updatedAt: (data['updatedAt'] as Timestamp).toDate(),
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'title': title,
      'description': description,
      'timeframe': timeframe,
      'startDate': startDate,
      'endDate': endDate,
      'tagIds': tagIds,
      'status': status,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }
}
