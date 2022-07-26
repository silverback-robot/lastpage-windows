import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:lastpage/models/lastpage_colors.dart';
import 'package:lastpage/models/syllabus/subject.dart';
import 'package:lastpage/models/user_uploads/user_upload_info.dart';
import 'package:lastpage/widgets/syllabus/subject_unit_view.dart';

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
          toolbarHeight: 75,
          primary: false,
          leadingWidth: 0,
          leading: null,
          backgroundColor: LastpageColors.lightGrey,
          title: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: ListTile(
              tileColor: LastpageColors.lightGrey,
              leading: IconButton(
                  icon: const Icon(Icons.arrow_back_rounded),
                  hoverColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  splashColor: Colors.transparent,
                  onPressed: goBack),
              style: ListTileStyle.drawer,
              visualDensity: const VisualDensity(vertical: 4),
              title: Padding(
                padding: const EdgeInsets.symmetric(vertical: 5.0),
                child: Text(
                  subject.subjectTitle,
                  style: const TextStyle(fontSize: 24),
                ),
              ),
              subtitle: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text("Subject Code: ${subject.subjectCode}"),
                  const SizedBox(
                    width: 100,
                  ),
                  subject.LTPC != null &&
                          subject.LTPC!.trim().replaceAll(' ', '').length == 8
                      ? Text(
                          "Credits: ${subject.LTPC!.trim().replaceAll(' ', '').substring(7)}")
                      : const SizedBox(),
                ],
              ),
            ),
          ),
        ),
        body: FutureBuilder(
            future: Hive.openBox<UserUploadInfo>('userStorage'),
            builder: (context, AsyncSnapshot<Box<UserUploadInfo>> snapshot) {
              var allUnits = subject.subjectUnits?.map((e) {
                switch (e.unitNumber.replaceAll(' ', '').toUpperCase()) {
                  case ('UNITI'):
                    e.unitNumber = 1.toString();
                    break;
                  case ('UNITII'):
                    e.unitNumber = 2.toString();
                    break;
                  case ('UNITIII'):
                    e.unitNumber = 3.toString();
                    break;
                  case ('UNITIV'):
                    e.unitNumber = 4.toString();
                    break;
                  case ('UNITV'):
                    e.unitNumber = 5.toString();
                    break;
                }
                return e;
              }).toList();
              if (snapshot.hasData) {
                List<UserUploadInfo>? allUploads =
                    snapshot.data?.values.toList();
                allUploads?.removeWhere(
                    (element) => element.subjectCode != subject.subjectCode);
                return ListView(
                  shrinkWrap: false,
                  children: allUnits
                          ?.map((e) => SubjectUnitView(
                                unit: e,
                                unitUploads: allUploads
                                    ?.where((upload) =>
                                        upload.unitNo.toString() ==
                                        e.unitNumber)
                                    .toList(),
                              ))
                          .toList() ??
                      [],
                );
              } else {
                return ListView(
                  shrinkWrap: false,
                  children:
                      allUnits?.map((e) => SubjectUnitView(unit: e)).toList() ??
                          [],
                );
              }
            }));
  }
}
