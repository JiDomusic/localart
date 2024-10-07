import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:localart/firebase_options.dart';
import 'package:localart/scrennshome/myhomepage.dart';
import 'package:localart/scrennshome/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Art Local',
      theme: ThemeData(
        colorScheme: const ColorScheme.highContrastLight(),
        useMaterial3: true,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const SplashScreen(),
        '/home': (context) => const MyHomePage(),
      },
    );
  }
}
