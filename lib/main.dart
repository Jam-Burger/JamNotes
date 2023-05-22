import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:jamnotes/firebase_options.dart';
import 'package:jamnotes/views/email_varification_view.dart';
import 'package:jamnotes/views/login_view.dart';
import 'package:jamnotes/views/register_view.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MaterialApp(
    title: 'Flutter Demo',
    theme: ThemeData(
      colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      useMaterial3: true,
    ),
    home: const Homepage(),
    routes: {
      '/login/': (context) => const LoginView(),
      '/register/': (context) => const RegisterView(),
    },
  ));
}

class Homepage extends StatelessWidget {
  const Homepage({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Firebase.initializeApp(
          options: DefaultFirebaseOptions.currentPlatform),
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.done:
            final user = FirebaseAuth.instance.currentUser;
            if (user != null) {
              if (user.emailVerified) {
                print('Email is varified');
                return const Text('Done');
              } else {
                return const EmailVarificationView();
              }
            } else {
              return const LoginView();
            }
          default:
            return const CircularProgressIndicator();
        }
      },
    );
  }
}
