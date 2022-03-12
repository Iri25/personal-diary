import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'save_page.dart';
import '../utils/palette_colors.dart';

import 'package:diary_app/service/user_service.dart';
class MyLoginPageApp extends StatelessWidget {
  const MyLoginPageApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      title: 'DiaryApp',
      theme: ThemeData(
          primarySwatch: Palette.kToDark

      ),
      home: const MyLoginPage(title: 'DiaryApp'),
    );
  }
}

class MyLoginPage extends StatefulWidget {
  const MyLoginPage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyLoginPage> createState() => _MyLoginPageState();
}

class _MyLoginPageState extends State<MyLoginPage> {

  UserService userService = UserService();

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
            vertical: 128,
            horizontal: 24
        ),
        child: ListView(
          children: <Widget>[
            Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.all(10),
                child: const Text(
                  'DiaryApp',
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
                  'Sign in',
                  style: TextStyle(fontSize: 16),
                )
            ),
            Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.all(10),
              child: TextField(
                  controller: emailController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Email',
                  )
              ),
            ),
            Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.all(10),
              child: TextField(
                  controller: passwordController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Password',
                  )
              ),
            ),
            Container(
              height: 50,
              padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
            ),
            Container(
                height: 50,
                padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                child: RaisedButton(
                  textColor: Colors.white,
                  color: Palette.kToDark,
                  child: const Text('Login'),
                  onPressed: () {
                    if (userService.login(
                        emailController.text,
                        passwordController.text) == true
                    ) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) =>
                        const MySavePageApp()
                        ),
                      );
                    }
                    else{
                      showDialog(
                        context: context,
                        builder: (ctx) => AlertDialog(
                          title: const Text("Error"),
                          content: const Text("Wrong email or password!"),
                          actions: <Widget>[
                            FlatButton(
                              onPressed: () {
                                Navigator.of(ctx).pop();
                              },
                              child: const Text("OK"),
                            ),
                          ],
                        ),
                      );
                    }
                  },
                )
            ),
          ],
        ),
      ),
    );
  }
}
