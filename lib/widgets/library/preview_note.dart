import 'dart:io';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
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
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 500,
        decoration: BoxDecoration(
            border: Border.all(width: 0.5, color: LastpageColors.lightGrey),
            color: LastpageColors.white,
            borderRadius: BorderRadius.circular(5)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.max,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  flex: 3,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(8.0, 0, 0, 0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Text(
                            widget.selectedUpload.title,
                            style: const TextStyle(
                                fontWeight: FontWeight.normal, fontSize: 24),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Text(
                            widget.selectedUpload.subjectCode,
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        // Text(
                        //   widget.selectedUpload.semesterNo.toString(),
                        // ),
                        Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Text(
                            "Created: ${DateFormat.yMMMMEEEEd().format(widget.selectedUpload.createdDateTime)}",
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Flexible(
                  flex: 1,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(4.0, 12.0, 4.0, 4.0),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 8, horizontal: 8),
                      decoration: BoxDecoration(
                        border: Border.all(
                          // width: 1.0,
                          color: LastpageColors.lightGrey,
                        ),
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      child: Center(
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.pushNamed(
                                context, FullscreenView.routeName,
                                arguments: widget.selectedUpload);
                          },
                          // icon: const Icon(Icons.launch_outlined),
                          child: const Text("OPEN"),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const Divider(
              color: LastpageColors.lightGrey,
              thickness: 1,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 250,
                  // width: 180,
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
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                    decoration: BoxDecoration(
                      border: Border.all(
                        // width: 1.0,
                        color: LastpageColors.lightGrey,
                      ),
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    child: Row(
                        mainAxisSize: MainAxisSize.min,
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
                            width: 5,
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
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
