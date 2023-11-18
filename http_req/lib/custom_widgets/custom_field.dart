import 'package:flutter/material.dart';

class CustomFormField {
  static Widget getCommonFormField(
      void Function(String?)? save, String onSavedString, String title) {
    return TextFormField(
      onSaved: save,
      validator: (value) {
        if (value == null || value.isEmpty || value.trim().length <= 1) {
          return 'Input form belum valid';
        }
        return null;
      },
      maxLength: 20,
      decoration: InputDecoration(
          label: Text(title),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
          )),
    );
  }
}
