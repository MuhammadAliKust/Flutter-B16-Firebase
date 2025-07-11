import 'package:fltuter_b16/models/priority.dart';
import 'package:fltuter_b16/models/task.dart';
import 'package:fltuter_b16/services/priority.dart';
import 'package:fltuter_b16/services/task.dart';
import 'package:fltuter_b16/views/get_priority_task.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class GetPrioritiesView extends StatelessWidget {
  const GetPrioritiesView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Get Priorities")),
      body: StreamProvider.value(
        value: PriorityServices().getAllPriorities(),
        initialData: [PriorityModel()],
        builder: (context, child) {
          List<PriorityModel> priorityList = context
              .watch<List<PriorityModel>>();
          return ListView.builder(
            itemCount: priorityList.length,
            itemBuilder: (context, i) {
              return ListTile(
                leading: Icon(Icons.task),
                title: Text(priorityList[i].name.toString()),
                trailing: IconButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => GetPriorityTask(
                          priorityID: priorityList[i].docId.toString(),
                        ),
                      ),
                    );
                  },
                  icon: Icon(Icons.arrow_forward),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
