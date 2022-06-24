import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;
import 'package:lastpage/models/user_profile.dart';

class FirestoreRestApi extends ChangeNotifier {
  final _baseUrl = 'https://firestore.googleapis.com/v1';
  final _lastpageProjectId = 'lastpage-docscanner2-poc';
  final String? _uid = FirebaseAuth.instance.currentUser?.uid;
  Future<String>? _idToken() => FirebaseAuth.instance.currentUser?.getIdToken();

  Future<bool> checkUserProfileExists() async {
    final profileBox = Hive.box('userProfile');
    var token = await _idToken();
    final lastpageFirestoreEndpoint =
        "$_baseUrl/projects/$_lastpageProjectId/databases/(default)/documents";
    final userProfilePath = '$lastpageFirestoreEndpoint/users/$_uid';
    var url = Uri.parse(userProfilePath);

    var response = await http.get(url, headers: {
      "Authorization": "Bearer $token",
    });
    if (response.statusCode == 200) {
      Map<String, dynamic> deserialized = jsonDecode(response.body);
      var profile = UserProfile.fromJson(deserialized);
      try {
        await profileBox.clear();
        await profileBox.add(profile);
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
}
