import 'package:flutter/material.dart';
import 'package:lastpage/models/lastpage_colors.dart';
import 'package:lastpage/models/syllabus/semester.dart';
import 'package:lastpage/models/syllabus/syllabus_provider.dart';
import 'package:lastpage/widgets/syllabus/semester.dart';
import 'package:provider/provider.dart';

class SyllabusScreen extends StatefulWidget {
  const SyllabusScreen({Key? key}) : super(key: key);

  @override
  State<SyllabusScreen> createState() => _SyllabusScreenState();
}

class _SyllabusScreenState extends State<SyllabusScreen> {
  Semester? selectedSem;

  @override
  Widget build(BuildContext context) {
    final syllabus = Provider.of<SyllabusProvider>(context).syllabus;
    var gridContents = syllabus!.semesters
        .map((sem) => GestureDetector(
              onTap: () {
                setState(() {
                  selectedSem = sem;
                  print("Semester selected: ${selectedSem?.semesterNo}");
                });
              },
              child: InkWell(
                child: SemesterTile(
                  semester: sem,
                  selected:
                      selectedSem?.semesterNo == sem.semesterNo ? true : false,
                ),
              ),
            ))
        .toList();
    print(gridContents.length);
    return Scaffold(
      body: Row(
        children: [
          SizedBox(
            width: 400,
            child: ListView(
              children: [
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 4.0, vertical: 8.0),
                  child: Text("Semesters", style: TextStyle(fontSize: 32)),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GridView(
                    shrinkWrap: true,
                    // gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    //   crossAxisCount: 2,
                    gridDelegate:
                        const SliverGridDelegateWithMaxCrossAxisExtent(
                      maxCrossAxisExtent: 200,
                      mainAxisExtent: 120,
                      crossAxisSpacing: 8,
                      mainAxisSpacing: 8,
                    ),
                    children: gridContents,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
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
                        child: SizedBox(
                          width: 400,
                          child: ListView(
                            controller: ScrollController(),
                            // shrinkWrap: true,
                            children: syllabus.subjects
                                .where((subject) => selectedSem!
                                    .semesterSubjects
                                    .contains(subject.subjectCode))
                                .map((e) => Padding(
                                      padding: const EdgeInsets.all(4.0),
                                      child: ListTile(
                                        title: Text(e.subjectTitle),
                                        subtitle: Text(e.subjectCode),
                                        onTap: () {},
                                      ),
                                    ))
                                .toList(),
                          ),
                        ),
                      ),
                    ],
                  )
                : const SizedBox(
                    width: 300,
                  ),
          )
        ],
      ),
    );
  }
}
