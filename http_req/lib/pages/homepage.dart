import 'dart:convert';

import 'package:focus_app/pages/edit_activity.dart';
import 'package:get/get.dart';
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
    if (jsonDecode(response.body) != null) {
      final Map<String, dynamic> listData = json.decode(response.body);
      final List<FocusAct> actList = [];
      for (var item in listData.entries) {
        actList.add(FocusAct(
            id: item.key,
            title: item.value['title'],
            description: item.value['description']));
      }
      setState(() {
        _focusList = actList;
      });
    }
  }

  void _addActivity() async {
    await Navigator.of(context).push<FocusAct>(MaterialPageRoute(
      builder: (context) => const AddAct(),
    ));
    _loadActivity();
  }

  Future<bool> _removeActivity(String key) async {
    final url = Uri.https(
        'pawrent-c325b-default-rtdb.asia-southeast1.firebasedatabase.app',
        'activity-list/$key.json');
    final response = await http.delete(url);
    if (response.statusCode == 200) {
      final index = _focusList.indexWhere((activity) => activity.id == key);
      if (index != -1) {
        _focusList.removeAt(index);
      }
      _loadActivity();
      return true;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    late Widget content;
    _focusList.isNotEmpty
        ? content = ListView.builder(
            itemCount: _focusList.length,
            itemBuilder: (context, index) => Dismissible(
              onDismissed: (direction) async {
                final success = await _removeActivity(_focusList[index].id);
                if (success) {
                  Get.snackbar('Deletion success',
                      'The activity has been deleted successfully');
                } else {
                  Get.snackbar(
                      'Deletion failed', 'The activity could not be deleted');
                }
                _loadActivity();
              },
              key: ValueKey(_focusList[index]),
              child: GestureDetector(
                onTap: () => Get.to(() => EditAct(
                    focusAct: FocusAct(
                        id: _focusList[index].id,
                        title: _focusList[index].title,
                        description: _focusList[index].description))),
                child: ListTile(
                  title: Text(_focusList[index].title),
                  subtitle: Text(_focusList[index].description),
                ),
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
