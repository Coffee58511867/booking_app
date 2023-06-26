import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Sign in"),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      body: const Signin(),
    );
  }
}

class Signin extends StatefulWidget {
  const Signin({super.key});

  @override
  State<Signin> createState() => _SigninState();
}

class _SigninState extends State<Signin> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  String? emailErrorText;
  String? passwordErrorText;
  String? loginErrorText; // New variable for login error message

  void _register() {
    String email = emailController.text;
    String password = passwordController.text;

    // Validate email field
    if (email.isEmpty) {
      setState(() {
        emailErrorText = 'Email is required';
      });
    } else {
      setState(() {
        emailErrorText = null;
      });
    }

    // Validate password field
    if (password.isEmpty) {
      setState(() {
        passwordErrorText = 'Password is required';
      });
    } else if (password.length < 8) {
      setState(() {
        passwordErrorText = 'Password should be at least 8 characters long';
      });
    } else {
      setState(() {
        passwordErrorText = null;
      });
    }

    // Proceed with registration if both fields are valid
    if (emailErrorText == null && passwordErrorText == null) {
      try {
        // Sign in the user with email and password
        FirebaseAuth.instance
            .signInWithEmailAndPassword(
          email: email,
          password: password,
        )
            .then((userCredential) {
          // Clear fields
          emailController.clear();
          passwordController.clear();

          // Navigate to dashboard or home screen
          Navigator.pushNamed(context, '/dashboard');
        }).catchError((error) {
          // Handle login errors
          setState(() {
            loginErrorText =
                'Incorrect email or password'; // Set login error message
          });
          print('Login error: $error');
        });
      } catch (e) {
        // Handle any other errors that occur during login
        print('Error occurred during login: $e');
      }
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
              "Welcome Back",
              style: TextStyle(fontSize: 23.0),
            ),
            const SizedBox(height: 16.0),
            TextField(
              controller: emailController,
              onChanged: (value) {
                if (value.isEmpty) {
                  setState(() {
                    emailErrorText = 'Email is required';
                  });
                } else {
                  setState(() {
                    emailErrorText = null;
                  });
                }
              },
              decoration: InputDecoration(
                labelText: 'Email',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                errorText: emailErrorText,
              ),
            ),
            const SizedBox(height: 16.0),
            TextField(
              controller: passwordController,
              onChanged: (value) {
                if (value.isEmpty) {
                  setState(() {
                    passwordErrorText = 'Password is required';
                  });
                } else if (value.length < 8) {
                  setState(() {
                    passwordErrorText =
                        'Password should be at least 8 characters long';
                  });
                } else {
                  setState(() {
                    passwordErrorText = null;
                  });
                }
              },
              decoration: InputDecoration(
                labelText: 'Password',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                errorText: passwordErrorText,
              ),
              obscureText: true,
            ),
            const SizedBox(height: 8.0),
            Text(
              loginErrorText ??
                  '', // Show login error message if it's not null, otherwise show an empty string
              style: TextStyle(color: Colors.red),
            ),
            const SizedBox(height: 24.0),
            ElevatedButton(
              style: ButtonStyle(
                fixedSize: MaterialStateProperty.all<Size>(
                  const Size(250, 30),
                ),
              ),
              onPressed: _register,
              child: const Text('Login'),
            ),
            const SizedBox(height: 10.0),
            ElevatedButton(
              style: ButtonStyle(
                fixedSize: MaterialStateProperty.all<Size>(
                  const Size(250, 30),
                ),
              ),
              onPressed: () {
                Navigator.pushNamed(context, '/register');
              },
              child: const Text('Register'),
            ),
          ],
        ),
      ),
    );
  }
}
