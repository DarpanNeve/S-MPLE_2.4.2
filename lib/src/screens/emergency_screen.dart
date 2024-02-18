import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class EmergencyScreen extends StatelessWidget {
  const EmergencyScreen({Key? key}) : super(key: key);

  // Method to handle notifying family members
  void _notifyFamily(BuildContext context) {
    // Add your logic here to send the emergency message to family members
    // For example, you can use a service or API to send SMS or push notifications
    // You can also implement a dialog or confirmation message to inform the user that the message has been sent
    // Replace this placeholder code with your actual implementation
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Emergency message sent to family members.'),
        duration: Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: const Text('Emergency Assistance'),
      // ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Emergency Numbers',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Theme.of(context).colorScheme.primary),
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
                  _buildEmergencyItem(context, Icons.local_hospital, 'Ambulance', '108'),
                  _buildEmergencyItem(context, Icons.local_fire_department, 'Fire Department', '112'),
                  _buildEmergencyItem(context, Icons.local_police, 'Police', '112'),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Text(
              'First Aid Video',
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
                child: Expanded(
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
            ),
            const SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  _notifyFamily(context); // Call method to notify family members
                },
                child: Text("Notify Family"),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmergencyItem(BuildContext context, IconData iconData, String title, String number) {
    return ListTile(
      leading: Icon(
        iconData,
        color: Theme.of(context).colorScheme.primary,
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
