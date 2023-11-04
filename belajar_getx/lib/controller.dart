import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class NameController extends GetxController {
  final box = GetStorage();
  var controlName = "".obs;
  RxList controlNames = [].obs;

  void saveName(String name) {
    controlName.value = name;
    box.write('name', name);
    controlName.value = box.read('name');

    controlNames.add(name);
    box.write('names', controlNames);
  }

  void resetList() {
    box.remove('names');
    controlNames.value = [];
  }

  void init() {
    controlName.value = box.read('name');
    if (box.read('names') == null) {
      controlNames.value = [];
      return;
    }
    controlNames.value = box.read('names');
  }
}
