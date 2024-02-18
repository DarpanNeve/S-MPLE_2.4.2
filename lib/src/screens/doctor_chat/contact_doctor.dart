import 'package:flutter/material.dart';
import 'package:medi_connect/src/feature/video_call/join_screen.dart';
import 'package:medi_connect/src/constants/dummy_doctor_list.dart';

class ContactDoctor extends StatelessWidget {
  const ContactDoctor({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Contact Doctor'),
        ),
        body: ListView.builder(
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(dummyDoctorList[index].name),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(dummyDoctorList[index].specialization),
                  Text(dummyDoctorList[index].location),
                ],
              ),
              trailing: IconButton(
                icon: const Icon(Icons.call),
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => JoinScreen()),
                  );
                },
              ),
            );
          },
          itemCount: dummyDoctorList.length,
        ));
  }
}
