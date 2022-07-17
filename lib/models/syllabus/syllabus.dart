import 'package:flutter/services.dart' as s;
import 'package:yaml/yaml.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io' as io;

class Syllabus {
  //Check whether syllabus YAML exists
  checkSyllabusExists() {
    var syllabusExists = io.File('assets/data/syllabus.yaml').existsSync();
  }

  // Download syllabus YAML and set proper name
  downloadSyllabus() async {
    var appDir = await getApplicationSupportDirectory();
  }

  // Parse contents of syllabus YAML and load create list of 'subject' objects
  parseSyllabusYaml() async {
    final data = await s.rootBundle.loadString('assets/data/syllabus.yaml');
    final mapData = loadYaml(data);
  }
}
