import 'package:flutter/material.dart';
import 'package:uni_drive/presentation/main_view.dart';

const Map<String, String> loggedInUser = {
  "Home": "Via Gian Pietro Talamini, 54, 00128 Roma RM, Italy",
  "University": "Via del Castro Pretorio, 20, 00185 Roma RM, Italy",
};

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
          fillColor: Colors.white.withOpacity(0.1),
          filled: true,
          isDense: true,
          constraints: const BoxConstraints(
            minHeight: kMinInteractiveDimension,
            maxHeight: kMinInteractiveDimension,
          ),
          hintStyle: Theme.of(context)
              .textTheme
              .bodyMedium
              ?.copyWith(color: Colors.white.withOpacity(0.5)),
          suffixStyle: Theme.of(context)
              .textTheme
              .bodyMedium
              ?.copyWith(color: Colors.white),
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
