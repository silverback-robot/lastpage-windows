import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lastpage/models/user_auth.dart';
import 'package:lastpage/screens/dashboard.dart';
import 'package:lastpage/widgets/auth/auth_form.dart';
import 'package:lastpage/widgets/window_behavior/title_bar.dart';
import 'package:provider/provider.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({Key? key}) : super(key: key);

  static const routeName = '/auth_screen';

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  bool _loading = false;

  void _submitAuth(
    String email,
    String password,
    bool signUp,
    BuildContext ctx,
  ) async {
    setState(() {
      _loading = true;
    });
    try {
      if (signUp) {
        await Provider.of<UserAuth>(context, listen: false)
            .createUserWithEmailAndPassword(
          email: email,
          password: password,
        );
      } else {
        await Provider.of<UserAuth>(context, listen: false)
            .signInWithEmailAndPassword(
          email: email,
          password: password,
        );
      }
    } on PlatformException catch (err) {
      var errMsg =
          "Something went wrong. Please check your internet connection.";
      if (err.message != null) {
        errMsg = err.message as String;
      }
      ScaffoldMessenger.of(ctx).showSnackBar(
        SnackBar(
          content: Text(
            errMsg,
          ),
          backgroundColor: Colors.red,
        ),
      );
      setState(() {
        _loading = false;
      });
    } on FirebaseAuthException catch (err) {
      var errMsg = "Something went wrong. Please check your credentials.";
      if (err.message != null) {
        errMsg = err.message as String;
      }
      ScaffoldMessenger.of(ctx).showSnackBar(
        SnackBar(
          content: Text(
            errMsg,
          ),
          backgroundColor: Colors.red,
        ),
      );
      setState(() {
        _loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          WindowTitleBarBox(
            child: Row(
              children: [Expanded(child: MoveWindow()), const WindowButtons()],
            ),
          ),
          Expanded(
            child: Center(
                child: SizedBox(
              width: 400,
              child: AuthForm(
                submitFn: _submitAuth,
                loading: _loading,
              ),
            )),
          ),
        ],
      ),
    );
  }
}
