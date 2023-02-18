import 'dart:developer';

import 'package:data_base_hive/db/functions/db_functions.dart';
import 'package:data_base_hive/db/model/data_model.dart';
import 'package:data_base_hive/providers/updateStudent_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';

class UpdateScreen extends StatelessWidget {
  final formKey = GlobalKey<FormState>();
  UpdateScreen({super.key});

  updateData({required context}) async {
    log('updateData');
    if (formKey.currentState!.validate()) {
      // Provider.of<UpdateStudentProvider>(context).updateStudentData();

      final studentDB = await Hive.openBox<StudentModel>('student_db');
      studentDB.putAt(
        Provider.of<UpdateStudentProvider>(context, listen: false).id,
        StudentModel(
            name: Provider.of<UpdateStudentProvider>(context, listen: false)
                .nameController
                .text,
            age: Provider.of<UpdateStudentProvider>(context, listen: false)
                .ageController
                .text,
            parent: Provider.of<UpdateStudentProvider>(context, listen: false)
                .parentController
                .text,
            number: Provider.of<UpdateStudentProvider>(context, listen: false)
                .numberController
                .text,
            address: Provider.of<UpdateStudentProvider>(context, listen: false)
                .addressController
                .text,
            domain: Provider.of<UpdateStudentProvider>(context, listen: false)
                .domainController
                .text),
      );
      getAllStudents();
      // ignore: use_build_context_synchronously
      Navigator.pop(context);
      print('Updated');
    }
  }

  @override
  Widget build(BuildContext context) {
    Future.delayed(
      Duration.zero,
      () {},
    );
    return Scaffold(
      appBar: AppBar(
        title: const Text("Update Student Data"),
      ),
      body: Form(
          key: formKey,
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: ListView(
              children: [
                TextFormField(
                  textCapitalization: TextCapitalization.words,
                  controller: Provider.of<UpdateStudentProvider>(context)
                      .nameController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Student Name',
                    hintStyle: TextStyle(
                        fontStyle: FontStyle.italic, color: Colors.grey),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter student name';
                    } else {
                      return null;
                    }
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  keyboardType: const TextInputType.numberWithOptions(),
                  controller:
                      Provider.of<UpdateStudentProvider>(context).ageController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Student Age',
                    hintStyle: TextStyle(
                        fontStyle: FontStyle.italic, color: Colors.grey),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter student age';
                    } else {
                      return null;
                    }
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  textCapitalization: TextCapitalization.words,
                  controller: Provider.of<UpdateStudentProvider>(context)
                      .domainController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Domain',
                    hintStyle: TextStyle(
                        fontStyle: FontStyle.italic, color: Colors.grey),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter student domain';
                    } else {
                      return null;
                    }
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  textCapitalization: TextCapitalization.words,
                  controller: Provider.of<UpdateStudentProvider>(context)
                      .parentController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Parent Name',
                    hintStyle: TextStyle(
                        fontStyle: FontStyle.italic, color: Colors.grey),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter parent name';
                    } else {
                      return null;
                    }
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  keyboardType: TextInputType.phone,
                  controller: Provider.of<UpdateStudentProvider>(context)
                      .numberController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Contact Number',
                    hintStyle: TextStyle(
                        fontStyle: FontStyle.italic, color: Colors.grey),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter contact number';
                    } else {
                      return null;
                    }
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  maxLines: 5,
                  textCapitalization: TextCapitalization.words,
                  controller: Provider.of<UpdateStudentProvider>(context)
                      .addressController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Address',
                    hintStyle: TextStyle(
                        fontStyle: FontStyle.italic, color: Colors.grey),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter student address';
                    } else {
                      return null;
                    }
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton.icon(
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        updateData(context: context);
                        formUpdated(context: context);
                      }
                    },
                    icon: const Icon(Icons.add),
                    label: const Text('Update Student'))
              ],
            ),
          )),
    );
  }

  void formUpdated({required context}) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.green,
        margin: EdgeInsets.all(10),
        content: Text('Student data updated'),
        duration: Duration(seconds: 2),
      ),
    );
  }
}
