import 'package:cloud_firestore/cloud_firestore.dart';

class Tag {
  String id;
  String name;
  String color;
  String type;
  DateTime createdAt;
  DateTime updatedAt;

  Tag({
    required this.id,
    required this.name,
    required this.color,
    required this.type,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Tag.fromFirestore(DocumentSnapshot doc) {
    Map data = doc.data() as Map;
    return Tag(
      id: doc.id,
      name: data['name'] ?? '',
      color: data['color'] ?? '',
      type: data['type'] ?? '',
      createdAt: (data['createdAt'] as Timestamp).toDate(),
      updatedAt: (data['updatedAt'] as Timestamp).toDate(),
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'name': name,
      'color': color,
      'type': type,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }
}