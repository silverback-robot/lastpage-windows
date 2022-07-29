import 'package:flutter/material.dart';
import 'package:lastpage/models/lastpage_colors.dart';
import 'package:lastpage/models/syllabus/semester.dart';
import 'package:lastpage/models/syllabus/subject.dart';
import 'package:lastpage/models/syllabus/syllabus_provider.dart';
import 'package:lastpage/widgets/syllabus/subject_view.dart';
import 'package:lastpage/widgets/syllabus/semester.dart';
import 'package:provider/provider.dart';

class SyllabusScreen extends StatefulWidget {
  const SyllabusScreen({Key? key}) : super(key: key);

  @override
  State<SyllabusScreen> createState() => _SyllabusScreenState();
}

class _SyllabusScreenState extends State<SyllabusScreen> {
  Semester? selectedSem;
  Subject? selectedSubject;

  @override
  Widget build(BuildContext context) {
    final syllabus = Provider.of<SyllabusProvider>(context).syllabus;
    var gridContents = syllabus!.semesters
        .map((sem) => InkResponse(
              hoverColor: Colors.transparent,
              highlightColor: Colors.transparent,
              containedInkWell: true,
              onTap: () {
                setState(() {
                  selectedSem = sem;
                });
              },
              child: SemesterTile(
                semester: sem,
                selected:
                    selectedSem?.semesterNo == sem.semesterNo ? true : false,
              ),
            ))
        .toList();
    return Scaffold(
      body: selectedSubject == null
          ? Row(
              children: [
                Expanded(
                  flex: 2,
                  child: ListView(
                    children: [
                      const Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 12.0, vertical: 8.0),
                        child:
                            Text("Semesters", style: TextStyle(fontSize: 32)),
                      ),
                      GridView(
                        padding: const EdgeInsets.all(15.0),
                        shrinkWrap: true,
                        // gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        //   crossAxisCount: 2,
                        gridDelegate:
                            const SliverGridDelegateWithMaxCrossAxisExtent(
                          maxCrossAxisExtent: 150,
                          mainAxisExtent: 120,
                          crossAxisSpacing: 8,
                          mainAxisSpacing: 8,
                        ),
                        children: gridContents,
                      ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 3,
                  // width: 300,
                  child: selectedSem != null
                      ? Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              color: LastpageColors.lightGrey,
                              width: double.infinity,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                    "Subjects in semester ${selectedSem!.semesterNo}",
                                    style: const TextStyle(fontSize: 24)),
                              ),
                            ),
                            Expanded(
                              child: ListView(
                                controller: ScrollController(),
                                // shrinkWrap: true,
                                children: syllabus.subjects
                                    .where((subject) => selectedSem!
                                        .semesterSubjects
                                        .contains(subject.subjectCode))
                                    .map((e) => Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 15, vertical: 4.0),
                                          child: ListTile(
                                            title: Text(e.subjectTitle),
                                            subtitle: Text(e.subjectCode),
                                            onTap: () {
                                              setState(() {
                                                selectedSubject = e;
                                              });
                                            },
                                          ),
                                        ))
                                    .toList(),
                              ),
                            ),
                          ],
                        )
                      : const SizedBox(
                          width: 300,
                        ),
                )
              ],
            )
          : SubjectView(
              subject: selectedSubject!,
              goBack: () {
                setState(() {
                  selectedSubject = null;
                });
              }),
    );
  }
}
