import 'package:belajar_getx/controller.dart';
import 'package:belajar_getx/name_list.dart';
import 'package:belajar_getx/setname.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ListPage extends StatelessWidget {
  ListPage({super.key});
  //Nemuin controller yang udah di 'put' sebelumnya
  final NameController controller = Get.find();
  //custom widget juga bisa dipanggil dari statelessWidget lain seperti
  //contoh di bawah
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 50, 20, 20),
        child: Column(
          children: [
            SetName(),
            Obx(() => Text(
                  'Nama yang dimasukkan terakhir: ${controller.controlName.value}\n\nList nama:',
                  style: const TextStyle(fontSize: 20),
                )),
            NamesList()
          ],
        ),
      ),
    ));
  }
}
