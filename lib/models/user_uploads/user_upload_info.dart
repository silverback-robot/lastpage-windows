import 'package:hive/hive.dart';

part 'user_upload_info.g.dart';

@HiveType(typeId: 0)
class UserUploadInfo {
  @HiveField(0)
  String uploadId;

  @HiveField(1)
  int unitNo;

  @HiveField(2)
  String title;

  @HiveField(3)
  String setId;

  @HiveField(4)
  DateTime createdDateTime;

  @HiveField(5)
  List<String> downloadUrls;

  @HiveField(6)
  String subjectCode;

  @HiveField(7)
  int semesterNo;

  UserUploadInfo({
    required this.uploadId,
    required this.unitNo,
    required this.title,
    required this.setId,
    required this.createdDateTime,
    required this.downloadUrls,
    required this.subjectCode,
    required this.semesterNo,
  });

  factory UserUploadInfo.fromJson(Map<String, dynamic> json) {
    var uploadId = (json["name"] as String).split('/').last;
    var jsonFields = json["fields"] as Map<String, dynamic>;
    var unitNo = int.parse(jsonFields["unitNo"]["integerValue"]);
    var title = jsonFields["title"]["stringValue"] as String;
    var setId = jsonFields["setId"]["stringValue"] as String;
    var createdDateTime =
        int.parse(jsonFields["createdDateTime"]["stringValue"]);
    var downloadUrls =
        (jsonFields["downloadUrls"]["arrayValue"]["values"] as List)
            .map((e) => e.values.first.toString())
            .toList();
    var subjectCode = jsonFields["subjectCode"]["stringValue"] as String;
    var semesterNo = int.parse(jsonFields["semesterNo"]["integerValue"]);

    return UserUploadInfo(
      uploadId: uploadId,
      unitNo: unitNo,
      title: title,
      setId: setId,
      createdDateTime: DateTime.fromMillisecondsSinceEpoch(createdDateTime),
      downloadUrls: downloadUrls,
      subjectCode: subjectCode,
      semesterNo: semesterNo,
    );
  }
}
