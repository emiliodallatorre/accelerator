import 'package:accelerator/interface/screen/home_screen.dart';
import 'package:accelerator/references.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: References.appName,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routes: <String, Widget Function(BuildContext)>{
        HomeScreen.route: (BuildContext context) => HomeScreen(),
      },
      initialRoute: HomeScreen.route,
    );
  }
}
