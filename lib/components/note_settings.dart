import 'package:flutter/material.dart';

class NoteSettings extends StatelessWidget {
  final void Function()? onEditTap;
  final void Function()? onDeleteTap;
  const NoteSettings(
      {super.key, required this.onEditTap, required this.onDeleteTap});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: () {
            Navigator.pop(context);
            onEditTap!();
          },
          child: Container(
            height: 50,
            color: Theme.of(context).colorScheme.background,
            child: Center(
                child: Text(
              'Edit',
              style: TextStyle(
                  color: Theme.of(context).colorScheme.inversePrimary,
                  fontWeight: FontWeight.bold),
            )),
          ),
        ),
        GestureDetector(
          onTap: () {
            Navigator.pop(context);
            onDeleteTap!();
          },
          child: Container(
            height: 50,
            color: Theme.of(context).colorScheme.background,
            child: Center(
                child: Text(
              'Delete',
              style: TextStyle(
                  color: Theme.of(context).colorScheme.inversePrimary,
                  fontWeight: FontWeight.bold),
            )),
          ),
        )
      ],
    );
  }
}
