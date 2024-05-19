import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:notes_app/models/note_database.dart';
import 'package:notes_app/theme/theme_provider.dart';
import 'package:provider/provider.dart';
import 'package:notes_app/pages/notes_page.dart';

void main() async {
  LicenseRegistry.addLicense(
    () async* {
      final license =
          await rootBundle.loadString('assets/google_fonts/OFL.txt');
      yield LicenseEntryWithLineBreaks(['google_fonts'], license);
    },
  );
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
