import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:lastpage/models/user_profile/user_profile.dart';
import 'package:lastpage/models/user_uploads/user_upload_info.dart';

class FirestoreRestApi extends ChangeNotifier {
  late UserProfile userProfile;
  late UserUploadInfo userStorage;
  final _baseUrl = 'https://firestore.googleapis.com/v1';
  final _lastpageProjectId = 'lastpage-docscanner2-poc';
  final String? _uid = FirebaseAuth.instance.currentUser?.uid;
  Future<String>? _idToken() => FirebaseAuth.instance.currentUser?.getIdToken();

  Future<bool> checkUserProfileExists() async {
    final prefs = await SharedPreferences.getInstance();
    var storedUid = prefs.getString('uid');
    if (storedUid == _uid) {
      print("Profile available in shared preferences");
      return true;
    }
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
        await prefs.setString('uid', profile.uid);
        await prefs.setString('name', profile.name);
        await prefs.setString('avatar', profile.avatar ?? '');
        await prefs.setString('email', profile.avatar ?? '');
        await prefs.setString('university', profile.university);
        await prefs.setString('department', profile.department);
        await prefs.setInt('phone', profile.phone ?? 0);
      } catch (err) {
        print(err.toString());
      }
      print("Shared Preferences UID: ${prefs.getString('uid')}");
      return true;
    } else if (response.statusCode == 404) {
      return false;
    } else {
      return false;
    }
  }

  fetchUserUploads() async {
    final storageBox = await Hive.openBox<UserUploadInfo>('userStorage');
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

  Future<Map<String, String>> get _authHeader async {
    var token = await _idToken();
    return {
      "Authorization": "Bearer $token",
    };
  }
}
