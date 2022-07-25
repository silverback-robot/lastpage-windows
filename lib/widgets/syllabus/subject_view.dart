import 'package:flutter/material.dart';
import 'package:lastpage/models/lastpage_colors.dart';
import 'package:lastpage/models/syllabus/subject.dart';

class SubjectView extends StatelessWidget {
  const SubjectView({required this.subject, required this.goBack, Key? key})
      : super(key: key);

  final Subject subject;
  final VoidCallback goBack;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        primary: false,
        backgroundColor: LastpageColors.lightGrey,
        leading: IconButton(
            icon: const Icon(Icons.arrow_back_rounded),
            hoverColor: Colors.transparent,
            highlightColor: Colors.transparent,
            splashColor: Colors.transparent,
            onPressed: goBack),
      ),
      body: Center(
        child: Text("Subject View: ${subject.subjectTitle}"),
      ),
    );
  }
}
