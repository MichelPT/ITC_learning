import 'dart:convert';
import 'package:focus_app/model/focus.dart';
import 'package:focus_app/pages/homepage.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:focus_app/custom_widgets/custom_field.dart';

class EditAct extends StatefulWidget {
  const EditAct({super.key, required this.focusAct});

  final FocusAct focusAct;

  @override
  State<EditAct> createState() => _EditActState();
}

class _EditActState extends State<EditAct> {
  final _formKey = GlobalKey<FormState>();

  String _id = '';
  String _enteredTitle = '';
  String _enteredDescription = '';

  @override
  Widget build(BuildContext context) {
    _id = widget.focusAct.id;
    _enteredTitle = widget.focusAct.title;
    _enteredDescription = widget.focusAct.description;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Aktifitas'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(30),
        child: Form(
            key: _formKey,
            child: Column(
              children: [
                CustomFormField.getCommonFormField((newValue) {
                  setState(() {
                    _enteredTitle = newValue!;
                  });
                }, _enteredTitle, "Judul"),
                const SizedBox(
                  height: 20,
                ),
                CustomFormField.getCommonFormField((newValue) {
                  _enteredDescription = newValue!;
                }, _enteredDescription, "Deskripsi"),
                const SizedBox(
                  height: 30,
                ),
                buttonsRow()
              ],
            )),
      ),
    );
  }

  void _saveActivity() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      final url = Uri.https(
          'pawrent-c325b-default-rtdb.asia-southeast1.firebasedatabase.app',
          'activity-list/$_id.json');
      final response = await http.put(url,
          headers: {'Content-Type': 'application/json'},
          body: json.encode(
              {'title': _enteredTitle, 'description': _enteredDescription}));
      if (response.statusCode == 200) {
        Get.offAll(() => const HomePage());
      }
    }
  }

  void _resetActivity() {
    _formKey.currentState!.reset();
  }

  Widget buttonsRow() => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextButton(onPressed: _resetActivity, child: const Text('Reset')),
          const SizedBox(
            width: 70,
          ),
          ElevatedButton(onPressed: _saveActivity, child: const Text('Simpan'))
        ],
      );
}
