import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ChatBubble extends StatelessWidget {
  final String message;
  final Color color;
  final Timestamp time;
  const ChatBubble(
      {super.key,
      required this.message,
      required this.color,
      required this.time});

  @override
  Widget build(BuildContext context) {
    // Convert Firestore Timestamp to DateTime
    DateTime dateTime = time.toDate();

    // Creating a DateFormat object for the desired format (HH:mm)
    DateFormat format = DateFormat.Hm();

    // Formatting the DateTime object to display only hour and minute
    String formattedTime = format.format(dateTime);
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: color,
      ),
      child: Column(
        children: [
          Text(
            message,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            formattedTime,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}
