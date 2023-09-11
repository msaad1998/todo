import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart'; // Import the date formatting library

class UpdateTask extends StatefulWidget {
  final int taskIndex;
  final String initialTitle;
  final String initialDescription;

  const UpdateTask({
    Key? key,
    required this.taskIndex,
    required this.initialTitle,
    required this.initialDescription,
  }) : super(key: key);

  @override
  State<UpdateTask> createState() => _UpdateTaskState();
}

class _UpdateTaskState extends State<UpdateTask> {
  late TextEditingController titleController;
  late TextEditingController descriptionController;
  DateTime? selectedDate; // Add a DateTime variable for the due date

  @override
  void initState() {
    super.initState();
    titleController = TextEditingController();
    descriptionController = TextEditingController();

    // Delay the loading of data until controllers are initialized
    Future.delayed(Duration.zero, () {
      loadTaskData();
    });
  }

  Future<void> loadTaskData() async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final List<String>? tasks = prefs.getStringList('tasks');
      if (tasks != null && widget.taskIndex < tasks.length) {
        final taskData = tasks[widget.taskIndex].split('|');
        final String title = taskData[0];
        final String description = taskData[1];

        setState(() {
          titleController.text = title;
          descriptionController.text = description;
        });

        if (taskData.length > 2) {
          final String dueDateStr = taskData[2];
          if (dueDateStr.isNotEmpty) {
            selectedDate = DateTime.parse(dueDateStr);
          }
        }
      }
    } catch (e) {
      // Handle any potential errors when fetching data
      print('Error loading task data: $e');
    }
  }

  Future<void> updateTask() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String newTitle = titleController.text;
    final String newDescription = descriptionController.text;
    final String dueDateStr = selectedDate != null
        ? DateFormat('yyyy-MM-dd').format(selectedDate!)
        : '';

    try {
      final List<String>? tasks = prefs.getStringList('tasks');
      if (tasks != null && widget.taskIndex < tasks.length) {
        tasks[widget.taskIndex] = '$newTitle|$newDescription|$dueDateStr';
        await prefs.setStringList('tasks', tasks);
        print(
            'Task updated successfully: $newTitle, $newDescription, $dueDateStr');

        setState(() {});

        Navigator.pop(context, true); // Signal success to the previous screen
      }
    } catch (e) {
      // Handle any potential errors when updating data
      print('Error updating task: $e');
    }
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    if (pickedDate != null && pickedDate != selectedDate) {
      setState(() {
        selectedDate = pickedDate;
      });
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
          'Update Task',
          style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 136, 94, 209),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            TextFormField(
              controller: titleController,
              decoration: InputDecoration(
                icon: const Icon(Icons.title_rounded),
                hintText: 'Enter the updated title',
                labelText: 'Title',
                filled: true,
                enabled: true,
                iconColor: Colors.deepPurple,
                hintStyle: const TextStyle(color: Colors.deepPurple),
                labelStyle: const TextStyle(color: Colors.deepPurple),
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.deepPurple),
                  borderRadius: BorderRadius.circular(20),
                ),
                enabledBorder: UnderlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: const BorderSide(color: Colors.deepPurple),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            TextField(
              controller: descriptionController,
              keyboardType: TextInputType.multiline,
              maxLines: 10,
              textAlign: TextAlign.start,
              decoration: InputDecoration(
                icon: const Icon(Icons.description_rounded),
                hintText: 'Enter the updated description',
                labelText: 'Description',
                filled: true,
                enabled: true,
                iconColor: Colors.deepPurple,
                hintStyle: const TextStyle(color: Colors.deepPurple),
                labelStyle: const TextStyle(color: Colors.deepPurple),
                enabledBorder: UnderlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: const BorderSide(color: Colors.deepPurple),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: const BorderSide(color: Colors.deepPurple),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    _selectDate(context); // Show date picker
                  },
                  style: ElevatedButton.styleFrom(
                    elevation: 5,
                    padding: EdgeInsets.all(10),
                    primary: Colors.deepPurple,
                    shape: const BeveledRectangleBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      ),
                    ),
                    textStyle: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  child: const Text('Pick Due Date'),
                ),
                // Add spacing between buttons
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(
                  onPressed: () {
                    updateTask();
                  },
                  style: ElevatedButton.styleFrom(
                    elevation: 5,
                    padding: EdgeInsets.all(10),
                    primary: Colors.deepPurple,
                    shape: const BeveledRectangleBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      ),
                    ),
                    textStyle: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  child: const Text('Update'),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            if (selectedDate != null) // Show selected date if available
              Text(
                'Due Date: ${DateFormat('yyyy-MM-dd').format(selectedDate!)}',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.deepPurple,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
