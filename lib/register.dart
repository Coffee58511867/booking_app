import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController namesController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController genderController = TextEditingController();

  String? emailErrorText;
  String? passwordErrorText;
  String? namesErrorText;
  String? phoneErrorText;
  String? genderErrorText;

  Future<void> _register() async {
    String email = emailController.text;
    String password = passwordController.text;
    String names = namesController.text;
    String phone = phoneController.text;
    String gender = genderController.text;

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
    // Validate names field
    if (names.isEmpty) {
      setState(() {
        namesErrorText = 'Full names are required';
      });
    } else {
      setState(() {
        namesErrorText = null;
      });
    }
    // Validate Gender field
    if (gender.isEmpty) {
      setState(() {
        genderErrorText = 'Gender is required';
      });
    } else {
      setState(() {
        genderErrorText = null;
      });
    }

    // Validate names field
    if (phone.isEmpty) {
      setState(() {
        phoneErrorText = 'Phone number is required';
      });
    } else {
      setState(() {
        phoneErrorText = null;
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
    if (emailErrorText == null &&
        passwordErrorText == null &&
        namesErrorText == null &&
        phoneErrorText == null &&
        genderErrorText == null) {
      // Create a map of the data you want to send
      Map<String, dynamic> userData = {
        'email': email,
        'password': password,
        'names': names,
        'phone': phone,
        'gender': gender,
      };

      try {
        // Create user with email and password
        UserCredential userCredential =
            await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );

        // Get the newly created user's ID
        String userId = userCredential.user!.uid;
        print(userId);
        // Send the data to Firestore
        await FirebaseFirestore.instance.collection('users').add(userData);

        // Clear fields
        emailController.clear();
        passwordController.clear();
        phoneController.clear();
        genderController.clear();
        namesController.clear();
        Fluttertoast.showToast(
          msg: "Account created Sucessfully",
          toastLength: Toast
              .LENGTH_SHORT, // Duration for which the toast will be visible
          gravity: ToastGravity
              .CENTER, // Position of the toast message on the screen
          backgroundColor:
              Colors.black54, // Background color of the toast message
          textColor: Colors.green, // Text color of the toast message
        );
        // Navigate to dashboard
        Navigator.pushNamed(context, '/');
      } catch (e) {
        // Handle any errors that occur during the data submission

        print('Error submitting data: $e');
        Fluttertoast.showToast(
          msg: "Something went wrong please try again",
          toastLength: Toast
              .LENGTH_SHORT, // Duration for which the toast will be visible
          gravity: ToastGravity
              .CENTER, // Position of the toast message on the screen
          backgroundColor:
              Colors.black54, // Background color of the toast message
          textColor: Colors.red, // Text color of the toast message
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Create an Account"),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Create An Account",
              style: TextStyle(fontSize: 23.0),
            ),
            const SizedBox(height: 32.0),
            TextField(
              controller: namesController,
              onChanged: (value) {
                if (value.isEmpty) {
                  setState(() {
                    namesErrorText = 'Full names are required';
                  });
                } else {
                  setState(() {
                    namesErrorText = null;
                  });
                }
              },
              decoration: InputDecoration(
                labelText: 'Full Names',
                errorText: namesErrorText,
              ),
            ),
            const SizedBox(height: 16.0),
            TextField(
              controller: phoneController,
              onChanged: (value) {
                if (value.isEmpty) {
                  setState(() {
                    phoneErrorText = 'Phone number is required';
                  });
                } else {
                  setState(() {
                    phoneErrorText = null;
                  });
                }
              },
              decoration: InputDecoration(
                  labelText: 'Phone Numbers', errorText: phoneErrorText),
            ),
            const SizedBox(height: 16.0),
            TextField(
              controller: genderController,
              onChanged: (value) {
                if (value.isEmpty) {
                  setState(() {
                    genderErrorText = 'Gender is required';
                  });
                } else {
                  setState(() {
                    genderErrorText = null;
                  });
                }
              },
              decoration: InputDecoration(
                labelText: 'Gender',
                errorText: genderErrorText,
              ),
            ),
            const SizedBox(height: 16.0),
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
                errorText: passwordErrorText,
              ),
              obscureText: true,
            ),
            const SizedBox(height: 24.0),
            ElevatedButton(
              style: ButtonStyle(
                fixedSize: MaterialStateProperty.all<Size>(
                  const Size(250, 30),
                ),
              ),
              onPressed: _register,
              child: const Text('Register Here'),
            ),
          ],
        ),
      ),
    );
  }
}
