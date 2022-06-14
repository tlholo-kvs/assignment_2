class Note {
  final String title;
  final String message;
  final String emailAddress;

  const Note({
    required this.title,
    required this.message,
    required this.emailAddress,
  });

  Map<String, Object?> toJson() => {
        'title': title,
        'message': message,
      };

  static Note fromJson(Map<dynamic, dynamic>? json) => Note(
        title: json!['title'] as String,
        message: json['message'] as String,
        emailAddress: json['emailAddress'],
      );

  @override
  bool operator ==(covariant Note other) {
    return (title.toUpperCase().compareTo(other.title.toUpperCase()) == 0);
  }

  @override
  int get hashCode {
    return title.hashCode;
  }
}

Map<dynamic, dynamic> convertNoteListToMap(List<Note> notes) {
  Map<dynamic, dynamic> map = {};
  for (var i = 0; i < notes.length; i++) {
    map.addAll({'$i': notes[i].toJson()});
  }
  return map;
}

List<Note> convertMapToNoteList(Map<dynamic, dynamic> map) {
  List<Note> notes = [];
  for (var i = 0; i < map.length; i++) {
    notes.add(Note.fromJson(map['$i']));
  }
  return notes;
}
