import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class EcocashPage extends StatefulWidget {
  const EcocashPage({super.key});

  @override
  State<EcocashPage> createState() => _EcocashPageState();
}

class _EcocashPageState extends State<EcocashPage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Mpesa(),
    );
  }
}

class Mpesa extends StatefulWidget {
  const Mpesa({super.key});

  @override
  State<Mpesa> createState() => _MpesaState();
}

class _MpesaState extends State<Mpesa> {
  TextEditingController phoneController = TextEditingController();
  TextEditingController amountController = TextEditingController();

  String? amountErrorText;
  String? phoneErrorText;

  Future<void> _payment() async {
    String phone = phoneController.text;
    String amount = amountController.text;

    // Validate phone field
    if (phone.isEmpty) {
      setState(() {
        phoneErrorText = 'Phone number is required';
      });
    } else {
      setState(() {
        phoneErrorText = null;
      });
    }

    // Validate amount field
    if (amount.isEmpty) {
      setState(() {
        amountErrorText = 'Amount is required';
      });
    } else if (amount.length < 5) {
      setState(() {
        amountErrorText = 'Amount can not be Less than M5';
      });
    } else {
      setState(() {
        amountErrorText = null;
      });
    }

    // Proceed with registration if both fields are valid
    if (amountErrorText == null && phoneErrorText == null) {
      // Create a map of the data you want to send
      Map<String, dynamic> userData = {
        'amount': amount,
        'phone': phone,
      };
      try {
        // Send the data to Firestore
        await FirebaseFirestore.instance.collection('users').add(userData);

        // Clear fields
        //clear fields
        amountController.clear();
        phoneController.clear();

        // Navigate to dashboard
        Navigator.pushNamed(context, '/');
      } catch (e) {
        // Handle any errors that occur during the data submission
        print('Error submitting data: $e');
      }

      //navigate to dashboard
      // Navigator.pushNamed(context, '/dashboard');
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
                labelText: 'Phone Numbers',
                errorText: phoneErrorText,
              ),
            ),
            const SizedBox(height: 16.0),
            TextField(
              controller: amountController,
              onChanged: (value) {
                if (value.isEmpty) {
                  setState(() {
                    amountErrorText = 'Amount is required';
                  });
                } else if (value.length < 8) {
                  setState(() {
                    amountErrorText = 'Amount can not be less than M5.00';
                  });
                } else {
                  setState(() {
                    amountErrorText = null;
                  });
                }
              },
              decoration: InputDecoration(
                labelText: 'Amount',
                errorText: amountErrorText,
              ),
            ),
            const SizedBox(height: 24.0),
            ElevatedButton(
              style: ButtonStyle(
                fixedSize: MaterialStateProperty.all<Size>(
                  const Size(250, 30),
                ),
              ),
              onPressed: _payment,
              child: const Text('Proceed to Pay'),
            ),
          ],
        ),
      ),
    );
  }
}
