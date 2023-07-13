import 'package:first_app/shared_pref.dart';
import 'package:first_app/splash_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPref.init();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}

//git init
// git config --global user.name "usernameku-digithub"
// git config --global user.email "contoh@gmail.com"
// git add .
// git commit -m "commitan pertamaku"
// git branch -M main
// git remote add origin git@github.com:Thoriq-ha/koncoan_app.git
// git push -u origin main