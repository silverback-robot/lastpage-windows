import 'package:flutter/material.dart';
import 'package:lastpage/models/syllabus/syllabus.dart';
import 'package:lastpage/models/user_auth.dart';
import 'package:provider/provider.dart';

class UpdateProfile extends StatelessWidget {
  const UpdateProfile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final syllabus = Syllabus();
    return Scaffold(
      appBar: AppBar(actions: [
        TextButton.icon(
          icon: const Icon(Icons.logout_outlined),
          onPressed: Provider.of<UserAuth>(context, listen: false).signOut,
          label: const Text("Sign Out"),
        )
      ]),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text("TODO: UPDATE PROFILE SCREEN"),
            ElevatedButton(
                onPressed: () {
                  syllabus.parseSyllabusYaml();
                },
                child: const Text("Fetch Syllabus")),
          ],
        ),
      ),
    );
  }
}
