import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

final box = GetStorage();

class NameController extends GetxController {
  var controlName = "".obs;
  RxList controlNames = [].obs;

  saveName(String name) {
    controlName.value = name;
    box.write('name', name);
    controlName.value = box.read('name');

    controlNames.add(name);
    box.write('names', controlNames);
    controlNames = box.read('names');
  }

  void init() {
    controlName.value = box.read('name');
    controlNames = box.read('names');
  }
}
