import 'package:flutter/material.dart';
import 'package:lastpage/models/user_auth.dart';
import 'package:provider/provider.dart';

class UpdateProfile extends StatelessWidget {
  const UpdateProfile({Key? key}) : super(key: key);

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
      body: const Center(
        child: Text("TODO: UPDATE PROFILE SCREEN"),
      ),
    );
  }
}
