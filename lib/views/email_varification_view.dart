import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class EmailVarificationView extends StatefulWidget {
  const EmailVarificationView({super.key});

  @override
  State<EmailVarificationView> createState() => _EmailVarificationViewState();
}

class _EmailVarificationViewState extends State<EmailVarificationView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Varify Email'),
      ),
      body: Column(
          children: [
            const Text('Verify MF!!'),
            TextButton(
              onPressed: () async {
                final user= FirebaseAuth.instance.currentUser;
                await user?.sendEmailVerification();
              },
              child: const Text('Click me uhhh....'),
            )
          ],
        ),
    );
  }
}
