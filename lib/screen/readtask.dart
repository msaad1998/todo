import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ReadTask extends StatefulWidget {
  const ReadTask({Key? key}) : super(key: key);

  @override
  State<ReadTask> createState() => _ReadTaskState();
}

class _ReadTaskState extends State<ReadTask> {
  List<String> tasks = [];

  @override
  void initState() {
    super.initState();
    loadTasks();
  }

  Future<void> loadTasks() async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final List<String>? savedTasks = prefs.getStringList('tasks');
      if (savedTasks != null) {
        setState(() {
          tasks = savedTasks;
        });
      }
    } catch (e) {
      // Handle any potential errors when fetching data
      print('Error loading tasks: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
          color: Colors.black,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          'Read Tasks',
          style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 136, 94, 209),
      ),
      body: ListView.builder(
        itemCount: tasks.length,
        itemBuilder: (context, index) {
          final taskData = tasks[index].split('|');
          final title = taskData[0];
          final description = taskData[1];
          String date = ''; // Default value for date

          // Check if there's a date in taskData and set it
          if (taskData.length > 2) {
            date = taskData[2];
          }

          return Container(
            margin: EdgeInsets.all(10),
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Colors.deepPurple, width: 1.5),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Title: $title',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'Description: $description',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                    color: Colors.brown,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'Due Date: $date',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.deepPurple,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
