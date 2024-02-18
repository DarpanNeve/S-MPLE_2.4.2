
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:medi_connect/src/feature/login/auth_service.dart';
import 'package:medi_connect/src/screens/profile/report_model.dart';
import 'package:firebase_database/firebase_database.dart';
class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  List<Report> reports = [];
  final currentUser = FirebaseAuth.instance.currentUser;
  final uid = FirebaseAuth.instance.currentUser!.uid;
  void fetchReports() async {
    final snapshot =
    await FirebaseFirestore.instance.collection('Report_Upload').doc(uid).get();
    if (snapshot.exists) {

    }

  }
  initState() {
    super.initState();
    fetchReports();
  }
  _pickPDF() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );
    if (result != null) {
      File file = File(result.files.single.path!);
      String fileName = file.path.split('/').last;
      Reference ref = FirebaseStorage.instance.ref().child("Reports/${currentUser!.uid}").child('${fileName}.pdf');
      UploadTask uploadTask = ref.putFile(file);
      uploadTask.whenComplete(() async {
        String url = await ref.getDownloadURL();
        print(url);
        _addDataToFirestore(url);
      });
    } else {
      // User canceled the picker
    }
  }

  _addDataToFirestore(String url) async {
    final timestamp = DateTime.now().millisecondsSinceEpoch.toString();
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    firestore.collection("Report_Upload").doc(currentUser!.uid).collection('reports').add(
      {
        "file location": url,
        "title": "Report",
        "timestamp": FieldValue.serverTimestamp(),
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        actions: [
          IconButton(
            onPressed: () {
              AuthService().signOut(context);
              Navigator.popUntil(context, (route) => route.isFirst);
            },
            icon: const Icon(Icons.logout),
          )
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 50,
                backgroundImage: NetworkImage(currentUser!.photoURL!),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Text(
            currentUser!.displayName.toString(),
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 20),
          Text(
            currentUser!.email.toString(),
            style: Theme.of(context).textTheme.titleMedium,
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.05,
          ),
          ElevatedButton(
            onPressed: () {
              _pickPDF();
            },
            child: const Column(
              children: [
                Icon(Icons.cloud_upload),
                Text("Add Record"),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  "Past Records",
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
