import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:notes_app/components/drawer.dart';
import 'package:notes_app/components/note_tile.dart';
import 'package:notes_app/models/note.dart';
import 'package:notes_app/models/note_database.dart';
import 'package:provider/provider.dart';

class NotesPage extends StatefulWidget {
  const NotesPage({super.key});

  @override
  State<NotesPage> createState() => _NotesPageState();
}

class _NotesPageState extends State<NotesPage> {
  final textController = TextEditingController();

  @override
  void initState() {
    super.initState();

    readNotes();
  }

  void createNote() {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              backgroundColor: Theme.of(context).colorScheme.background,
              content: TextField(
                controller: textController,
              ),
              actions: [
                MaterialButton(
                  onPressed: () {
                    context.read<NoteDatabase>().addNote(textController.text);
                    textController.clear();
                    Navigator.pop(context);
                  },
                  child: const Text('Create'),
                )
              ],
            ));
  }

  void readNotes() {
    context.read<NoteDatabase>().fetchNotes();
  }

  void updateNote(Note note) {
    textController.text = note.text;
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Theme.of(context).colorScheme.background,
        title: const Text('Update Note'),
        content: TextField(
          controller: textController,
        ),
        actions: [
          MaterialButton(
            onPressed: () {
              context
                  .read<NoteDatabase>()
                  .updateNote(note.id, textController.text);

              textController.clear();
              Navigator.pop(context);
            },
            child: const Text("Update"),
          )
        ],
      ),
    );
  }

  void deleteNote(int id) {
    context.read<NoteDatabase>().deleteNote(id);
  }

  @override
  Widget build(BuildContext context) {
    final noteDatabase = context.watch<NoteDatabase>();

    List<Note> currentNotes = noteDatabase.currentNotes;

    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          foregroundColor: Theme.of(context).colorScheme.inversePrimary,
        ),
        backgroundColor: Theme.of(context).colorScheme.background,
        drawer: MyDrawer(),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Theme.of(context).colorScheme.primary,
          child: Icon(
            Icons.add,
            color: Theme.of(context).colorScheme.inversePrimary,
          ),
          onPressed: createNote,
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(25.0),
              child: Text(
                'Notes',
                style: GoogleFonts.dmSerifText(
                    fontSize: 48,
                    color: Theme.of(context).colorScheme.inversePrimary),
              ),
            ),
            Expanded(
              child: ListView.builder(
                  itemCount: currentNotes.length,
                  itemBuilder: (context, index) {
                    final note = currentNotes[index];

                    return NoteTile(
                        text: note.text,
                        onEditPressed: () {
                          updateNote(note);
                        },
                        onDeletePressed: () {
                          deleteNote(note.id);
                        });
                  }),
            )
          ],
        ));
  }
}
