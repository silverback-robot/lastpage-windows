import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lastpage/models/lastpage_colors.dart';
import 'package:lastpage/models/user_uploads/user_upload_info.dart';
import 'package:lastpage/screens/fullscreen_view.dart';

class NoteIcon extends StatelessWidget {
  const NoteIcon({required this.note, Key? key}) : super(key: key);

  final UserUploadInfo note;

  @override
  Widget build(BuildContext context) {
    var pageCount =
        note.localFilePaths != null ? note.localFilePaths!.length : 0;

    return Card(
      elevation: 2,
      child: ListTile(
        dense: true,
        // contentPadding:
        //     const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
        title: Text(
          note.title,
          style: const TextStyle(fontSize: 15, overflow: TextOverflow.ellipsis),
        ),
        trailing: Text("$pageCount ${pageCount > 1 ? 'pages' : 'page'}"),
        subtitle: Text(DateFormat.yMMMd().format(note.createdDateTime),
            style: const TextStyle(fontSize: 12)),
        onTap: () {
          Navigator.pushNamed(context, FullscreenView.routeName,
              arguments: note);
        },
      ),
    );
  }
}
