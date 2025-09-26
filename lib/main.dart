import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'animations_implicit/animated_color_pallete.dart';
import 'animations_implicit/animated_shopping_cart_button.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const ShoppingCartButton(),
    );
  }
}


// class MyApp extends StatefulWidget {
//   const MyApp({super.key});
//
//   @override
//   State<MyApp> createState() => _MyAppState();
// }
//
// class _MyAppState extends State<MyApp> {
//   final FirebaseFirestore firestore = FirebaseFirestore.instance;
//   final FirebaseAuth firebase_auth = FirebaseAuth.instance;
//   final GoogleSignIn google_sign_in = GoogleSignIn();
//
//   @override
//   Widget build(BuildContext context) {
//     return MultiBlocProvider(
//       providers: [
//         BlocProvider(
//           create: (context) => AuthBloc(
//             authRepository: AuthRepositoryImpl(
//               firestore: firestore,
//               firebaseAuth: firebase_auth,
//               googleSignIn: google_sign_in,
//             ),
//           ),
//         ),
//       ],
//       child: Builder(
//         builder: (context) {
//           return MaterialApp.router(
//             routerConfig: createRouter(),
//             theme: lightTheme,
//             darkTheme: darkTheme,
//             themeMode: ThemeMode.system,
//             debugShowCheckedModeBanner: false,
//           );
//         },
//       ),
//     );
//   }
// }
