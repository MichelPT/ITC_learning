import 'dart:convert';
import 'dart:ffi';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:focus_app/custom_widgets/custom_field.dart';
import 'package:focus_app/model/focus.dart';

class AddAct extends StatefulWidget {
  const AddAct({super.key});

  @override
  State<AddAct> createState() => _AddActState();
}

class _AddActState extends State<AddAct> {
  final _formKey = GlobalKey<FormState>();

  String _enteredTitle = '';
  String _enteredDescription = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tambah Aktifitas'),
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
                buttonsRow(context)
              ],
            )),
      ),
    );
  }

  void _saveActivity(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      final url = Uri.https(
          'pawrent-c325b-default-rtdb.asia-southeast1.firebasedatabase.app',
          'activity-list.json');
      final response = await http.post(url,
          headers: {'Content-Type': 'application/json'},
          body: json.encode(
              {'title': _enteredTitle, 'description': _enteredDescription}));
      print(response.body);
      Navigator.of(context).pop(
          // FocusAct(title: _enteredTitle, description: _enteredDescription)
          );
    }
  }

  void _resetActivity() {
    _formKey.currentState!.reset();
  }

  Widget buttonsRow(BuildContext context) => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextButton(onPressed: _resetActivity, child: const Text('Reset')),
          const SizedBox(
            width: 70,
          ),
          ElevatedButton(
              onPressed: () {
                setState(() {});
                _saveActivity(context);
                print("$_enteredTitle - $_enteredDescription");
              },
              child: const Text('Simpan'))
        ],
      );
}
