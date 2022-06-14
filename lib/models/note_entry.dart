class NoteEntry {
  Map<dynamic, dynamic> notes;
  String username;
  String title;
  String message;

  NoteEntry({
    required this.notes,
    required this.username,
    required this.message,
    required this.title,
  });

  Map<String, Object?> toJson() => {
        'username': username,
        'notes': notes,
        'title': title,
        'message': message,
      };

  static NoteEntry fromJson(Map<dynamic, dynamic>? json) => NoteEntry(
        username: json!['username'] as String,
        message: json['message'] as String,
        title: json['title'] as String,
        notes: json['notes'] as Map<dynamic, dynamic>,
      );
}
