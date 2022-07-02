import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:lastpage/models/user_uploads/user_upload_info.dart';
import 'package:lastpage/widgets/library/preview_note.dart';

class Library extends StatefulWidget {
  const Library({Key? key}) : super(key: key);

  static const routeName = '/library';

  @override
  State<Library> createState() => _LibraryState();
}

class _LibraryState extends State<Library> {
  UserUploadInfo? selectedUpload;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          SizedBox(
            width: 350,
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
                          return ListView.builder(
                              itemCount: box.keys.length,
                              itemBuilder: (context, index) {
                                UserUploadInfo storageItem = box.getAt(index);
                                return Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 4.0),
                                  child: ListTile(
                                    title: Text(storageItem.title),
                                    subtitle: Text(storageItem.subjectCode),
                                    onTap: () {
                                      setState(() {
                                        if (selectedUpload == null) {
                                          selectedUpload = storageItem;
                                        } else {
                                          selectedUpload = null;
                                        }
                                      });
                                    },
                                  ),
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
            width: 350,
            child: selectedUpload != null
                ? PreviewNote(selectedUpload: selectedUpload!)
                : null,
          )
        ],
      ),
    );
  }
}
