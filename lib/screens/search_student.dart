import 'package:data_base_hive/db/functions/db_functions.dart';
import 'package:data_base_hive/db/model/data_model.dart';
import 'package:data_base_hive/providers/searchStudents_provider.dart';

import 'package:data_base_hive/screens/list_student_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SearchStudent extends StatelessWidget {
  const SearchStudent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Provider.of<SearchStudentProvider>(context).initState();

    getAllStudents();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search Student'),
      ),
      body: SafeArea(
        child: Column(
          children: [
            TextField(
              onChanged: (value) =>
                  Provider.of<SearchStudentProvider>(context, listen: false)
                      .runFilter(value),
              decoration: const InputDecoration(
                labelText: 'Search',
                suffixIcon: Icon(Icons.search),
              ),
            ),
            Expanded(
                child: ListStudentWIdget(
              showStudentList:
                  Provider.of<SearchStudentProvider>(context).foundStudents,
            ))
          ],
        ),
      ),
    );
  }
}
