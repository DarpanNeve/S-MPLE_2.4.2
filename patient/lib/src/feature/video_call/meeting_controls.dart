import 'package:flutter/material.dart';

import '../../utils/strings_english.dart';

class MeetingControls extends StatelessWidget {
  final void Function() onToggleMicButtonPressed;
  final void Function() onToggleCameraButtonPressed;
  final void Function() onLeaveButtonPressed;

  const MeetingControls(
      {super.key,
        required this.onToggleMicButtonPressed,
        required this.onToggleCameraButtonPressed,
        required this.onLeaveButtonPressed});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        ElevatedButton(
            onPressed: onLeaveButtonPressed, child:  Text(leave)),
        ElevatedButton(
            onPressed: onToggleMicButtonPressed, child:  Text(toggleMic)),
        ElevatedButton(
            onPressed: onToggleCameraButtonPressed,
            child:  Text(toggleWebCam)),
      ],
    );
  }
}