import 'package:fltuter_b16/models/task.dart';
import 'package:fltuter_b16/services/task.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class GetInCompletedTaskView extends StatelessWidget {
  const GetInCompletedTaskView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Get In Completed Task")),
      body: StreamProvider.value(
        value: TaskServices().getInCompletedTask(),
        initialData: [TaskModel()],
        builder: (context, child) {
          List<TaskModel> taskList = context.watch<List<TaskModel>>();
          return ListView.builder(
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
