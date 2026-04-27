import 'package:flutter/material.dart';
import 'dart:io';

import 'add_task_screen.dart';
import 'api_screen.dart';
import '../models/task.dart';
import '../services/storage_service.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Task> tasks = [];

  @override
  void initState() {
    super.initState();
    loadTasks();
  }

  // Load tasks from storage
  void loadTasks() async {
    tasks = await StorageService.loadTasks();
    setState(() {});
  }

  // Add task
  void addTask() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => AddTaskScreen()),
    );

    if (result != null) {
      Task newTask = Task(
        title: result['title'],
        imagePath: result['imagePath'],
      );

      tasks.add(newTask);

      await StorageService.saveTasks(tasks);

      setState(() {});

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Task Saved")));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Task Manager')),

      body: Column(
        children: [
          SizedBox(height: 10),

          ElevatedButton(onPressed: addTask, child: Text("Add Task")),

          SizedBox(height: 10),

          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ApiScreen()),
              );
            },
            child: Text("View API Data"),
          ),

          SizedBox(height: 10),

          Expanded(
            child: tasks.isEmpty
                ? Center(child: Text("No tasks yet"))
                : ListView.builder(
                    itemCount: tasks.length,
                    itemBuilder: (context, index) {
                      return Card(
                        margin: EdgeInsets.all(8),
                        child: ListTile(
                          title: Text(tasks[index].title),
                          subtitle: tasks[index].imagePath != null
                              ? Image.file(
                                  File(tasks[index].imagePath!),
                                  height: 100,
                                )
                              : null,
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
