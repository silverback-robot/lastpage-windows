import 'package:flutter/material.dart';
import 'package:lastpage/models/lastpage_colors.dart';
import 'package:lastpage/models/syllabus/semester.dart';

class SemesterTile extends StatelessWidget {
  const SemesterTile({required this.semester, this.selected, Key? key})
      : super(key: key);
  final Semester semester;
  final bool? selected;

  @override
  Widget build(BuildContext context) {
    return Ink(
      color: LastpageColors.white,
      child: GridTile(
        child: Center(
          child: Text(
            semester.semesterNo.toString(),
            style:
                const TextStyle(fontSize: 45, color: LastpageColors.darkGrey),
          ),
        ),
      ),
    );
  }
}
