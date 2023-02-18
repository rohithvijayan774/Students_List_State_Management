import 'package:data_base_hive/db/functions/db_functions.dart';
import 'package:data_base_hive/db/model/data_model.dart';

import 'package:data_base_hive/screens/list_student_widget.dart';
import 'package:flutter/material.dart';

class SearchStudent extends StatefulWidget {
  const SearchStudent({Key? key}) : super(key: key);

  @override
  State<SearchStudent> createState() => _SearchStudentState();
}

class _SearchStudentState extends State<SearchStudent> {
  List<StudentModel> foundStudents = [];
  @override
  void initState() {
    foundStudents = studentListNotifier.value;
    super.initState();
  }

  void runFiter(String entredKeyword) {
    List<StudentModel> results = [];
    if (entredKeyword.isEmpty) {
      results = studentListNotifier.value;
    } else {
      results = studentListNotifier.value
          .where((element) =>
              element.name.toLowerCase().contains(entredKeyword.toLowerCase()))
          .toList();
    }
    setState(() {
      foundStudents = results;
    });
  }

  @override
  Widget build(BuildContext context) {
    getAllStudents();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search Student'),
      ),
      body: SafeArea(
        child: Column(
          children: [
            TextField(
              onChanged: (value) => runFiter(value),
              decoration: const InputDecoration(
                  labelText: 'Search', suffixIcon: Icon(Icons.search)),
            ),
            Expanded(
                child: ListStudentWIdget(
              showStudentList: foundStudents,
            ))
          ],
        ),
      ),
    );
  }
}
