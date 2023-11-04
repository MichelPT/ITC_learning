import 'package:belajar_getx/controller.dart';
import 'package:belajar_getx/name_list.dart';
import 'package:belajar_getx/setname.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class ListPage extends StatelessWidget {
  ListPage({super.key});

  final NameController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Obx(() => Text(
                  controller.controlName.value,
                  style: TextStyle(fontSize: 48),
                )),
            ElevatedButton(
                onPressed: () => Get.to(() => SetName()),
                child: const Text('Set')),
            ElevatedButton(
                onPressed: () => Get.to(() => NamesList()),
                child: const Text('Name\'s List'))
          ],
        ),
      ),
    ));
  }
}
