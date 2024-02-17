import 'package:flutter/material.dart';
import 'package:medi_connect/src/feature/login/auth_service.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
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
      body: const Center(
        child: Text('Profile Page'),
      ),
    );
  }
}
