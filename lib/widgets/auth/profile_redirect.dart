import 'package:flutter/material.dart';
import 'package:lastpage/services/firestore_rest_api.dart';
import 'package:provider/provider.dart';

import '../../screens/window_frame.dart';
import '../../screens/update_profile.dart';

class ProfileRedirect extends StatelessWidget {
  const ProfileRedirect({Key? key}) : super(key: key);

  static const routeName = '/profile_redirect';

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Provider.of<FirestoreRestApi>(context, listen: false)
          .checkUserProfileExists(),
      builder: (context, AsyncSnapshot<bool> profileSnapshot) {
        if (profileSnapshot.hasData) {
          if (profileSnapshot.data!) {
            return const WindowFrame();
          } else {
            return const UpdateProfile();
          }
        }
        return const Scaffold(
          body: Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }
}
