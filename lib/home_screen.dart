import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(centerTitle: true, title: const Text('Hive Database')),
      body: Column(
        children: [
          FutureBuilder(
            future: Hive.openBox('mybox'),
            builder: (context, snapshot) {
              return Text(snapshot.data!.get('name').toString());
            },
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          var box = await Hive.openBox('mybox');

          box.put('name', 'flutter');
          box.put('age', 20);

          print(box.get('name'));
          print(box.get('age'));
          //  box.close();
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
