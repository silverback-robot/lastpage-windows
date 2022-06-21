import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class FirestoreRestApi extends ChangeNotifier {
  final baseUrl = 'https://firestore.googleapis.com/v1';
  final lastpageProjectId = 'lastpage-docscanner2-poc';

  final String? _uid = FirebaseAuth.instance.currentUser?.uid;
  Future<String>? _idToken() => FirebaseAuth.instance.currentUser?.getIdToken();

  Future<bool> checkUserProfileExists() async {
    var token = await _idToken();

    final lastpageFirestoreEndpoint =
        "$baseUrl/projects/$lastpageProjectId/databases/(default)/documents";
    final userProfilePath = '$lastpageFirestoreEndpoint/users/$_uid';
    var url = Uri.parse(userProfilePath);

    var response = await http.get(url, headers: {
      "Authorization": "Bearer $token",
    });
    if (response.statusCode == 200) {
      print(response.statusCode);
      print(response.body);
      return true;
    } else if (response.statusCode == 404) {
      print(response.statusCode);
      print(response.body);
      return false;
    } else {
      return false;
    }
  }
}
