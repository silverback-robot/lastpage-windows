import 'dart:convert';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';
import 'package:lastpage/models/user_profile/user_profile.dart';
import 'package:lastpage/models/user_uploads/user_upload_info.dart';
import 'package:uuid/uuid.dart';

class FirestoreRestApi extends ChangeNotifier {
  late UserProfile userProfile;
  late UserUploadInfo userStorage;
  final _baseUrl = 'https://firestore.googleapis.com/v1';
  final _lastpageProjectId = 'lastpage-docscanner2-poc';
  final uuid = const Uuid();
  final String? _uid = FirebaseAuth.instance.currentUser?.uid;
  Future<String>? _idToken() => FirebaseAuth.instance.currentUser?.getIdToken();

// Signal changes detected in remote syllabus YAML URL
  bool _syllabusObsolete = false;
  bool get syllabusObsolete => _syllabusObsolete;
  set syllabusObsolete(bool status) {
    if (status != _syllabusObsolete) {
      _syllabusObsolete = status;
      notifyListeners();
    }
  }

  Future<Map<String, String>> get _authHeader async {
    var token = await _idToken();
    return {
      "Authorization": "Bearer $token",
    };
  }

  Future<bool> checkUserProfileExists() async {
    final prefs = await SharedPreferences.getInstance();
    var storedUid = prefs.getString('uid');
    if (storedUid == _uid) {
      print("Profile available in shared preferences");
      return true;
    } else {
      var profileStatus = await fetchUserProfile();
      return profileStatus;
    }
  }

  Future<bool> fetchUserProfile() async {
    final prefs = await SharedPreferences.getInstance();
    var token = await _idToken();
    final lastpageFirestoreEndpoint =
        "$_baseUrl/projects/$_lastpageProjectId/databases/(default)/documents";
    final userProfilePath = '$lastpageFirestoreEndpoint/users/$_uid';
    var url = Uri.parse(userProfilePath);

    var response = await http.get(url, headers: {
      "Authorization": "Bearer $token",
    });
    if (response.statusCode == 200) {
      try {
        Map<String, dynamic> deserialized = jsonDecode(response.body);
        var profile = UserProfile.fromJson(deserialized);
        // Empty storage box only if a different user has logged in
        var currentUid = prefs.getString('uid') ?? 'NO_PREVIOUS_UID';
        if (profile.uid != currentUid) {
          print("Logged in as a different user. Emptying storage box.");
          // Delete userStorage contents as login UID has changed (different user)
          final storageBox = await Hive.openBox<UserUploadInfo>('userStorage');
          await storageBox.clear();
          await prefs.setString('uid', profile.uid);
        }
        // Detect changes to syllabus YAML URL in User Profile and resync syllabus
        var currentSyllabusUrl =
            prefs.getString('syllabusYamlUrl') ?? 'UNAVAILABLE';
        if (profile.syllabusYamlUrl != currentSyllabusUrl) {
          print("Syllabus URL has changed in the User's Profile!");
          print("PREV: $currentSyllabusUrl");
          print("CURR: ${profile.syllabusYamlUrl}");
          await prefs.setString('syllabusYamlUrl', profile.syllabusYamlUrl);
          syllabusObsolete = true;
        }
        await prefs.setString('name', profile.name);
        await prefs.setString('avatar', profile.avatar ?? '');
        await prefs.setString('email', profile.avatar ?? '');
        await prefs.setString('university', profile.university);
        await prefs.setString('department', profile.department);
        await prefs.setInt('phone', profile.phone ?? 0);
      } catch (err) {
        print(err.toString());
      }
      return true;
    } else if (response.statusCode == 404) {
      return false;
    } else {
      return false;
    }
  }

  Future<void> fetchUserUploads() async {
    final storageBox = await Hive.openBox<UserUploadInfo>('userStorage');
    final availableDocIds = storageBox.keys.toList();
    final lastpageFirestoreEndpoint =
        "$_baseUrl/projects/$_lastpageProjectId/databases/(default)/documents";
    final userStoragePath = '$lastpageFirestoreEndpoint/users/$_uid/uploads';
    var url = Uri.parse(userStoragePath);
    var response = await http.get(url, headers: await _authHeader);
    if (response.statusCode == 200) {
      try {
        Map<String, dynamic> deserialized = jsonDecode(response.body);
        var storageDocList = deserialized["documents"] as List;
        for (var e in storageDocList) {
          var uploadInfo = UserUploadInfo.fromJson(e);
          // Avoid downloading notes that are already tracked locally
          // PENDING: Check for last update timestamp and download fresh if there's a newer version
          if (availableDocIds.contains(uploadInfo.uploadId)) {
            print("${uploadInfo.uploadId} already exists. Skipping...");
            continue;
          }
          // Fetch uploaded files and save local names to uploadInfo
          List<String> localFilePaths = [];
          for (var url in uploadInfo.downloadUrls) {
            var localFilePath = await _downloadFile(url);
            localFilePaths.add(localFilePath);
          }
          uploadInfo.localFilePaths = localFilePaths;
          await storageBox.put(uploadInfo.uploadId, uploadInfo);
        }
      } catch (err) {
        print(err.toString());
      } finally {
        print("Storage Box contains ${storageBox.length} document(s).");
        // await storageBox.close();
      }
    } else {
      print(
          "Response Code: ${response.statusCode}; Response Body: ${response.body}");
    }
  }

  Future<String> _downloadFile(String url) async {
    try {
      var dio = Dio();
      var saveDir = await getApplicationDocumentsDirectory();
      String uniqueLocalName = "lastpage-${uuid.v1()}.png";
      String savePath = "${saveDir.path}\\$uniqueLocalName";
      Response response = await dio.get(
        url,
        options: Options(
          responseType: ResponseType.bytes,
          followRedirects: false,
        ),
      );
      // print(response.headers);
      File file = File(savePath);
      var raf = file.openSync(mode: FileMode.write);
      raf.writeFromSync(response.data);
      await raf.close();
      return savePath;
    } catch (e) {
      print(e);
      rethrow;
    }
  }
}
