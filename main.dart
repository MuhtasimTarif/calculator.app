import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'calculator_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  SharedPreferences prefs = await SharedPreferences.getInstance();
  bool dark = prefs.getBool("dark") ?? false;

  runApp(MyApp(isDark: dark));
}

class MyApp extends StatefulWidget {
  final bool isDark;

  const MyApp({super.key, required this.isDark});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  late bool darkMode;

  @override
  void initState() {
    super.initState();
    darkMode = widget.isDark;
  }

  void toggleTheme() async {
    darkMode = !darkMode;

    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool("dark", darkMode);

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {

    return MaterialApp(

      debugShowCheckedModeBanner: false,

      theme: ThemeData(
        brightness: Brightness.light,
        useMaterial3: true,
      ),

      darkTheme: ThemeData(
        brightness: Brightness.dark,
        useMaterial3: true,
      ),

      themeMode: darkMode ? ThemeMode.dark : ThemeMode.light,

      home: CalculatorPage(
        darkMode: darkMode,
        onThemeChanged: toggleTheme,
      ),
    );
  }
}