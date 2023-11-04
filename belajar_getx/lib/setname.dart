import 'package:belajar_getx/controller.dart';
import 'package:belajar_getx/main_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class SetName extends StatelessWidget {
  SetName({super.key});

  final NameController controller = Get.find();

  final TextEditingController nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    GetStorage box = GetStorage();
    return Scaffold(
      body: Center(
          child: Column(
        children: [
          TextFormField(
            controller: nameController,
          ),
          const SizedBox(
            height: 20,
          ),
          ElevatedButton(
              onPressed: () {
                controller.saveName(nameController.text);
                Get.back();
              },
              child: const Text('Send'))
        ],
      )),
    );
  }
}
