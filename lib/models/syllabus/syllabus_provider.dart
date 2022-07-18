import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:lastpage/models/syllabus/subject.dart';
import 'package:lastpage/models/syllabus/syllabus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:yaml/yaml.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io' as io;

//TODO: CRITICAL: Set `syllabusYamlUrl` in userProfile document at the time of profile creation
class SyllabusProvider extends ChangeNotifier {
  Syllabus? syllabus;

  SyllabusProvider() {
    _processSyllabusYaml();
    notifyListeners();
  }
  //Check whether syllabus YAML exists
  Future<String> _getSyllabusPath() async {
    var appDir = await getApplicationSupportDirectory();
    var syllabusPath = io.File('${appDir.path}\\syllabus.yaml');
    var syllabusExists = syllabusPath.existsSync();
    if (!syllabusExists) {
      // Get user's syllabus URL from userProfile
      final prefs = await SharedPreferences.getInstance();
      var syllabusYamlUrl = prefs.getString('syllabusYamlUrl')!;
      // Download and rename syllabus yaml as `syllabus.yaml`
      var syllabusYamlPath = await _downloadSyllabus(syllabusYamlUrl);
      return syllabusYamlPath;
    } else {
      return syllabusPath.path;
    }
  }

  // Download syllabus YAML and set proper name
  Future<String> _downloadSyllabus(String url) async {
    try {
      var dio = Dio();
      var saveDir = await getApplicationSupportDirectory();
      String filename = "syllabus.yaml";
      String savePath = "${saveDir.path}\\$filename";
      Response response = await dio.get(
        url,
        options: Options(
          responseType: ResponseType.bytes,
          followRedirects: false,
        ),
      );
      io.File file = io.File(savePath);
      var raf = file.openSync(mode: io.FileMode.write);
      raf.writeFromSync(response.data);
      await raf.close();
      return savePath;
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  _processSyllabusYaml() async {
    var syllabusPath = await _getSyllabusPath();
    final data = await io.File(syllabusPath).readAsString();
    final mapData = loadYaml(data);

    var university = mapData["university"];
    var course = mapData["course"];
    var syllabusVersion = mapData["syllabus_version"];
    var subjectsList = ((mapData["subjects"] ?? []) as List);
    List<Subject> subjects = [];
    for (var subject in subjectsList) {
      var subjectUnitsRaw = ((subject['subjectUnits'] ?? []) as List);
      List<SubjectUnit> subjectUnits = [];
      for (var item in subjectUnitsRaw) {
        var subjectUnit = SubjectUnit(
          unitNumber: item['unitNumber'],
          unitTitle: item['unitTitle'],
          unitContents: item['unitContents'],
        );
        subjectUnits.add(subjectUnit);
      }
    }
    syllabus = Syllabus(
      university: university,
      course: course,
      syllabusVersion: syllabusVersion,
      subjects: subjects,
    );
    notifyListeners();
  }
}
