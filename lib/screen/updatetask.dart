import 'package:flutter/material.dart';

class UpdateTask extends StatefulWidget {
  const UpdateTask({super.key});

  @override
  State<UpdateTask> createState() => _UpdateTaskState();
}

class _UpdateTaskState extends State<UpdateTask> {
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
              }),
          title: const Text(
            'Update Task',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
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
                decoration: InputDecoration(
                    icon: const Icon(Icons.title_rounded),
                    hintText: 'Enter the title',
                    labelText: 'Title',
                    hintStyle: const TextStyle(color: Colors.deepPurple),
                    labelStyle: const TextStyle(color: Colors.deepPurple),
                    filled: true,
                    enabled: true,
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.deepPurple),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    enabledBorder: UnderlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide:
                            const BorderSide(color: Colors.deepPurple))),
              ),
              const SizedBox(
                height: 20,
              ),
              TextField(
                keyboardType: TextInputType.multiline,
                maxLines: 10,
                textAlign: TextAlign.start,
                decoration: InputDecoration(
                    hintText: 'Enter description',
                    labelText: 'Description',
                    icon: const Icon(Icons.description_rounded),
                    hintStyle: const TextStyle(color: Colors.deepPurple),
                    labelStyle: const TextStyle(color: Colors.deepPurple),
                    enabled: true,
                    filled: true,
                    enabledBorder: UnderlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: const BorderSide(color: Colors.deepPurple)),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide:
                            const BorderSide(color: Colors.deepPurple))),
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                          elevation: 5,
                          padding: const EdgeInsets.all(10),
                          shape: const BeveledRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                          textStyle: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20),
                          // ignore: deprecated_member_use
                          primary: Colors.deepPurple),
                      child: const Text('Update'))
                ],
              )
            ],
          )),
        ),
      ),
    );
  }
}
