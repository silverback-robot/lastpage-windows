import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:lastpage/models/user_auth.dart';
import 'package:lastpage/models/user_profile/user_profile.dart';
import 'package:lastpage/services/firestore_rest_api.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({Key? key}) : super(key: key);

  static const routeName = '/dashboard';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(actions: [
        TextButton.icon(
          icon: const Icon(Icons.logout_outlined),
          onPressed: Provider.of<UserAuth>(context, listen: false).signOut,
          label: const Text("Sign Out"),
        )
      ]),
      body: FutureBuilder<SharedPreferences>(
          future: SharedPreferences.getInstance(),
          builder: (BuildContext context,
              AsyncSnapshot<SharedPreferences> sharedPrefSnapshot) {
            if (sharedPrefSnapshot.hasData) {
              var prefs = sharedPrefSnapshot.data!;
              return Column(
                // TEMPORARY - Space Filler/Test Bed
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Text(prefs.getString('name')!),
                  Center(
                    child: ElevatedButton(
                        onPressed: () {
                          Provider.of<FirestoreRestApi>(context, listen: false)
                              .fetchUserUploads();
                        },
                        child: const Text("HTTP TEST")),
                  ),
                ],
              );
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          }),
    );
  }
}
