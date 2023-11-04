import 'package:belajar_getx/controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class NamesList extends StatelessWidget {
  NamesList({super.key});

  final NameController controller = Get.find();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: Obx(() => ListView.builder(
              itemCount: controller.controlNames.length,
                  itemBuilder: (context, index) {
                    return Text(
                        controller.controlNames[index].toString());
                  },
                ))));
  }
}
