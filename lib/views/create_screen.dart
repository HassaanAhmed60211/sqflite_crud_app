import 'package:flutter/material.dart';
import 'package:sqflite_crud_app/services/db_helper.dart';

// ignore: must_be_immutable
class CreateScreen extends StatelessWidget {
  CreateScreen({super.key});

  TextEditingController name = TextEditingController();
  TextEditingController desc = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Create Data'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextField(
              controller: name,
              decoration: InputDecoration(
                  hintText: 'enter name',
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide:
                          const BorderSide(color: Colors.grey, width: 1))),
            ),
            const SizedBox(
              height: 40,
            ),
            TextField(
              controller: desc,
              decoration: InputDecoration(
                  hintText: 'enter description',
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide:
                          const BorderSide(color: Colors.grey, width: 1))),
            ),
            const SizedBox(
              height: 40,
            ),
            ElevatedButton(
                style: TextButton.styleFrom(backgroundColor: Colors.blue),
                onPressed: () async {
                  var addName = name.text;
                  var addDesc = desc.text;
                  await DbHelper.instance.insertRecord(
                      {DbHelper.dtName: addName, DbHelper.dtDesc: addDesc});
                  // ignore: use_build_context_synchronously
                  Navigator.pop(context);
                },
                child: const Text(
                  "Add",
                  style: TextStyle(color: Colors.white),
                ))
          ],
        ),
      ),
    );
  }
}
