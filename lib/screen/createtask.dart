import 'package:flutter/material.dart';

class CreateTask extends StatefulWidget {
  const CreateTask({super.key});

  @override
  State<CreateTask> createState() => _CreateTaskState();
}

class _CreateTaskState extends State<CreateTask> {
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
            'Create Task',
            style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
          backgroundColor: const Color.fromARGB(255, 136, 94, 209),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(10),
          child: Form(
            child: Column(children: [
              const SizedBox(
                height: 20,
              ),
              TextFormField(
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
                        borderSide:
                            const BorderSide(color: Colors.deepPurple))),
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                //crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.end,

                children: [
                  ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                          elevation: 5,
                          padding: EdgeInsets.all(10),
                          // ignore: deprecated_member_use
                          primary: Colors.deepPurple,
                          shape: const BeveledRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                          textStyle: const TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold)),
                      child: const Text(
                        'Save',
                      )),
                ],
              )
            ]),
          ),
        ),
      ),
    );
  }
}
