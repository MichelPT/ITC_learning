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
    return Column(
      children: [
        TextFormField(
          controller: nameController,
          decoration: InputDecoration(
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(30))),
        ),
        const SizedBox(
          height: 20,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
        ElevatedButton(
            onPressed: () {
              controller.saveName(nameController.text);
              Get.back();
            },
            child: const Text('Simpan')),
            ElevatedButton(
            onPressed: () {
              controller.resetList();
              Get.back();
            },
            child: const Text('Reset List')),
                  ],
        )
      ],
    );
  }
}
