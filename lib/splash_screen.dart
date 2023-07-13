import 'package:first_app/page.dart';
import 'package:first_app/shared_pref.dart';
import 'package:first_app/simplefeed_page.dart';
import 'package:flutter/material.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Future.delayed(Duration(seconds: 2)).then((value) {
      var token = SharedPref.pref?.getString("token");

      if (token == null) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => LoginPage(),
          ),
        );
      } else {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => SimpleFeedPage(),
          ),
        );
      }
    });
    super.initState();
  }

  @override
   Widget build(BuildContext context) {
    return MaterialApp(
        home: Center(
          child: Container(
            width: double.infinity,
            height: double.infinity,
            child: Image.network(
              'https://images.unsplash.com/photo-1611162618758-2a29a995354b?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=327&q=80',
              fit: BoxFit.cover,
            ),
          ),
        ),
    );
  }
}