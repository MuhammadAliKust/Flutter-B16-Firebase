import 'package:fltuter_b16/models/task.dart';
import 'package:fltuter_b16/services/task.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class GetPriorityTask extends StatelessWidget {
  final String priorityID;

  const GetPriorityTask({super.key, required this.priorityID});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Get Priority Task")),
      body: StreamProvider.value(
        value: TaskServices().getPriorityTask(priorityID),

        initialData: [TaskModel()],
        builder: (context, child) {
          List<TaskModel> taskList = context.watch<List<TaskModel>>();
          return ListView.builder(
            itemCount: taskList.length,
            itemBuilder: (context, i) {
              return ListTile(
                leading: Icon(Icons.task),
                title: Text(taskList[i].title.toString()),
                subtitle: Text(taskList[i].description.toString()),
              );
            },
          );
        },
      ),
    );
  }
}
