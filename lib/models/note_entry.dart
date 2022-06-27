class NoteEntry {
  Map<dynamic, dynamic> notes;
  String username;
  String? title;
  String? message;
  String? objectId;

  NoteEntry({
    required this.notes,
    required this.username,
    this.message,
    this.title,
    this.objectId,
  });

  Map<String, Object?> toJson() => {
        'username': username,
        'notes': notes,
        'title': title,
        'message': message,
        'objectId': objectId,
      };

  static NoteEntry fromJson(Map<dynamic, dynamic>? json) => NoteEntry(
        username: json!['username'] as String,
        message: json['message'] as String,
        title: json['title'] as String,
        notes: json['notes'],
        objectId: json['objectId'] as String,
      );
}
