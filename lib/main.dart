import 'package:flutter/material.dart';
import 'package:wallpaper/home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme:
            ThemeData(brightness: Brightness.dark, primarySwatch: Colors.blue),
        title: "wallpaper",
        home: const HomeScreen(),
      ),
    );
  }
}
