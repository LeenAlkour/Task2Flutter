class TaskModel {
  late String description;
  late String title;
  late bool status;
  TaskModel(
      {required this.description, this.status = false, required this.title});
}
