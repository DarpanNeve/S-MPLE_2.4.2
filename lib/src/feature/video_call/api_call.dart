import 'dart:convert';

import 'package:http/http.dart' as http;

//Auth token we will use to generate a meeting and connect to it
String token =
    "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJhcGlrZXkiOiI1M2NmNmZiNS1kNGE0LTRmZTYtOGU3Ni1mOWI3YzU2NTIxZTAiLCJwZXJtaXNzaW9ucyI6WyJhbGxvd19qb2luIl0sImlhdCI6MTcwODI3NjUxMSwiZXhwIjoxNzA4ODgxMzExfQ.R-SxwkMHjVVt3U0U5uFkdtVkaaeaa_EDrLsbyTlG_CQ";

// API call to create meeting
Future<String> createMeeting() async {
  final http.Response httpResponse = await http.post(
    Uri.parse("https://api.videosdk.live/v2/rooms"),
    headers: {'Authorization': token},
  );

//Destructuring the roomId from the response
  return json.decode(httpResponse.body)['roomId'];
}
