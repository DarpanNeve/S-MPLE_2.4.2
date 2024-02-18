import 'dart:typed_data';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:medi_connect/src/feature/login/auth_service.dart';
import 'package:file_picker/file_picker.dart';
class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final currentUser = FirebaseAuth.instance.currentUser;

  Future<void> _pickPDF() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );

    if (result != null) {
      Uint8List? fileBytes = result.files.first.bytes;
      String fileName = result.files.first.name;
      await FirebaseStorage.instance.ref('uploads/$fileName').putData(fileBytes!);
    }
    }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        actions: [
          IconButton(
              onPressed: (){
                AuthService().signOut(context);
                Navigator.popUntil(context, (route) => route.isFirst);
              },
              icon:const Icon(Icons.logout),
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
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text("Past Records",
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ],
            ),
          ),
          ElevatedButton(
              onPressed: (){
                _pickPDF();
              },
              child: const Column(
                children:  [
                  Icon(Icons.cloud_upload),
                  Text("Add Record"),
                ],
              ),

          ),


        ],
      ),


    );
  }
}
