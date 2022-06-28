import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_acrylic/flutter_acrylic.dart';
import 'package:lastpage/models/lastpage_colors.dart';
import 'package:lastpage/models/user_uploads/user_upload_info.dart';
import 'package:lastpage/screens/fullscreen_view.dart';

class PreviewNote extends StatefulWidget {
  const PreviewNote({required this.selectedUpload, Key? key}) : super(key: key);

  final UserUploadInfo selectedUpload;

  @override
  State<PreviewNote> createState() => _PreviewNoteState();
}

class _PreviewNoteState extends State<PreviewNote> {
  var previewIdx = 0;
  @override
  Widget build(BuildContext context) {
    var maxIdx = widget.selectedUpload.localFilePaths!.length - 1;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Card(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          child: SizedBox(
            height: 150,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      const Text("Title "),
                      const SizedBox(width: 10),
                      Text(
                        widget.selectedUpload.title,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      const Text("Subject "),
                      const SizedBox(width: 10),
                      Text(
                        widget.selectedUpload.subjectCode,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      const Text("Semester "),
                      const SizedBox(width: 10),
                      Text(
                        widget.selectedUpload.semesterNo.toString(),
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      const Text("Created "),
                      const SizedBox(width: 10),
                      Text(
                        widget.selectedUpload.createdDateTime.toString(),
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        Card(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                height: 300,
                width: 180,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5.0),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(5),
                  child: Image.file(
                    File(widget.selectedUpload.localFilePaths![previewIdx]),
                    // height: 250,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
                  decoration: BoxDecoration(
                    border: Border.all(
                      // width: 1.0,
                      color: LastpageColors.lightGrey,
                    ),
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  child: Center(
                    child: Column(children: [
                      ElevatedButton.icon(
                        style: const ButtonStyle(enableFeedback: true),
                        onPressed: () {
                          Navigator.pushNamed(
                              context, FullscreenView.routeName);
                        },
                        icon: const Icon(Icons.launch_outlined),
                        label: const Text("OPEN"),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            OutlinedButton(
                              onPressed: previewIdx > 0
                                  ? () {
                                      if (previewIdx > 0) {
                                        setState(() {
                                          previewIdx -= 1;
                                        });
                                      }
                                    }
                                  : null,
                              child: const Icon(Icons.arrow_left),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            OutlinedButton(
                              onPressed: previewIdx < maxIdx
                                  ? () {
                                      if (previewIdx < maxIdx) {
                                        setState(() {
                                          previewIdx += 1;
                                        });
                                      }
                                    }
                                  : null,
                              child: const Icon(Icons.arrow_right),
                            ),
                          ]),
                    ]),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
