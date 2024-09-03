import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';

import '../Controller/TaskController.dart';

class CustomTaskWidget extends StatefulWidget {
  final String title;
  final String description;
  final bool status;
  final int id;

  CustomTaskWidget({
    required this.id,
    required this.title,
    required this.description,
    required this.status,
  });

  @override
  State<CustomTaskWidget> createState() => _CustomTaskWidgetState();
}

class _CustomTaskWidgetState extends State<CustomTaskWidget> {
  final TaskController controller = Get.put(TaskController());

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          subtitle: Text(widget.description, softWrap: true),
          title:
              Text(widget.title, style: TextStyle(fontWeight: FontWeight.bold)),
          trailing: Checkbox(
            value: controller.tasks[widget.id].status,
            onChanged: (bool? value) {
              setState(() {
                controller.changeStatus(widget.id);
              });
            },
          ),
        ),
        Divider()
      ],
    );
  }
}
