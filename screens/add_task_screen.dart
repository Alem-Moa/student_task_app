import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class AddTaskScreen extends StatefulWidget {
  @override
  _AddTaskScreenState createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  TextEditingController controller = TextEditingController();

  File? image;
  final ImagePicker picker = ImagePicker();

  // Pick image from camera
  Future<void> pickImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.camera);

    if (pickedFile != null) {
      setState(() {
        image = File(pickedFile.path);
      });
    }
  }

  // Save task
  void saveTask() {
    String task = controller.text;

    if (task.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Please enter a task")));
      return;
    }

    Navigator.pop(context, {'title': task, 'imagePath': image?.path});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Add Task')),

      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: controller,
              decoration: InputDecoration(
                labelText: "Enter Task",
                border: OutlineInputBorder(),
              ),
            ),

            SizedBox(height: 10),

            ElevatedButton(onPressed: pickImage, child: Text("Take Photo")),

            SizedBox(height: 10),

            image != null
                ? Image.file(image!, height: 150)
                : Text("No image selected"),

            SizedBox(height: 10),

            ElevatedButton(onPressed: saveTask, child: Text("Save Task")),
          ],
        ),
      ),
    );
  }
}
