import 'package:diary_app/domain/diary.dart';
import 'package:diary_app/service/diary_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:intl/intl.dart';

import '../utils/palette_colors.dart';
import 'save_page.dart';

class MyViewPageApp extends StatelessWidget {
  const MyViewPageApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      title: 'DiaryApp',
      theme: ThemeData(
          primarySwatch: Palette.kToDark

      ),
      home: const MyViewPage(title: 'DiaryApp'),
    );
  }
}

class MyViewPage extends StatefulWidget {
  const MyViewPage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyViewPage> createState() => _MyViewPageState();
}

class _MyViewPageState extends State<MyViewPage> {

  DiaryService diaryService = DiaryService();
  Diary diary = Diary('userId', 'day', 'color', 'summary', 'text');

  DateTime _dateTime = DateTime.now();
  String _dateFormat = DateFormat('yyyy-MM-dd').format(DateTime.now());

  String dropdownValue = 'Green';

  TextEditingController summaryController = TextEditingController();
  TextEditingController textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 0,
          horizontal: 24
        ),
        child: ListView(
          children: <Widget>[
            Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.all(10),
                child: const Text(
                  'What do you want to search?',
                  style: TextStyle(
                      color: Palette.kToDark,
                      fontWeight: FontWeight.w500,
                      fontSize: 24),
                )
            ),
            Container(
              height: 50,
              padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
              child: OutlineButton(
                textColor: Palette.kToDark,
                child: Text(_dateFormat),
                onPressed: () {
                  showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(2000),
                      lastDate: DateTime(2050)
                  ).then((date) {
                    setState(() {
                      _dateTime = date!;
                      _dateFormat = DateFormat('yyyy-MM-dd').format(_dateTime);
                    });
                  });
                  diary = diaryService.findOne(_dateFormat);
                },
              ),
            ),
            ListTile(
              leading: const Icon(Icons.palette),
              title: Text('Color: ' + diary.color),
            ),
            ListTile(
                  leading: const Icon(Icons.summarize),
                  title: Text('Summary: '+ diary.summary),
            ),
            ListTile(
                  leading: const Icon(Icons.notes),
                  title: Text('Text: ' + diary.text),
            ),
            Container(
              height: 50,
              padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
              child: DropdownButton(
                alignment: Alignment.center,
                value: dropdownValue,
                icon: const Icon(Icons.palette),
                iconSize: 24,
                elevation: 16,
                style: const TextStyle(color: Palette.kToDark),
                underline: Container(
                    height: 2,
                    color: Colors.black26
                ),
                onChanged: (String? newValue) {
                  setState(() {
                    dropdownValue = newValue!;
                  });
                },
                items: <String>[
                  'Green', 'Orange', 'Pink', 'Yellow', 'Red', 'Blue'
                ]
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    alignment: Alignment.center,
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
            ),
            Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.all(10),
              child: TextField(
                  controller: summaryController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Summary',
                    suffixIcon: Icon(
                      Icons.check_circle,
                    ),
                  )
              ),
            ),
            Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.all(10),
              child: TextField(
                  controller: textController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Text',
                    suffixIcon: Icon(
                      Icons.check_circle,
                    ),
                  )
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            FloatingActionButton(
              child: const Icon(
                  Icons.delete
              ),
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (ctx) => AlertDialog(
                      title: const Text("Confirm Delete"),
                      content: const Text("Are you sure you want to delete?"),
                      actions: <Widget>[
                        FlatButton(
                          onPressed: () {
                            Navigator.of(ctx).pop();
                          },
                          child: const Text("Cancel"),
                        ),
                        FlatButton(
                          onPressed: () {
                            diaryService.delete(diary);
                            Navigator.of(ctx).pop();
                          },
                          child: const Text("OK"),
                        ),
                      ],
                    )
                );
              },
            ),
            const SizedBox(
              height: 10,
            ),
            FloatingActionButton(
              child: const Icon(
                  Icons.update
              ),
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (ctx) => AlertDialog(
                    title: const Text("Confirm Update"),
                    content: const Text("Are you sure you want to update?"),
                    actions: <Widget>[
                      FlatButton(
                        onPressed: () {
                          Navigator.of(ctx).pop();
                        },
                        child: const Text("Cancel"),
                      ),
                      FlatButton(
                        onPressed: () {
                          Diary diary = Diary(
                              "iri25@gmail.com",
                              _dateFormat,
                              dropdownValue,
                              summaryController.text,
                              textController.text
                          );
                          diaryService.update(diary);
                          Navigator.of(ctx).pop();
                        },
                        child: const Text("OK"),
                      ),
                    ],
                  )
                );
              },
            ),
            const SizedBox(
              height: 10,
            ),
            FloatingActionButton(
              child: const Icon(
                  Icons.arrow_back
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) =>
                  const MySavePageApp()
                  ),
                );
              },
            )
          ]
      ),
    );
  }
}