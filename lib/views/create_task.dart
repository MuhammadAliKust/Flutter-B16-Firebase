import 'package:fltuter_b16/models/priority.dart';
import 'package:fltuter_b16/models/task.dart';
import 'package:fltuter_b16/services/priority.dart';
import 'package:fltuter_b16/services/task.dart';
import 'package:flutter/material.dart';

class CreateTaskView extends StatefulWidget {
  CreateTaskView({super.key});

  @override
  State<CreateTaskView> createState() => _CreateTaskViewState();
}

class _CreateTaskViewState extends State<CreateTaskView> {
  TextEditingController titleController = TextEditingController();

  TextEditingController descriptionController = TextEditingController();

  bool isLoading = false;

  List<PriorityModel> priorityList = [];
  PriorityModel? _selectedPriority;

  getPriorities() {
    // PriorityServices().getAllFuturePriorities().then((val) {
    //   priorityList = val;
    //   setState(() {});
    // });
  }

  @override
  void initState() {
    getPriorities();
    super.initState();
  }

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
          DropdownButton(
            items: priorityList
                .map(
                  (priority) => DropdownMenuItem(
                    value: priority,
                    child: Text(priority.name.toString()),
                  ),
                )
                .toList(),
            isExpanded: true,
            hint: Text("Select Priority"),
            value: _selectedPriority,
            onChanged: (val) {
              _selectedPriority = val;
              setState(() {});
            },
          ),
          SizedBox(height: 20),
          isLoading
              ? Center(child: CircularProgressIndicator())
              : ElevatedButton(
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
                      isLoading = true;
                      setState(() {});
                      await TaskServices()
                          .createTask(
                            TaskModel(
                              title: titleController.text,
                              description: descriptionController.text,
                              priorityID: _selectedPriority!.docId,
                              isCompleted: false,
                              createdAt: DateTime.now().millisecondsSinceEpoch,
                            ),
                          )
                          .then((val) {
                            isLoading = false;
                            setState(() {});
                            showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  title: Text("Message"),
                                  content: Text(
                                    "Task has been created successfully",
                                  ),
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                        Navigator.pop(context);
                                      },
                                      child: Text("Okay"),
                                    ),
                                  ],
                                );
                              },
                            );
                          });
                    } catch (e) {
                      isLoading = false;
                      setState(() {});
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
