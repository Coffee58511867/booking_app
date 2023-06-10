import 'package:booking_app/dashboard.dart';
import 'package:booking_app/home.dart';
import 'package:booking_app/login.dart';
import 'package:booking_app/profile.dart';
import 'package:booking_app/register.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: {
        '/': (context) => const LoginPage(),
        '/register': (context) => const RegisterPage(),
        '/profile': (context) => const ProfilePage(),
        '/dashboard': (context) => const DashboardPage(),
        '/home': (context) => const HomePage(),
      },
    );
  }
}
