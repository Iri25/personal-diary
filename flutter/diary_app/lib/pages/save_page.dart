import 'package:diary_app/domain/diary.dart';
import 'package:diary_app/service/diary_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:intl/intl.dart';

import '../utils/palette_colors.dart';
import 'view_page.dart';
import 'colors_page.dart';
import 'login_page.dart';

class MySavePageApp extends StatelessWidget {
  const MySavePageApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      title: 'DiaryApp',
      theme: ThemeData(
          primarySwatch: Palette.kToDark
      ),
      home: const MySavePage(title: 'DiaryApp'),
    );
  }
}

class MySavePage extends StatefulWidget {
  const MySavePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MySavePage> createState() => _MySavePageState();
}


class _MySavePageState extends State<MySavePage> {

  DiaryService diaryService = DiaryService();

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
            vertical: 48,
            horizontal: 24
        ),
        child: ListView(
          children: <Widget>[
            Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.all(10),
                child: const Text('How are you today?',
                  style: TextStyle(
                      color: Palette.kToDark,
                      fontWeight: FontWeight.w500,
                      fontSize: 24),
                )
            ),
            Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.all(10),
                child: const Text(
                  'Write your page of diary',
                  style: TextStyle(fontSize: 16),
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
                },
              ),
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
            Container(
              height: 50,
              padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
              child: FlatButton(
                onPressed: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) =>
                    const MyColorsPageApp()),
                  );
                },
                textColor: Palette.kToDark,
                child: const Text('Color Your Mood'),
              ),
            ),
            Container(
                height: 50,
                padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                child: RaisedButton(
                  textColor: Colors.white,
                  color: Palette.kToDark,
                  child: const Text('Save'),
                  onPressed: () {
                    bool ok = _dateTime.isAfter(DateTime.now());
                    print(ok.toString());
                    print(ok);
                    if(ok) {
                      showDialog(
                          context: context,
                          builder: (ctx) => AlertDialog(
                            title: const Text("Error"),
                            content: const Text(
                                "You cannot add a future diary page!"
                            ),
                            actions: <Widget>[
                              FlatButton(
                                onPressed: () {
                                  Navigator.of(ctx).pop();
                                },
                                child: const Text("OK"),
                              ),
                            ],
                          )
                      );
                    }
                    else {
                      showDialog(
                          context: context,
                          builder: (ctx) =>
                              AlertDialog(
                                title: const Text("Confirm Save"),
                                content: const Text(
                                    "Are you sure you want to save?"),
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
                                      diaryService.save(diary);
                                      Navigator.of(ctx).pop();
                                    },
                                    child: const Text("Ok"),
                                  ),
                                ],
                              )
                          );
                        }
                    },
                )
            ),
          ],
        ),
      ),
      floatingActionButton: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget> [
            FloatingActionButton(
               child: const Icon(
                   Icons.pageview
               ),
               onPressed: () {
                 Navigator.push(
                     context,
                     MaterialPageRoute(builder: (context) =>
                     const MyViewPageApp()),
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
                  const MyLoginPageApp()),
                );
              },
            ),
          ]
      ),
    );
  }
}