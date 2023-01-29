import 'package:flutter/material.dart';

import '../db/database.dart';
import '../model/note-model.dart';

class NoteOpen extends StatefulWidget {
  static const routeName = '/note-open';
  Note note;
  NoteOpen(this.note, {Key? key}) : super(key: key);

  @override
  State<NoteOpen> createState() => _NoteOpenState();
}

class _NoteOpenState extends State<NoteOpen> {

  final _titleController = TextEditingController();
  final _desController = TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _titleController.dispose();
    _desController.dispose();
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
          title: const Text('Edit note', style: TextStyle(color: Colors.white)),
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
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: _titleController,
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Title',
                  ),
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
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: _desController,
                  maxLines: null,
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Start writing here',
                  ),
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
            if(_titleController.text.isNotEmpty && _desController.text.isNotEmpty){
              widget.note.title = _titleController.text;
              widget.note.description = _desController.text;
              DatabaseHelper.updateNote(widget.note);
              ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Note saved!'),)
              );
              Navigator.of(context).pop();
            }
            else{
              ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    backgroundColor: Colors.grey,
                    content: Text(
                      'Empty values!',
                      style: TextStyle(color: Colors.white),
                    ),
                  )
              );
            }
          },
          child: const Text('Save', style: TextStyle(color: Colors.white),),
        )
    );
  }
}
