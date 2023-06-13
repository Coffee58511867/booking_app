import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class PaymentList extends StatelessWidget {
  const PaymentList({Key? key}) : super(key: key);
  Future<void> _deletePayment(String paymentId) async {
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

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('payments').snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
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
                trailing: IconButton(
                  icon: const Icon(
                    Icons.delete,
                    color: Colors.red,
                  ),
                  onPressed: () => _deletePayment(paymentId),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
