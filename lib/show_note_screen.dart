import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_database/models/note_models.dart';
import 'package:hive_flutter/adapters.dart';

class ShowNoteScreen extends StatefulWidget {
  const ShowNoteScreen({super.key});

  @override
  State<ShowNoteScreen> createState() => _ShowNoteScreenState();
}

class _ShowNoteScreenState extends State<ShowNoteScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('My Notes')),
      // Use ValueListenableBuilder to listen for changes in the 'notes' box
      body: ValueListenableBuilder<Box<NoteModels>>(
        valueListenable: Hive.box<NoteModels>('notes').listenable(),
        builder: (context, box, _) {
          // Get all the notes as a list
          final notes = box.values.toList();

          if (notes.isEmpty) {
            return const Center(child: Text('No notes yet. Add some!'));
          }

          return ListView.builder(
            itemCount: notes.length,
            itemBuilder: (context, index) {
              final note = notes[index];
              return ListTile(
                title: Text(note.title.toString()),
                subtitle: Text(note.description.toString()),
                trailing: IconButton(
                  icon: const Icon(Icons.delete, color: Colors.red),
                  onPressed: () {
                    // You can also use note.delete() if NoteModels extends HiveObject
                    box.deleteAt(index);
                  },
                ),
                onTap: () {
                  // Optional: Navigate to a detail screen
                },
              );
            },
          );
        },
      ),
    );
  }
}
