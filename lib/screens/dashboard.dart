import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:lastpage/models/user_auth.dart';
import 'package:lastpage/models/user_profile.dart';
import 'package:lastpage/services/firestore_rest_api.dart';
import 'package:provider/provider.dart';

class Dashboard extends StatelessWidget {
  Dashboard({Key? key}) : super(key: key);

  static const routeName = '/dashboard';

  final testHttp = FirestoreRestApi();
  final profileBox = Hive.box('userProfile');

  @override
  Widget build(BuildContext context) {
    var profile = profileBox.getAt(0) as UserProfile;
    return Scaffold(
      appBar: AppBar(actions: [
        TextButton.icon(
          icon: const Icon(Icons.logout_outlined),
          onPressed: Provider.of<UserAuth>(context, listen: false).signOut,
          label: const Text("Sign Out"),
        )
      ]),
      body: Column(
        // TEMPORARY - Space Filler/Test Bed
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        mainAxisSize: MainAxisSize.max,
        children: [
          Text(profile.name),
          Center(
            child: ElevatedButton(
                onPressed: () {
                  testHttp.checkUserProfileExists();
                },
                child: const Text("HTTP TEST")),
          ),
        ],
      ),
    );
  }
}
