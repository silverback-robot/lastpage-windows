import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:lastpage/models/lastpage_colors.dart';
import 'package:lastpage/models/syllabus/syllabus.dart';
import 'package:lastpage/models/syllabus/syllabus_provider.dart';
import 'package:lastpage/models/user_uploads/user_upload_info.dart';
import 'package:lastpage/services/firestore_rest_api.dart';
import 'package:lastpage/widgets/library/preview_note.dart';
import 'package:provider/provider.dart';
import 'package:collection/collection.dart';

class Library extends StatefulWidget {
  const Library({Key? key}) : super(key: key);

  static const routeName = '/library';

  @override
  State<Library> createState() => _LibraryState();
}

class _LibraryState extends State<Library> {
  UserUploadInfo? selectedUpload;
  Syllabus? syllabus;

  @override
  void initState() {
    Provider.of<FirestoreRestApi>(context, listen: false).fetchUserUploads();
    super.initState();
  }

  @override
  void didChangeDependencies() {
    syllabus = Provider.of<SyllabusProvider>(context).syllabus;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          SizedBox(
            width: selectedUpload == null ? 800 : 400,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: FutureBuilder(
                future: Hive.openBox<UserUploadInfo>('userStorage'),
                builder:
                    (context, AsyncSnapshot<Box<UserUploadInfo>> snapshot) {
                  if (snapshot.hasData) {
                    return ValueListenableBuilder<Box>(
                        valueListenable: snapshot.data!.listenable(),
                        builder: (context, box, widget) {
                          return GridView.builder(
                              gridDelegate:
                                  SliverGridDelegateWithMaxCrossAxisExtent(
                                maxCrossAxisExtent: 350,
                                childAspectRatio:
                                    selectedUpload != null ? 2.5 : 4,
                                crossAxisSpacing: 4,
                                mainAxisSpacing: 4,
                              ),
                              itemCount: box.keys.length,
                              itemBuilder: (context, index) {
                                UserUploadInfo storageItem = box.getAt(index);
                                var subjectTitle = syllabus?.subjects
                                    .firstWhereOrNull((element) =>
                                        element.subjectCode ==
                                        storageItem.subjectCode)
                                    ?.subjectTitle;
                                return ListTile(
                                  style: ListTileStyle.list,
                                  title: Text(
                                    storageItem.title,
                                    style: selectedUpload?.uploadId ==
                                            storageItem.uploadId
                                        ? const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: LastpageColors.darkGrey,
                                          )
                                        : null,
                                  ),
                                  subtitle: Text(
                                    subjectTitle ?? storageItem.subjectCode,
                                    style: selectedUpload?.uploadId ==
                                            storageItem.uploadId
                                        ? const TextStyle(
                                            color: LastpageColors.darkGrey,
                                            fontSize: 14,
                                            overflow: TextOverflow.ellipsis,
                                          )
                                        : const TextStyle(fontSize: 14),
                                  ),
                                  selected: selectedUpload?.uploadId ==
                                      storageItem.uploadId,
                                  selectedTileColor: LastpageColors.white,
                                  trailing: selectedUpload?.uploadId ==
                                          storageItem.uploadId
                                      ? const CircleAvatar(
                                          radius: 4,
                                          backgroundColor: LastpageColors.blue,
                                        )
                                      : null,
                                  onTap: () {
                                    setState(() {
                                      if (selectedUpload == null) {
                                        selectedUpload = storageItem;
                                      } else {
                                        if (selectedUpload!.uploadId ==
                                            storageItem.uploadId) {
                                          selectedUpload = null;
                                        } else {
                                          selectedUpload = storageItem;
                                        }
                                      }
                                    });
                                  },
                                );
                              });
                        });
                  }
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                },
              ),
            ),
          ),
          SizedBox(
            width: selectedUpload != null ? 400 : 0,
            child: selectedUpload != null
                ? PreviewNote(selectedUpload: selectedUpload!)
                : null,
          )
        ],
      ),
    );
  }
}
