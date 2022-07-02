import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:lastpage/models/user_auth.dart';
import 'package:lastpage/widgets/auth/profile_redirect.dart';
import 'package:provider/provider.dart';

import '../../screens/auth_screen.dart';

class AuthRedirect extends StatelessWidget {
  const AuthRedirect({
    Key? key,
  }) : super(key: key);

  static const routeName = '/auth_redirect';

  @override
  Widget build(BuildContext context) {
    final authState = Provider.of<UserAuth>(context, listen: false);
    return StreamBuilder(
      stream: authState.auth.authStateChanges(),
      initialData: authState.user,
      builder: (ctx, AsyncSnapshot<User?> userSnapshot) {
        if (userSnapshot.hasData) {
          return const ProfileRedirect();
        }
        return const AuthScreen();
        // return const AuthScreen();
      },
    );
  }
}
