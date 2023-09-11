import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CreateTask extends StatefulWidget {
  const CreateTask({Key? key}) : super(key: key);

  @override
  State<CreateTask> createState() => _CreateTaskState();
}

class _CreateTaskState extends State<CreateTask> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  DateTime? selectedDate; // Store the selected date

  Future<void> saveTask() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String title = titleController.text;
    final String description = descriptionController.text;
    final String dueDate = selectedDate != null
        ? '${selectedDate!.year}-${selectedDate!.month}-${selectedDate!.day}' // Format the date as 'YYYY-MM-DD'
        : '';

    // Create a unique key for each task (you can use a counter or timestamp)
    final String taskKey = DateTime.now().toString();

    final String taskData = '$title|$description|$dueDate';

    // Retrieve existing tasks or create an empty list
    final List<String> existingTasks =
        prefs.getStringList('tasks') ?? <String>[];

    // Add the new task data to the list
    existingTasks.add(taskData);

    // Store the updated task list in shared preferences
    await prefs.setStringList('tasks', existingTasks);
  }

  // Function to show date picker
  Future<void> _selectDate(BuildContext context) async {
    final DateTime picked = (await showDatePicker(
      context: context,
      initialDate: selectedDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    ))!;

    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          leading: BackButton(
            color: Colors.black,
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: const Text(
            'Create Task',
            style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
          backgroundColor: const Color.fromARGB(255, 136, 94, 209),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(10),
          child: Form(
            child: Column(
              children: [
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  controller: titleController,
                  decoration: InputDecoration(
                    icon: const Icon(Icons.title_rounded),
                    hintText: 'Enter the title',
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
                    hintText: 'Enter description',
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
                  height: 30,
                ),
                // Date picker button
                ElevatedButton(
                  onPressed: () => _selectDate(context),
                  child: Text(
                    selectedDate == null
                        ? 'Select Due Date'
                        : 'Due Date: ${selectedDate!.toLocal()}'.split(' ')[0],
                  ),
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
                ),

                // Save button
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        saveTask();
                        Navigator.pop(context);
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
                      child: const Text('Save'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
