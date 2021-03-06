import 'package:assignment2_2022/models/note_entry.dart';
import 'package:backendless_sdk/backendless_sdk.dart';
import 'package:flutter/cupertino.dart';

import '../models/note.dart';

class NoteViewModel with ChangeNotifier {
  final noteFormKey = GlobalKey<FormState>();

  NoteEntry? _noteEntry;
  List<Note> _notes = [];
  List<Note> get notes => _notes;

  void emptyNotes() {
    _notes = [];
    notifyListeners();
  }

  Future<String> getNotes(String username) async {
    String result = 'OK';

    DataQueryBuilder queryBuilder = DataQueryBuilder()
      ..whereClause = "username = '$username'";
    notifyListeners();

    List<Map<dynamic, dynamic>?>? map = await Backendless.data
        .of('Note')
        .find(queryBuilder)
        .onError((error, stackTrace) {
      result = error.toString();
    });

    if (result != 'OK') {
      notifyListeners();
      return result;
    }

    if (map != null) {
      if (map.isNotEmpty) {
        _noteEntry = NoteEntry.fromJson(map.first);
        _notes = convertMapToNoteList(_noteEntry!.notes);
        notifyListeners();
      } else {
        emptyNotes();
      }
    } else {
      result = 'NOT OK';
    }

    notifyListeners();
    return result;
  }

  Future<String> saveNewNote(
      String username, String message, String title, bool inUI) async {
    String result = 'OK';

    if (_noteEntry == null) {
      _noteEntry = NoteEntry(
        notes: convertNoteListToMap(_notes),
        username: username,
        message: message,
        title: title,
      );
    } else {
      _noteEntry!.notes = convertNoteListToMap(_notes);
    }

    await Backendless.data
        .of('Note')
        .save(_noteEntry!.toJson())
        .onError((error, stackTrace) {
      result = error.toString();
    });

    return result;
  }

  void createNote(Note note) {
    _notes.insert(0, note);
    notifyListeners();
  }
}
