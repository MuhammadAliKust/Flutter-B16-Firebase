import 'package:fltuter_b16/models/priority.dart';
import 'package:fltuter_b16/services/priority.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class GetAllPriorities extends StatelessWidget {
  const GetAllPriorities({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Get All Priorities"),
      ),
      body: StreamProvider.value(
        value: PriorityServices().getAllPriorities(),
        initialData: [PriorityModel()],
        builder: (context, child) {
          List<PriorityModel> priorityList = context.watch<List<PriorityModel>>();
          return ListView.builder(
            itemCount: priorityList.length,
            itemBuilder: (context, i) {
              return ListTile(
                leading: Icon(Icons.task),
                title: Text(priorityList[i].name.toString()),
                  );
            },
          );
        },
      ),
    );
  }
}

