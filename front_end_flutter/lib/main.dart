import 'package:flutter/material.dart';
import 'package:uni_drive/views/main_view.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'UniDrive',
      themeMode: ThemeMode.dark,
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: const Color(0xFF222227),
        colorScheme: const ColorScheme.dark(
          primary: Color(0xFF363ABE),
          secondary: Color(0xFF363ABE),
        ),
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          foregroundColor: Colors.white,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            foregroundColor: Colors.white,
          ),
        ),
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            foregroundColor: Colors.white,
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          fillColor: Colors.grey[850],
          filled: true,
          isDense: true,
          hintStyle:
          Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.white.withOpacity(0.5)),
          suffixStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.white),
          border: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(8.0),
          ),
        ),
      ),
      home: const MainView(),
    );
  }
}
