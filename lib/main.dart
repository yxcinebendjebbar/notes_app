import 'package:flutter/material.dart';
import 'package:notes_app/models/note_database.dart';
import 'package:notes_app/theme/theme_provider.dart';
import 'package:provider/provider.dart';
import 'package:notes_app/pages/notes_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await NoteDatabase.init();

  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(
        create: (context) => NoteDatabase(),
      ),
      ChangeNotifierProvider(
        create: (context) => ThemeProvider(),
      )
    ],
    child: App(),
  ));
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: Provider.of<ThemeProvider>(context).themeData,
      home: NotesPage(),
    );
  }
}
