import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DeleteTask extends StatefulWidget {
  const DeleteTask({Key? key}) : super(key: key);

  @override
  State<DeleteTask> createState() => _DeleteTaskState();
}

class _DeleteTaskState extends State<DeleteTask> {
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

  // Function to delete a task by its index
  void deleteTask(int index) async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      setState(() {
        tasks.removeAt(index);
        prefs.setStringList('tasks', tasks);
      });
    } catch (e) {
      // Handle any potential errors when deleting data
      print('Error deleting task: $e');
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
          'Delete Tasks',
          style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
        ),
        backgroundColor: const Color.fromARGB(255, 136, 94, 209),
      ),
      body: tasks.isEmpty
          ? Center(
              child: Text('No tasks to delete'),
            )
          : ListView.builder(
              itemCount: tasks.length,
              itemBuilder: (context, index) {
                final task = tasks[index];
                final taskData = task.split('|');

                if (taskData.length >= 2) {
                  final title = taskData[0];
                  final description = taskData[1];
                  final date = taskData.length > 2 ? taskData[2] : 'No Date';

                  return Container(
                    margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.deepPurple, width: 1.5),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          'Title: $title',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          'Description: $description',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                            color: Colors.brown,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          'Date: $date',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.deepPurple,
                          ),
                        ),
                        SizedBox(height: 8),
                        IconButton(
                          icon: Icon(Icons.delete),
                          onPressed: () {
                            deleteTask(index);
                          },
                        ),
                      ],
                    ),
                  );
                } else {
                  // Handle tasks with invalid data structure here
                  return Text('Invalid task data');
                }
              },
            ),
    );
  }
}
