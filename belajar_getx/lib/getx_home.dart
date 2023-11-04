import 'package:belajar_getx/controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class GetHome extends StatelessWidget {
  GetHome({super.key});

  final box = GetStorage();
  final NameController controller = Get.put(NameController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Obx(() => ListView.builder(
                  shrinkWrap: true,
                  itemCount: controller.controlNames.length,
                  itemBuilder: (context, index) {
                    return Text(controller.controlNames[index].toString());
                  },
                )),
            SizedBox(
              height: 20,
            ),
            ElevatedButton(
                onPressed: () {
                  controller.saveName('Budi');
                  Get.snackbar(
                    'Data telah diubah',
                    'Data telah diubah',
                  );
                },
                child: const Text('Change'))
          ],
        ),
      ),
    );
  }
}
