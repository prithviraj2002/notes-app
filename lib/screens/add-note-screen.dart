import 'package:flutter/material.dart';
import 'package:note_making_app/db/database.dart';
import 'package:note_making_app/model/note-model.dart';
import 'package:note_making_app/screens/home-screen.dart';

class AddNote extends StatefulWidget {
  static const routeName = '/add-note';
  const AddNote({Key? key}) : super(key: key);

  @override
  State<AddNote> createState() => _AddNoteState();
}

class _AddNoteState extends State<AddNote> {

  final titleController = TextEditingController();
  final desController = TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    titleController.dispose();
    desController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: const Icon(Icons.arrow_back_rounded, color: Colors.white,)
        ),
        title: const Text('Add note', style: TextStyle(color: Colors.white)),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              height: 30,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
              child: TextFormField(
                controller: titleController,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Title',
                ),
                style: const TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                validator: (value) {
                  if(value == null || value.isEmpty){
                    return 'Cannot accept null values';
                  }
                  return null;
                },
              ),
            ),
            Container(
              height: 15,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
              child: TextFormField(
                controller: desController,
                maxLines: null,
                decoration: const InputDecoration(
                    border: InputBorder.none,
                  hintText: 'Start writing here',
                ),
                style: const TextStyle(fontSize: 18),
                validator: (value) {
                  if(value == null || value.isEmpty){
                    return 'Cannot accept null values';
                  }
                  return null;
                },
              ),
            ),
            Container(
              height: 30,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: ()  {
          setState((){
            if(titleController.text.isNotEmpty && desController.text.isNotEmpty){
              Note n = Note(
                  id: DateTime.now().millisecond,
                  title: titleController.text,
                  description: desController.text);
              DatabaseHelper.addNote(n).then(
                      (int id) {
                        if(id != null){
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Note saved!'),)
                          );
                          Navigator.of(context).popAndPushNamed(HomeScreen.routeName);
                        }
                        else{
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text(
                                  'An error occurred',
                                  style: TextStyle(color: Colors.white),
                                ),
                              )
                          );
                        }
                      }
              );
            }
            else{
              ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text(
                      'Empty values!',
                      style: TextStyle(color: Colors.white),
                    ),
                  )
              );
            }
          });
        },
        child: const Icon(Icons.save, color: Colors.white,)
      )
    );
  }
}
