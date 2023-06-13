import 'package:booking_app/update.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class PaymentList extends StatefulWidget {
  const PaymentList({super.key});

  @override
  State<PaymentList> createState() => _PaymentListState();
}

class _PaymentListState extends State<PaymentList> {
  Future<void> _editPayment(BuildContext context, String paymentId,
      String phone, String amount) async {
    // Navigate to the UpdatePayment form for editing
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => UpdatePayment(
          paymentId: paymentId,
          initialPhone: phone,
          initialAmount: amount,
        ),
      ),
    );
  }

  Future<void> _deletePayment(BuildContext context, String paymentId) async {
    // Show an alert dialog to confirm the deletion
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Delete Payment'),
          content: Text('Are you sure you want to delete this payment?'),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(true),
              child: Text('Delete'),
            ),
          ],
        );
      },
    );

    if (confirmed == true) {
      try {
        // Delete the payment from Firestore
        await FirebaseFirestore.instance
            .collection('payments')
            .doc(paymentId)
            .delete();
        Fluttertoast.showToast(
          msg: "Payment Deleted Successfully",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          backgroundColor: Colors.black54,
          textColor: Colors.green,
        );
      } catch (e) {
        print('Error deleting payment: $e');
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
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance.collection('payments').snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            }

            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            }

            final payments = snapshot.data!.docs;

            return ListView.builder(
              itemCount: payments.length,
              itemBuilder: (BuildContext context, int index) {
                final payment = payments[index].data() as Map<String, dynamic>;
                final amount = payment['amount'];
                final phone = payment['phone'];
                final paymentId = payments[index].id;

                return ListTile(
                  title: Text('Amount: $amount'),
                  subtitle: Text('Phone: $phone'),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: Icon(Icons.edit),
                        onPressed: () => IconButton(
                          icon: Icon(Icons.edit),
                          onPressed: () =>
                              _editPayment(context, paymentId, phone, amount),
                        ),
                      ),
                      IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () => _deletePayment(context, paymentId),
                      ),
                    ],
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
