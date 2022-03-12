import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'package:diary_app/utils/palette_colors.dart';

import 'save_page.dart';

class MyColorsPageApp extends StatelessWidget {
  const MyColorsPageApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      title: 'DiaryApp',
      theme: ThemeData(
          primarySwatch: Palette.kToDark

      ),
      home: const MyColorsPage(title: '   '
          'Diary App'
      ),
    );
  }
}

class MyColorsPage extends StatefulWidget {
  const MyColorsPage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application.

  final String title;

  @override
  State<MyColorsPage> createState() => _MyColorsPageState();
}

class _MyColorsPageState extends State<MyColorsPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
            vertical: 8,
            horizontal: 0
        ),
        child: ListView(
          children: <Widget>[
            Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.all(10),
                child: const Text(
                  'How do you feel?',
                  style: TextStyle(
                      color: Palette.kToDark,
                      fontWeight: FontWeight.w500,
                      fontSize: 24),
                )
            ),
            Image.asset('assets/images/feedback-form-emotions-rating-satisfaction.jpg'),
            const ListTile(
              leading: Icon(Icons.sentiment_very_satisfied),
              title: Text('Orange'),
              subtitle: Text('excited, energetic, agitated, jumping, impatient'),
              tileColor: Colors.orange,
            ),
            const ListTile(
              leading: Icon(Icons.sentiment_neutral),
              title: Text('Pink'),
              subtitle: Text('tender, loving, emotional, quiet, kind, suggestive'),
              tileColor: Colors.pink,
            ),
            const ListTile(
              leading: Icon(Icons.mood_bad),
              title: Text('Yellow'),
              subtitle: Text('scared, terrified, panicked, stressed, tense'),
              tileColor: Colors.yellow,
            ),
            const ListTile(
              leading: Icon(Icons.sentiment_very_dissatisfied),
              title: Text('Red'),
              subtitle: Text('angry, furious, upset, revolted, irritated,  nervous'),
              tileColor: Colors.red,
            ),
            const ListTile(
              leading: Icon(Icons.sentiment_dissatisfied),
              title: Text('Blue'),
              subtitle: Text('sad, depressed, sorrowful, gloomy, destroyed'),
              tileColor: Colors.blue,
            ),
            const ListTile(
              leading: Icon(Icons.sentiment_satisfied_alt),
              title: Text('Green'),
              subtitle: Text('happy, fulfilled, satisfied, joyful, optimistic'),
              tileColor: Colors.green,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const MySavePageApp()),
          );
        },
        child: const Icon(Icons.arrow_back),
      ),
    );
  }
}