import 'package:flutter/material.dart';
import 'package:sqflite_crud_app/services/db_helper.dart';
import 'package:sqflite_crud_app/views/home_page.dart';

// ignore: must_be_immutable
class UpdateScreen extends StatelessWidget {
  int id;
  String namedb;
  String descdb;
  UpdateScreen(
      {super.key,
      required this.id,
      required this.namedb,
      required this.descdb});

  @override
  Widget build(BuildContext context) {
    TextEditingController name = TextEditingController();
    TextEditingController desc = TextEditingController();
    name.text = namedb;
    desc.text = descdb;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Update Data'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              "Update Data",
              style: TextStyle(fontSize: 23, fontWeight: FontWeight.w700),
            ),
            const SizedBox(
              height: 40,
            ),
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
                  await DbHelper.instance.updateRecord({
                    DbHelper.dtId: id,
                    DbHelper.dtName: addName,
                    DbHelper.dtDesc: addDesc
                  });
                  // ignore: use_build_context_synchronously
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const HomePage()),
                  );
                },
                child: const Text(
                  "Add",
                  style: TextStyle(color: Colors.white),
                )),
          ],
        ),
      ),
    );
  }
}
