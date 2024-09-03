import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:task2/Controller/TaskController.dart';

import 'CustomTaskWidget.dart';
import '../Controller/TaskController.dart';

class DisplayTasks extends StatefulWidget {
  const DisplayTasks({super.key});

  @override
  State<DisplayTasks> createState() => _DisplayTasksState();
}

class _DisplayTasksState extends State<DisplayTasks> {
  @override
  void initState() {
    super.initState();
  }

  TaskController controller = Get.put(TaskController());
  TextEditingController textEditingControllerTitle = TextEditingController();
  TextEditingController textEditingControllerDescription =
      TextEditingController();
  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();

    return Scaffold(
        appBar: AppBar(
            backgroundColor: Colors.deepPurple,
            title: const Text(
              "Tasks",
              style: TextStyle(color: Colors.white),
            ),
            actions: [
              IconButton(
                icon: Icon(
                  Icons.add,
                  color: Colors.white,
                  size: 30,
                ),
                onPressed: () {
                  Get.defaultDialog(
                    title: "Add a New Task",
                    content: Form(
                      key: _formKey, // قم بتعريف مفتاح النموذج
                      child: Column(
                        children: [
                          TextFormField(
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Enter a title';
                              }
                              return null;
                            },
                            controller: textEditingControllerTitle,
                            decoration: InputDecoration(
                                hintText: "Enter title of task"),
                          ),
                          TextFormField(
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Enter a decoration';
                              }
                              return null;
                            },
                            controller: textEditingControllerDescription,
                            decoration: InputDecoration(
                                hintText: "Enter description of task"),
                          ),
                        ],
                      ),
                    ),
                    textConfirm: "Add",
                    textCancel: "Cancel",
                    onConfirm: () {
                      if (_formKey.currentState!.validate()) {
                        controller.addTask(
                          textEditingControllerDescription.text,
                          textEditingControllerTitle.text,
                        );
                        Get.back();
                        print(controller.tasks[0].title);

                        textEditingControllerTitle.clear();
                        textEditingControllerDescription.clear();
                      }
                    },
                    onCancel: () {
                      Get.back();
                      textEditingControllerTitle.clear();
                      textEditingControllerDescription.clear();
                    },
                  );
                },
              ),
            ]),
        body: Obx(() => controller.tasks.isNotEmpty
            ? ListView.builder(
                itemCount: controller.tasks.length,
                itemBuilder: (context, index) {
                  var task = controller.tasks[index];
                  return Column(
                    children: [
                      Dismissible(
                        key: UniqueKey(),
                        background: Container(
                          color: Colors.deepPurple
                              .withOpacity(0.5), // لون الخلفية عند السحب
                          alignment: Alignment.centerRight,
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          child: Icon(Icons.delete,
                              color: Colors.white), // أيقونة الحذف
                        ),
                        direction: DismissDirection
                            .endToStart, // السحب من اليمين لليسار
                        onDismissed: (direction) {
                          controller.deleteTask(index);
                        },
                        child: CustomTaskWidget(
                          title: task.title,
                          description: task.description,
                          status: task.status,
                          id: index,
                        ),
                      ),
                    ],
                  );
                })
            : Center(child: Text("There Are No Task Added Yet"))));
  }
}
