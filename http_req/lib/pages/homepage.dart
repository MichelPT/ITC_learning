import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:focus_app/model/focus.dart';
import 'package:focus_app/pages/add_activity.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<FocusAct> _focusList = [];

  @override
  void initState() {
    super.initState();
    _loadActivity();
  }

  void _loadActivity() async {
    final url = Uri.https(
        'pawrent-c325b-default-rtdb.asia-southeast1.firebasedatabase.app',
        'activity-list.json');
    final response = await http.get(url);
    final Map<String, dynamic> listData = json.decode(response.body);
    final List<FocusAct> actList = [];
    for (var item in listData.entries) {
      actList.add(FocusAct(
          title: item.value['title'], description: item.value['description']));
    }
    setState(() {
      _focusList = actList;
    });
  }

  void _addActivity() async {
    await Navigator.of(context).push<FocusAct>(MaterialPageRoute(
      builder: (context) => const AddAct(),
    ));
    // if (newActivity == null) {
    //   return;
    // }
    // _focusList.add(newActivity);
    _loadActivity();
  }

  void _removeActivity(FocusAct item) async {
    final url = Uri.https(
        'pawrent-c325b-default-rtdb.asia-southeast1.firebasedatabase.app',
        'activity-list.json');
    await http.delete(url);
  }

  @override
  Widget build(BuildContext context) {
    late Widget content;
    _focusList.isNotEmpty
        ? content = ListView.builder(
            itemCount: _focusList.length,
            itemBuilder: (context, index) => Dismissible(
              onDismissed: (direction) {
                _focusList.removeAt(index);
                _removeActivity(_focusList[index]);
              },
              key: ValueKey(_focusList[index]),
              child: ListTile(
                title: Text(_focusList[index].title),
                subtitle: Text(_focusList[index].description),
              ),
            ),
          )
        : content = const Center(
            child: Text("Belum ada aktifitas.\nAyo produktif hari ini!"),
          );

    return Scaffold(
      appBar: AppBar(
        title: const Text('Focus App'),
      ),
      body: content,
      floatingActionButton: IconButton(
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(Colors.blueAccent)),
        onPressed: _addActivity,
        icon: const Icon(Icons.add),
      ),
    );
  }
}
