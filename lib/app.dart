import 'package:flutter/material.dart';
import 'package:frontend_mentor_rock_paper_scissors/home_page.dart';

class FrontendMentorRockPaperScissorsApp extends StatelessWidget {
  const FrontendMentorRockPaperScissorsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'RockPaperScissorsGame',
      theme: ThemeData(
        fontFamily: 'Barlow Semi Condensed',
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}
