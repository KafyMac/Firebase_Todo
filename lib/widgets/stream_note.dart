import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_007/core/firestore_service.dart';
import 'package:firebase_007/widgets/task_widgets.dart';
import 'package:flutter/material.dart';

class Stream_note extends StatelessWidget {
  Stream_note({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: Firestore_Datasource().stream(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Center(child: CircularProgressIndicator());
        }

        final noteslist = Firestore_Datasource().getNotes(snapshot);

        if (noteslist.isEmpty) {
          return const Center(
            child: Text("No notes available"),
          );
        }

        return Flexible(
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: noteslist.length,
            itemBuilder: (context, index) {
              final note = noteslist[index];
              return Dismissible(
                key: UniqueKey(),
                onDismissed: (direction) {
                  Firestore_Datasource().delete_note(note.id);
                },
                child: Task_Widget(note),
              );
            },
          ),
        );
      },
    );
  }
}
