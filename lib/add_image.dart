import 'dart:io';

import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';

class AddImagePage extends StatefulWidget {
  const AddImagePage({super.key});

  @override
  _AddImagePageState createState() => _AddImagePageState();
}

class _AddImagePageState extends State<AddImagePage> {
  bool _uploading = false;
  String _imageURL = "";

  Future<void> _selectAndUploadImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile == null) return;

    setState(() {
      _uploading = true;
    });

    final storageRef = firebase_storage.FirebaseStorage.instance
        .ref()
        .child('images')
        .child('${pickedFile.name}');
    final uploadTask = storageRef.putFile(File(pickedFile.path));

    final snapshot = await uploadTask.whenComplete(() {});
    final downloadURL = await snapshot.ref.getDownloadURL();

    setState(() {
      _uploading = false;
      _imageURL = downloadURL;
    });

    FirebaseFirestore.instance
        .collection('images')
        .doc()
        .set({'imageURL': _imageURL});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Image'),
        actions: [
          ElevatedButton(
              child: const Text("Images"),
              onPressed: () {
                Navigator.pushNamed(context, '/images');
              }),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _imageURL != null
                ? Image.file(
                    File(_imageURL),
                    height: 200,
                  )
                : Container(),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _selectAndUploadImage,
              child: Text('Upload Image'),
            ),
            const SizedBox(height: 16),
            _uploading
                ? const CircularProgressIndicator()
                : (_imageURL != null
                    ? const Text('Image uploaded successfully!')
                    : Container()),
          ],
        ),
      ),
    );
  }
}
