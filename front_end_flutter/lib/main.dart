import 'dart:async';

import 'package:flutter/material.dart';
import 'package:uni_drive/main_page.dart';
// import 'package:flutter_dotenv/flutter_dotenv.dart' as dotenv;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await dotenv.load();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'UniDrive',
      home: MainPage(),
    );
  }
}
