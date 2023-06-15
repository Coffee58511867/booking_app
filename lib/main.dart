import 'package:booking_app/add_image.dart';
import 'package:booking_app/dashboard.dart';
import 'package:booking_app/home.dart';
import 'package:booking_app/login.dart';
import 'package:booking_app/payment_list.dart';
import 'package:booking_app/profile.dart';
import 'package:booking_app/register.dart';
import 'package:booking_app/splash.dart';
import 'package:booking_app/tabs.dart';
import 'package:booking_app/view_images.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: {
        '/': (context) => const SplashPage(),
        '/login': (context) => const LoginPage(),
        '/register': (context) => const RegisterPage(),
        '/profile': (context) => const ProfilePage(),
        '/dashboard': (context) => const DashboardPage(),
        '/home': (context) => const HomePage(),
        '/uploadImage': (context) => const AddImagePage(),
        '/images': (context) => const ViewImages(),
        '/payments': (context) => const PaymentList(),
        '/tabs': (context) => const TabPage(),
      },
    );
  }
}
