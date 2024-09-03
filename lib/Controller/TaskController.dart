import 'package:get/get.dart';
import 'package:task2/Model/TaskModel.dart';

class TaskController extends GetxController {
  List<TaskModel> tasks = <TaskModel>[].obs;

// Function to add a new task to the tasks list
  void addTask(String description, String title) {
    tasks.add(TaskModel(description: description, title: title));
  }

// Function to delete a task from the tasks list
  void deleteTask(int id) {
    tasks.removeAt(id);
  }

// Function to change the status of a task (mark it as complete or incomplete)
  void changeStatus(int id) {
    tasks[id].status = !tasks[id].status;
  }
}
