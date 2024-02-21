import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import '../feature/payment_gateway.dart';

import '../utils/strings_english.dart';


class EmergencyScreen extends StatelessWidget {
  const EmergencyScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: const Text('Emergency Assistance'),
      // ),
      floatingActionButton: FloatingActionButton.extended(
        icon: const Icon(Icons.payments),
        label: const Text('Pay'),
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) {
                return PaymentGateway();
              },
            ),
          );
        },
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              emergencyNumbers,
              style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.primary),
            ),
            const SizedBox(height: 20),
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: Theme.of(context).colorScheme.primary),
                borderRadius: BorderRadius.circular(10),
              ),
              child: ListView(
                shrinkWrap: true,
                children: [
                  _buildEmergencyItem(context, Icons.local_hospital, ambulance, ambulanceNumber),
                  _buildEmergencyItem(context, Icons.local_fire_department, fireDepartment, fireDepartmentNumber),
                  _buildEmergencyItem(context, Icons.local_police, police, policeNumber),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Text(
              firstAidVideo,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Theme.of(context).colorScheme.primary),
            ),
            const SizedBox(height: 10),
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: Theme.of(context).colorScheme.primary),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: YoutubePlayer(
                  controller: YoutubePlayerController(
                    initialVideoId: 'XjMvBW9KDLA',
                    flags: YoutubePlayerFlags(
                      autoPlay: true,
                      mute: false,
                      forceHD: false,
                    ),
                  ),
                  showVideoProgressIndicator: true,
                  onReady: () {
                    // Listener for player ready
                  },
                ),
              ),
            ),
            const SizedBox(height: 10),
            ElevatedButton(onPressed: () {

            }, child: Text(
                contactFamily
            ))
          ],
        ),
      ),
    );
  }

  Widget _buildEmergencyItem(BuildContext context, IconData iconData, String title, String number) {
    final Uri _phoneUri = Uri(
        scheme: "tel",
        path: number
    );
    return ListTile(
      leading: Icon(
        iconData,
        color: Theme.of(context).colorScheme.primary,
      ),
      trailing: IconButton(
        onPressed: () {
          // Call emergency feature
          launchUrl(_phoneUri);
        },
        icon: Icon(Icons.call, color: Theme.of(context).colorScheme.primary),
      ),
      title: Text(
        '$title: $number',
        style: TextStyle(fontSize: 18, color: Theme.of(context).colorScheme.onBackground),
      ),
      onTap: () {
        // Call emergency feature
      },
    );
  }
}
