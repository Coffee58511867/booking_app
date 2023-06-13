import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class UpdatePayment extends StatefulWidget {
  final String paymentId;
  final String initialPhone;
  final String initialAmount;

  const UpdatePayment({
    required this.paymentId,
    required this.initialPhone,
    required this.initialAmount,
  });

  @override
  State<UpdatePayment> createState() => _UpdatePaymentState();
}

class _UpdatePaymentState extends State<UpdatePayment> {
  TextEditingController phoneController = TextEditingController();
  TextEditingController amountController = TextEditingController();

  String? amountErrorText;
  String? phoneErrorText;

  Future<void> _updatePayment() async {
    String updatedPhone = phoneController.text;
    String updatedAmount = amountController.text;

    // Validate phone field
    if (updatedPhone.isEmpty) {
      setState(() {
        phoneErrorText = 'Phone number is required';
      });
    } else {
      setState(() {
        phoneErrorText = null;
      });
    }

    // Validate amount field
    if (updatedAmount.isEmpty) {
      setState(() {
        amountErrorText = 'Amount is required';
      });
    } else {
      setState(() {
        amountErrorText = null;
      });
    }

    // Proceed with update if both fields are valid
    if (amountErrorText == null && phoneErrorText == null) {
      try {
        // Update the payment data in Firestore
        await FirebaseFirestore.instance
            .collection('payments')
            .doc(widget.paymentId)
            .update({
          'phone': updatedPhone,
          'amount': updatedAmount,
        });

        Fluttertoast.showToast(
          msg: "Payment Updated Successfully",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          backgroundColor: Colors.black54,
          textColor: Colors.green,
        );

        // Navigate back to the payment list
        Navigator.pop(context);
      } catch (e) {
        print('Error updating payment: $e');
        Fluttertoast.showToast(
          msg: "Something went wrong, please try again",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          backgroundColor: Colors.black54,
          textColor: Colors.red,
        );
      }
    }
  }

  @override
  void initState() {
    super.initState();
    phoneController.text = widget.initialPhone;
    amountController.text = widget.initialAmount;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Update Payment'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
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
              onPressed: _updatePayment,
              child: const Text('Update Payment'),
            ),
          ],
        ),
      ),
    );
  }
}
