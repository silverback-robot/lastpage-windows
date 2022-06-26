import 'package:flutter/material.dart';
import 'package:lastpage/models/user_uploads/user_upload_info.dart';

class PreviewNote extends StatelessWidget {
  const PreviewNote({required this.selectedUpload, Key? key}) : super(key: key);

  final UserUploadInfo selectedUpload;

  @override
  Widget build(BuildContext context) {
    return Card(
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
                    selectedUpload.title,
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
                    selectedUpload.subjectCode,
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
                    selectedUpload.semesterNo.toString(),
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
                    selectedUpload.createdDateTime.toString(),
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
