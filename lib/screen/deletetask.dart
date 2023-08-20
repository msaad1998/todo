import 'package:flutter/material.dart';

class DeleteTask extends StatefulWidget {
  const DeleteTask({super.key});

  @override
  State<DeleteTask> createState() => _DeleteTaskState();
}

class _DeleteTaskState extends State<DeleteTask> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('delete task'),
      ),
    );
  }
}
