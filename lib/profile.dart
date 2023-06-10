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
            SizedBox(height: 16.0),
            Text(
              "User Address",
              style: TextStyle(
                  fontFamily: AutofillHints.addressState, fontSize: 25.0),
            ),
            SizedBox(height: 16.0),
            Row(
              children: [
                Text(
                  "User Profile",
                  style: TextStyle(
                      fontFamily: AutofillHints.addressState, fontSize: 25.0),
                ),
                Text(
                  "hlalelemaroa@gmail.com",
                  style: TextStyle(
                      fontFamily: AutofillHints.addressState, fontSize: 18.0),
                ),
                Container()
              ],
            )
          ],
        ),
      ),
    );
  }
}
