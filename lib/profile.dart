import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  Future<bool> _onWillPop() async {
    return false; // Prevent navigating back using the back button
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Settings"),
          centerTitle: true,
          automaticallyImplyLeading: false,
          backgroundColor: Colors.blue,
        ),
        body: const Profile(),
      ),
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
      Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false);
    } catch (e) {
      print('Error signing out: $e');
      // Handle any sign-out errors here
    }
  }

  @override
  Widget build(BuildContext context) {
    // Get the current user's email
    String? userEmail = FirebaseAuth.instance.currentUser?.email;
    String? userName = FirebaseAuth.instance.currentUser?.displayName;
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
            Text(
              userName!,
              style: TextStyle(
                  fontFamily: AutofillHints.addressState, fontSize: 25.0),
            ),
            const SizedBox(height: 16.0),
            Row(
              children: [
                const Text(
                  "Email",
                  style: TextStyle(
                      fontFamily: AutofillHints.addressState,
                      fontSize: 25.0,
                      fontWeight: FontWeight.w400),
                ),
                Container(
                  margin: const EdgeInsets.only(left: 8.0),
                  child: Text(
                    userEmail!,
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
