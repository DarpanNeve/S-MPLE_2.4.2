import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:medi_connect/src/feature/login/auth_service.dart';
import 'package:medi_connect/src/screens/profile/report_model.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../utils/strings_english.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  List<Report> reports = [];
  final currentUser = FirebaseAuth.instance.currentUser;
  Future<void> retrieveAndPrintData() async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection("report_upload")
        .doc(currentUser!.uid)
        .collection('reports')
        .get();

    querySnapshot.docs.forEach((doc) {
      reports.add(Report(
        title: doc['title'],
        url: doc['file location'],
      ));
      print('reports :${doc.data()}');
    });
    setState(() {
      reports = reports;
    });
    print(reports);
  }

  initState() {
    super.initState();
    retrieveAndPrintData();
  }
  _pickPDF() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );
    if (result != null) {
      File file = File(result.files.single.path!);
      String fileName = file.path.split('/').last;
      Reference ref = FirebaseStorage.instance
          .ref()
          .child("reports/${currentUser!.uid}")
          .child('${fileName}.pdf');
      UploadTask uploadTask = ref.putFile(file);
      uploadTask.whenComplete(() async {
        String url = await ref.getDownloadURL();
        print(url);
        _addDataToFirestore(url, fileName);
      });
    } else {
      // User canceled the picker
    }
  }

  _addDataToFirestore(String url, String fileName) async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    firestore
        .collection("report_upload")
        .doc(currentUser!.uid)
        .collection('reports')
        .add(
      {
        "file location": url,
        "title": fileName,
        "timestamp": FieldValue.serverTimestamp(),
      },
    );
    setState(() {
      reports = [];
    });
    retrieveAndPrintData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:  Text(profileHeader),
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
      body: SingleChildScrollView(
        child: Column(
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
              child: Column(
                children: [
                  Icon(Icons.cloud_upload),
                  Text(addRecord),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    pastRecords,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                ],
              ),
            ),
            Visibility(
              visible: reports.isNotEmpty,
              child: Column(
                children: reports
                    .map(
                      (e) => ListTile(
                        leading: Icon(Icons.picture_as_pdf),
                        title: Text(e.title),
                        onTap: () async {
                          if (await canLaunchUrl(Uri.parse(e.url))) {
                            await launchUrl(Uri.parse(e.url));
                          } else {
                            throw 'Could not launch $e.url';
                          }
                        },
                      ),
                    )
                    .toList(),
              ),
            )
          ],
        ),
      ),
    );
  }
}
