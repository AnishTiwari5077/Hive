import 'package:hive/hive.dart';
import 'package:hive_database/models/note_models.dart';

class Boxes {
  static Box<NoteModels> getData() => Hive.box<NoteModels>('notes');
}
