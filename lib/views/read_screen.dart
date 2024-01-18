import 'package:flutter/material.dart';
import 'package:sqflite_crud_app/services/db_helper.dart';
import 'package:sqflite_crud_app/views/home_page.dart';
import 'package:sqflite_crud_app/views/update_screen.dart';

// ignore: must_be_immutable
class ReadScreen extends StatefulWidget {
  const ReadScreen({super.key});

  @override
  State<ReadScreen> createState() => _ReadScreenState();
}

class _ReadScreenState extends State<ReadScreen> {
  List<Map<String, dynamic>> dataList = [];

  void allData() async {
    var queryData = await DbHelper.instance.queryDatabase();
    setState(() {
      dataList = queryData;
    });
  }

  @override
  void initState() {
    super.initState();
    allData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Read Data'),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              height: 20,
            ),
            Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: dataList.isEmpty
                    ? const SizedBox(
                        height: 600,
                        child: Center(
                          child: Text("No data available"),
                        ),
                      )
                    : ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: dataList.length,
                        itemBuilder: (context, index) {
                          var item = dataList[index];
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 15),
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(13),
                                color: Colors.grey[200],
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(15.0),
                                child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(item['name']),
                                          Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              GestureDetector(
                                                  onTap: () {
                                                    Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              UpdateScreen(
                                                                id: item['id'],
                                                                namedb: item[
                                                                    'name'],
                                                                descdb: item[
                                                                    'desc'],
                                                              )),
                                                    );
                                                  },
                                                  child: const Icon(
                                                    Icons.edit,
                                                    color: Colors.red,
                                                  )),
                                              const SizedBox(
                                                width: 10,
                                              ),
                                              GestureDetector(
                                                  onTap: () async {
                                                    await DbHelper.instance
                                                        .deleteRecord(
                                                            item['id']);
                                                    // ignore: use_build_context_synchronously
                                                    Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              const HomePage()),
                                                    );
                                                  },
                                                  child: const Icon(
                                                    Icons.delete,
                                                    color: Colors.red,
                                                  )),
                                            ],
                                          ),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Text(item['desc']),
                                    ]),
                              ),
                            ),
                          );
                        },
                      )),
          ],
        ),
      ),
    );
  }
}
