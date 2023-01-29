import 'package:flutter/material.dart';
import 'package:note_making_app/db/database.dart';
import 'package:note_making_app/screens/add-note-screen.dart';

import '../model/note-model.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = '/home-screen';
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notes', style: TextStyle(color: Colors.white),)
      ),
      body: FutureBuilder(
          future: DatabaseHelper.getnotes(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              List<Note> notes = snapshot.data;
              if(notes.isEmpty){
                return const Center(child: Text('No note added yet!'));
              }
              else{
                return ListView.builder(
                  itemCount: notes.length,
                  itemBuilder: (BuildContext context, int index) {
                    return ListTile(
                      title: Text(notes[index].title),
                      subtitle: Text(notes[index].description),
                      onLongPress: () {
                        showDialog(
                            context: context,
                            builder: (ctx) => AlertDialog(
                              title: const Text('Delete this note?'),
                              actions: [
                                TextButton(
                                    onPressed: () {
                                      DatabaseHelper.delNote(
                                          notes[index]).then(
                                              (value) {
                                                Navigator.of(context).pop();
                                            Navigator.of(context).pushReplacementNamed(HomeScreen.routeName);
                                          }
                                      );
                                    },
                                    child: const Text("Yes")),
                                TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: const Text("No"))
                              ],
                            )
                        );
                      },
                    );
                  },
                );
              }
            } else if (snapshot.hasError) {
              return const Center(child: Icon(Icons.error_outline));
            }
            else if(!snapshot.hasData){
              return const Center(child:
              Text(
                "No notes",
                style: TextStyle(
                  fontSize: 20,
                  ),
                )
              );
            }
            else {
              return const Center(child: CircularProgressIndicator());
            }
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).popAndPushNamed(AddNote.routeName);
        },
        child: const Icon(Icons.add, color: Colors.white,),
      ),
    );
  }
}


