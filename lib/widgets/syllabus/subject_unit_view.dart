import 'package:flutter/material.dart';
import 'package:lastpage/models/lastpage_colors.dart';
import 'package:lastpage/models/syllabus/subject.dart';
import 'package:lastpage/models/user_uploads/user_upload_info.dart';
import 'package:lastpage/widgets/syllabus/note_icon.dart';

class SubjectUnitView extends StatelessWidget {
  const SubjectUnitView({required this.unit, this.unitUploads, Key? key})
      : super(key: key);

  final SubjectUnit unit;
  final List<UserUploadInfo>? unitUploads;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12.0),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
            color: LastpageColors.white,
            borderRadius: BorderRadius.circular(5)),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(children: [
              Text(
                unit.unitNumber,
                style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: LastpageColors.black),
              ),
              const SizedBox(width: 20),
              if (unit.unitTitle != null)
                Text(
                  unit.unitTitle!,
                  style: const TextStyle(fontSize: 18),
                ),
            ]),
            const SizedBox(
              height: 10,
            ),
            if (unit.unitContents != null) Text(unit.unitContents!),
            if (unitUploads != null && unitUploads!.isNotEmpty)
              const SizedBox(
                height: 21,
                child: Center(
                  child: Divider(
                    thickness: 1,
                  ),
                ),
              ),
            if (unitUploads != null && unitUploads!.isNotEmpty)
              GridView(
                shrinkWrap: true,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4, childAspectRatio: 3),
                children: unitUploads!.map((e) => NoteIcon(note: e)).toList(),
              ),
          ],
        ),
      ),
    );
  }
}
