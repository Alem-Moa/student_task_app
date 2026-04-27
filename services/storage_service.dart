import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/task.dart';

class StorageService {
  static const String key = "tasks";

  // Save tasks
  static Future<void> saveTasks(List<Task> tasks) async {
    final prefs = await SharedPreferences.getInstance();

    List<String> jsonList =
        tasks.map((task) => jsonEncode(task.toJson())).toList();

    await prefs.setStringList(key, jsonList);
  }

  // Load tasks
  static Future<List<Task>> loadTasks() async {
    final prefs = await SharedPreferences.getInstance();

    List<String>? jsonList = prefs.getStringList(key);

    if (jsonList == null) return [];

    return jsonList
        .map((item) => Task.fromJson(jsonDecode(item)))
        .toList();
  }
}