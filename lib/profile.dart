import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Settings"),
        centerTitle: true,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.blue,
      ),
      body: const Profile(),
    );
  }
}

class Profile extends StatelessWidget {
  const Profile({super.key});

  Future<bool> _onWillPop() async {
    // Check the user's authentication state
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      // User is logged in, allow navigation
      return true;
    } else {
      // User is logged out, prevent navigation

      return false;
    }
  }

  Future<void> _logout(BuildContext context) async {
    try {
      await FirebaseAuth.instance.signOut();
      Navigator.pushNamed(context, '/login');
    } catch (e) {
      print('Error signing out: $e');
      // Handle any sign-out errors here
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "User Profile",
              style: TextStyle(
                  fontFamily: AutofillHints.addressState, fontSize: 25.0),
            ),
            const SizedBox(height: 16.0),
            const Text(
              "Email Address",
              style: TextStyle(
                  fontFamily: AutofillHints.addressState, fontSize: 25.0),
            ),
            const SizedBox(height: 16.0),
            const Text(
              "User Address",
              style: TextStyle(
                  fontFamily: AutofillHints.addressState, fontSize: 25.0),
            ),
            const SizedBox(height: 16.0),
            Row(
              children: [
                const Text(
                  "User Profile",
                  style: TextStyle(
                      fontFamily: AutofillHints.addressState, fontSize: 25.0),
                ),
                Container(
                  margin: const EdgeInsets.only(left: 8.0),
                  child: const Text(
                    "hlalelemaroa@gmail.com",
                    style: TextStyle(
                      fontFamily: AutofillHints.addressState,
                      fontSize: 18.0,
                    ),
                  ),
                )
              ],
            ),
            const SizedBox(height: 64.0),
            ElevatedButton(
              style: ButtonStyle(
                fixedSize: MaterialStateProperty.all<Size>(
                  const Size(250, 30),
                ),
              ),
              child: const Text("Logout"),
              onPressed: () => _logout(context),
            )
          ],
        ),
      ),
    );
  }
}
