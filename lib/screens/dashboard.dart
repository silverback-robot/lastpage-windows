import 'package:flutter/material.dart';
import 'package:lastpage/models/user_auth.dart';
import 'package:lastpage/services/firestore_rest_api.dart';
import 'package:provider/provider.dart';

class Dashboard extends StatelessWidget {
  Dashboard({Key? key}) : super(key: key);

  static const routeName = '/dashboard';

  final testHttp = FirestoreRestApi();

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
      body: Center(
        child: ElevatedButton(
            onPressed: () {
              testHttp.checkUserProfileExists();
            },
            child: const Text("HTTP TEST")),
      ),
    );
  }
}
