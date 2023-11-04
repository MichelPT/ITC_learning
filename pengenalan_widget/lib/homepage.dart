import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: DropdownButton(
        hint: Text('hint'),
        disabledHint: Text('hint'),
        value: null,
        items: const [
          DropdownMenuItem(child: Text('11111')),
          DropdownMenuItem(child: Text('22222'))
        ],
        onChanged: (value) => null,
      )),
    );
  }
}
