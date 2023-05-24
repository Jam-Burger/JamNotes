import 'dart:developer' as devtools show log;

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:jamnotes/constants/routes.dart';
import 'package:jamnotes/utilities/showAlertDialog.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  late final TextEditingController _email;
  late final TextEditingController _password;

  @override
  void initState() {
    _email = TextEditingController();
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
        title: const Text('Register'),
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
                await FirebaseAuth.instance.createUserWithEmailAndPassword(
                  email: email,
                  password: password,
                );
                final user = FirebaseAuth.instance.currentUser;
                await user?.sendEmailVerification().then((value) {
                  devtools.log('Email sent successfully to $email!');
                });
                if (context.mounted) {
                  Navigator.of(context).pushNamedAndRemoveUntil(
                    loginRoute,
                    (route) => false,
                  );
                }
              } on FirebaseAuthException catch (e) {
                String message;
                switch (e.code) {
                  case 'weak-password':
                    message =
                        'The password is weak\nTry to enter a stronger one';
                    devtools.log('Weak password');
                    break;
                  case 'email-already-in-use':
                    message =
                        'The email is already in use\nLogin or use a different email';
                    devtools.log('Email is already in use');
                    break;
                  case 'invalid-email':
                    message = 'The email foemat is invalid';
                    devtools.log('Invalid Email');
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
            child: const Text('Register'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pushNamedAndRemoveUntil(
                loginRoute,
                (route) => false,
              );
            },
            child: const Text('Login Here!'),
          ),
        ],
      ),
    );
  }
}
