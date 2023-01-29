import 'package:flutter/material.dart';
import 'package:note_making_app/screens/add-note-screen.dart';
import 'package:note_making_app/screens/home-screen.dart';
import 'package:note_making_app/screens/open-note.dart';
import 'package:note_making_app/screens/splash-screen.dart';

import 'model/note-model.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
      home: const SplashScreen(),
      routes: {
        AddNote.routeName : (ctx) => const AddNote(),
        NoteOpen.routeName : (ctx) => NoteOpen(Note(description: '', title: "", id: null)),
        HomeScreen.routeName : (ctx) => const HomeScreen(),
      },
    );
  }
}

