import 'package:flutter/material.dart';
import '../../utils/strings_english.dart';
import 'api_call.dart';
import 'meeting_screen.dart';

class JoinScreen extends StatefulWidget {

  JoinScreen({super.key});

  @override
  State<JoinScreen> createState() => _JoinScreenState();
}

class _JoinScreenState extends State<JoinScreen> {
  final _meetingIdController = TextEditingController();

  void onCreateButtonPressed(BuildContext context) async {
    // call api to create meeting and then navigate to MeetingScreen with meetingId,token
    await createMeeting().then((meetingId) {
      if (!context.mounted) return;
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => MeetingScreen(
            meetingId: meetingId,
            token: token,
          ),
        ),
      );
    });
  }

  void onJoinButtonPressed(BuildContext context) {
    String meetingId = _meetingIdController.text;
    var re = RegExp("\\w{4}\\-\\w{4}\\-\\w{4}");
    // check meeting id is not null or invaild
    // if meeting id is vaild then navigate to MeetingScreen with meetingId,token
    if (meetingId.isNotEmpty && re.hasMatch(meetingId)) {
      _meetingIdController.clear();
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => MeetingScreen(
            meetingId: meetingId,
            token: token,
          ),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar( SnackBar(
        content: Text(enterValidMeetId),
      ));
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    onCreateButtonPressed(context);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () => onCreateButtonPressed(context),
              child: Text(createMeet),
            ),
            Container(
              margin: const EdgeInsets.fromLTRB(0, 8.0, 0, 8.0),
              child: TextField(
                decoration:  InputDecoration(
                  hintText: meetId,
                  border: OutlineInputBorder(),
                ),
                controller: _meetingIdController,
              ),
            ),
            ElevatedButton(
              onPressed: () => onJoinButtonPressed(context),
              child:  Text(joinMeet),
            ),
          ],
        ),
      ),
    );
  }
}