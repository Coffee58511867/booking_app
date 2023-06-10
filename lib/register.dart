import 'package:flutter/material.dart';

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

  void _register() {
    String email = emailController.text;
    String password = passwordController.text;
    String names = emailController.text;
    String phone = passwordController.text;
    String gender = emailController.text;

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
    } else if (phone.length != 8) {
      setState(() {
        phoneErrorText = 'Password should be at  8 digits long';
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
      //clear fields
      emailController.clear();
      passwordController.clear();
      phoneController.clear();
      genderController.clear();
      namesController.clear();
      //navigate to dashboard
      Navigator.pushNamed(context, '/');
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
            const TextField(
              decoration: InputDecoration(
                labelText: 'Email',
              ),
            ),
            const SizedBox(height: 16.0),
            const TextField(
              decoration: InputDecoration(
                labelText: 'Password',
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
