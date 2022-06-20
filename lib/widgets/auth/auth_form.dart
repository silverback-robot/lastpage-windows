import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AuthForm extends StatefulWidget {
  const AuthForm({required this.submitFn, required this.loading, Key? key})
      : super(key: key);

  final bool loading;

  final void Function(
    String email,
    String password,
    bool signUpMode,
    BuildContext context,
  ) submitFn;

  @override
  State<AuthForm> createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final _formKey = GlobalKey<FormState>();

  bool _signUp = true;

  late String _userEmail;
  late String _userPassword;

  String? _tmpPassword;

  void _submitForm() {
    final validForm = _formKey.currentState!.validate();
    FocusScope.of(context).unfocus();

    if (validForm) {
      _formKey.currentState!.save();
      widget.submitFn(
        _userEmail.trim(),
        _userPassword.trim(),
        _signUp,
        context,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        margin: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SvgPicture.asset("assets/logo/lastpage_logo.svg",
                        alignment: Alignment.center, height: 50.0),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      key: const ValueKey("email"),
                      decoration: const InputDecoration(
                        labelText: "Email",
                      ),
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) {
                        if (value == null || !value.contains('@')) {
                          return "Please enter a valid email address";
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _userEmail = value!;
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      key: const ValueKey("password"),
                      decoration: const InputDecoration(labelText: "Password"),
                      keyboardType: TextInputType.visiblePassword,
                      obscureText: true,
                      onChanged: (value) {
                        _tmpPassword = value;
                      },
                      validator: (value) {
                        if (value == null || value.length < 7) {
                          return "Password must be minimum 7 characters long";
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _userPassword = value!;
                      },
                    ),
                  ),
                  if (_signUp)
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        key: const ValueKey("confirm_password"),
                        decoration: const InputDecoration(
                            labelText: "Confirm Password"),
                        keyboardType: TextInputType.visiblePassword,
                        obscureText: true,
                        validator: (value) {
                          if (value == null || value != _tmpPassword) {
                            return "Passwords do not match";
                          }
                          return null;
                        },
                      ),
                    ),
                  const SizedBox(
                    height: 12,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                      onPressed: widget.loading ? null : _submitForm,
                      child: widget.loading
                          ? const SizedBox(
                              width: 25,
                              height: 25,
                              child: CircularProgressIndicator(),
                            )
                          : Text(_signUp ? "Sign Up" : "Login"),
                    ),
                  ),
                  widget.loading
                      ? const SizedBox(
                          width: 10,
                        )
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(_signUp
                                ? "Have an account?"
                                : "Don't have an account?"),
                            TextButton(
                              onPressed: () {
                                setState(
                                  () {
                                    _signUp = !_signUp;
                                    _formKey.currentState?.reset();
                                  },
                                );
                              },
                              child: Text(
                                _signUp ? " Login instead." : "Sign up.",
                              ),
                            ),
                          ],
                        )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
