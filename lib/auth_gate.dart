import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart' hide EmailAuthProvider;
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:firebase_ui_oauth_google/firebase_ui_oauth_google.dart';
import 'home.dart';

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return SignInScreen(
            providers: [
              EmailAuthProvider(),
              GoogleProvider(clientId: '247288865958-pfqpvch7j51clrvb1rgc1k838oea3vud.apps.googleusercontent.com'),
            ],
            headerBuilder: (context, constraints, shrinkOffset) {
              return Padding(
                padding: const EdgeInsets.all(20),
                child: AspectRatio(
                  aspectRatio: 1,
                  child: Image.asset('assets/flutterfire.jpeg'),
                ),
              );
            },
            subtitleBuilder: (context, action) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: action == AuthAction.signIn
                  ? const Text('Bienvenido a flutterfire, por favor inicia sesión!')
                  : const Text('Bienvenido a flutterfire, por favor registrate!'),
              );
            },
            footerBuilder: (context, action) {
              return const Padding(
                padding: EdgeInsets.all(20),
                child: Text(
                  'Al iniciar sesión o registrarte, aceptas nuestros términos y condiciones.',
                  style: TextStyle(color: Colors.grey),
                ),
              );
            },
          );
        }
        return const HomeScreen();
      },
    );
  }
}