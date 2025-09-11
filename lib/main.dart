import 'package:dio/dio.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:pantry_ai/core/theme/theme.dart';

import 'config/routes.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  final dio = Dio();
  final googleSignIn = GoogleSignIn();
  final storage = FlutterSecureStorage();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [],
      child: Builder(
        builder: (context) {
          return MaterialApp.router(
            routerConfig: createRouter(),
            theme: lightTheme,
            darkTheme: darkTheme,
            themeMode: ThemeMode.system,
            debugShowCheckedModeBanner: false,
          );
        },
      ),
    );
  }
}
