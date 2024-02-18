import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class EmergencyScreen extends StatelessWidget {
  const EmergencyScreen({Key? key}) : super(key: key);

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
            const SizedBox(height: 10),
            ElevatedButton(onPressed: () {

            }, child: Text(
              "Contact Family"
            ))
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
