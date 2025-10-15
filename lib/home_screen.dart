import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_database/box/boxes.dart';
import 'package:hive_database/models/note_models.dart';
import 'package:hive_database/show_note_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();

  Future<void> _showDialog() {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Add Note'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: titleController,
                  decoration: const InputDecoration(hintText: 'Title'),
                ),

                TextField(
                  controller: descriptionController,
                  decoration: const InputDecoration(hintText: 'Description'),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                titleController.clear();
                descriptionController.clear();
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () async {
                final data = NoteModels(
                  title: titleController.text,
                  description: descriptionController.text,
                );
                final box = Boxes.getData();
                box.add(data);
                data.save();
                titleController.clear();
                descriptionController.clear();

                ShowNoteScreen();
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(centerTitle: true, title: const Text('Hive Database')),
      body: Column(children: []),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await _showDialog();
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
