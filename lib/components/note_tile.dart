import 'package:flutter/material.dart';
import 'package:popover/popover.dart';
import 'package:notes_app/components/note_settings.dart';

class NoteTile extends StatelessWidget {
  final String text;
  final void Function()? onEditPressed;
  final void Function()? onDeletePressed;
  const NoteTile(
      {super.key,
      required this.text,
      required this.onEditPressed,
      required this.onDeletePressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primary,
        borderRadius: BorderRadius.circular(8),
      ),
      margin: const EdgeInsets.only(top: 10, right: 25, left: 25),
      child: ListTile(
        title: Text(text),
        trailing: Builder(builder: (context) {
          return IconButton(
            icon: const Icon(Icons.more_vert),
            onPressed: () => showPopover(
                backgroundColor: Theme.of(context).colorScheme.background,
                width: 100,
                height: 100,
                context: context,
                bodyBuilder: (context) => NoteSettings(
                      onEditTap: onEditPressed,
                      onDeleteTap: onDeletePressed,
                    )),
          );
        }),
      ),
    );
  }
}
