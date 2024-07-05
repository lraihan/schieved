import 'package:cloud_firestore/cloud_firestore.dart';

class Note {
  String id;
  String title;
  String textContent;
  List<ImageAttachment> images;
  List<VoiceNote> voiceNotes;
  DocumentReference<Map<String, dynamic>> tagIds;
  DateTime createdAt;
  DateTime updatedAt;

  Note({
    required this.id,
    required this.title,
    required this.textContent,
    required this.images,
    required this.voiceNotes,
    required this.tagIds,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Note.fromFirestore(DocumentSnapshot doc) {
    Map data = doc.data() as Map;
    return Note(
      id: doc.id,
      title: data['title'] ?? '',
      textContent: data['textContent'] ?? '',
      images: (data['attachments']['images'] as List)
          .map((item) => ImageAttachment.fromMap(item))
          .toList(),
      voiceNotes: (data['attachments']['voiceNotes'] as List)
          .map((item) => VoiceNote.fromMap(item))
          .toList(),
      tagIds: data['tagIds'],
      createdAt: (data['createdAt'] as Timestamp).toDate(),
      updatedAt: (data['updatedAt'] as Timestamp).toDate(),
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'title': title,
      'textContent': textContent,
      'attachments': {
        'images': images.map((image) => image.toMap()).toList(),
        'voiceNotes': voiceNotes.map((voiceNote) => voiceNote.toMap()).toList(),
      },
      'tagIds': tagIds,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }
}

class ImageAttachment {
  String url;
  String description;

  ImageAttachment({required this.url, required this.description});

  factory ImageAttachment.fromMap(Map data) {
    return ImageAttachment(
      url: data['url'],
      description: data['description'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'url': url,
      'description': description,
    };
  }
}

class VoiceNote {
  String url;
  String description;

  VoiceNote({required this.url, required this.description});

  factory VoiceNote.fromMap(Map data) {
    return VoiceNote(
      url: data['url'],
      description: data['description'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'url': url,
      'description': description,
    };
  }
}