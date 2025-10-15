import 'package:hive/hive.dart';

part 'note_models.g.dart';

@HiveType(typeId: 0)
class NoteModels extends HiveObject {
  @HiveField(0)
  String? title;
  @HiveField(1)
  String? description;

  NoteModels({required this.title, required this.description});
}
