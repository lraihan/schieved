import 'package:cloud_firestore/cloud_firestore.dart';

class Task {
  String id;
  String title;
  String description;
  DateTime date;
  List<String> tagIds;
  String priority;
  String status;
  DateTime createdAt;
  DateTime updatedAt;

  Task({
    required this.id,
    required this.title,
    required this.description,
    required this.date,
    required this.tagIds,
    required this.priority,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Task.fromFirestore(DocumentSnapshot doc) {
    Map data = doc.data() as Map;
    return Task(
      id: doc.id,
      title: data['title'] ?? '',
      description: data['description'] ?? '',
      date: (data['date'] as Timestamp).toDate(),
      tagIds: List<String>.from(data['tagIds']),
      priority: data['priority'] ?? '',
      status: data['status'] ?? '',
      createdAt: (data['createdAt'] as Timestamp).toDate(),
      updatedAt: (data['updatedAt'] as Timestamp).toDate(),
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'title': title,
      'description': description,
      'date': date,
      'tagIds': tagIds,
      'priority': priority,
      'status': status,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }
}
