import 'package:fltuter_b16/models/task.dart';
import 'package:fltuter_b16/services/task.dart';
import 'package:flutter/material.dart';

class CreateTaskView extends StatelessWidget {
  CreateTaskView({super.key});

  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Create Task")),
      body: Column(
        children: [
          TextField(controller: titleController),
          SizedBox(height: 20),
          TextField(controller: descriptionController),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () async {
              if (titleController.text.isEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("Title cannot be empty.")),
                );
                return;
              }
              if (descriptionController.text.isEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("Description cannot be empty.")),
                );
                return;
              }
              try {
                await TaskServices()
                    .createTask(
                      TaskModel(
                        title: titleController.text,
                        description: descriptionController.text,
                        isCompleted: false,
                        createdAt: DateTime.now().millisecondsSinceEpoch,
                      ),
                    )
                    .then((val) {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: Text("Message"),
                            content: Text("Task has been created successfully"),
                            actions: [
                              TextButton(onPressed: () {}, child: Text("Okay")),
                            ],
                          );
                        },
                      );
                    });
              } catch (e) {
                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(SnackBar(content: Text(e.toString())));
              }
            },
            child: Text("Create Task"),
          ),
        ],
      ),
    );
  }
}
