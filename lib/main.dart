import 'package:flutter/material.dart';
import 'screens/resume_form_screen.dart';

void main() {
  runApp(ResumeBuilderApp());
}

class ResumeBuilderApp extends StatelessWidget {
  const ResumeBuilderApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Resume Builder',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(),
        ),
      ),
      home: ResumeFormScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
