import 'package:flutter/material.dart';
void showSnackBar(String message,BuildContext context,IconData iconData, Color iconColor) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Row(
        children: [
          const SizedBox(width: 8),
          Icon(
            iconData,
            color: iconColor,
          ),
          const SizedBox(width: 8),
          Text(
            message,
            //        style: const TextStyle(color: Colors.white),
          ),
        ],
      ),
      //   backgroundColor: Colors.blue,
      duration: const Duration(seconds: 2),
      behavior: SnackBarBehavior.floating,
    ),
  );
}