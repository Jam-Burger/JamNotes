import 'dart:developer' as devtools show log;

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:jamnotes/constants/routes.dart';
import 'package:jamnotes/utilities/showAlertDialog.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  late final TextEditingController _email;
  late final TextEditingController _password;

  @override
  void initState() {
    _email =
        TextEditingController(text: FirebaseAuth.instance.currentUser?.email);
    _password = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: Column(
        children: [
          TextField(
            controller: _email,
            autocorrect: false,
            enableSuggestions: false,
            keyboardType: TextInputType.emailAddress,
            decoration: const InputDecoration(hintText: 'email'),
          ),
          TextField(
            controller: _password,
            obscureText: true,
            autocorrect: false,
            enableSuggestions: false,
            decoration: const InputDecoration(hintText: 'password'),
          ),
          TextButton(
            onPressed: () async {
              final email = _email.text;
              final password = _password.text;
              if (email.isEmpty || password.isEmpty) {
                if (context.mounted) {
                  showAlertDialog(
                    context,
                    'An Error Occured!',
                    'Enter all the details',
                  );
                }
                return;
              }
              try {
                await FirebaseAuth.instance.signInWithEmailAndPassword(
                  email: email,
                  password: password,
                );
                final user = FirebaseAuth.instance.currentUser;
                if (user != null) {
                  if (user.emailVerified) {
                    if (context.mounted) {
                      Navigator.of(context).pushNamedAndRemoveUntil(
                        mainRoute,
                        (route) => false,
                      );
                    }
                  } else {
                    if (context.mounted) {
                      showAlertDialog(
                        context,
                        'User Not Varified',
                        'Varify yourself first',
                      );
                    }
                    devtools.log('Varify yourself first');
                  }
                }
              } on FirebaseAuthException catch (e) {
                String message;
                switch (e.code) {
                  case 'user-not-found':
                    message = 'User is not found\nRegigister yourself first';
                    devtools.log('User not found');
                    break;
                  case 'wrong-password':
                    message = 'The password entered is wrong';
                    devtools.log('Wrong password');
                    break;
                  case 'invalid-email':
                    message = 'The email foemat is invalid';
                    devtools.log('Invalid email');
                    break;
                  default:
                    message = 'Unknown error : ${e.code}';
                    devtools.log(e.code);
                }
                if (context.mounted) {
                  showAlertDialog(
                    context,
                    'An Error Occured!',
                    message,
                  );
                }
              }
            },
            child: const Text('Login'),
          ),
          TextButton(
            onPressed: () {
              if (context.mounted) {
                Navigator.of(context).pushNamedAndRemoveUntil(
                  registerRoute,
                  (route) => false,
                );
              }
            },
            child: const Text('Register Here'),
          ),
        ],
      ),
    );
  }
}
