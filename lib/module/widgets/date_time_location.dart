import 'package:flutter/material.dart';

class DateTimeLocationInfo extends StatelessWidget {
  const DateTimeLocationInfo({
    super.key,
    required this.date,
    required this.time,
    required this.location,
  });

  final String date;
  final String time;
  final String location;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            const Icon(
              Icons.calendar_month,
              color: Colors.white,
            ),
            const SizedBox(width: 10),
            Text(
              date,
              style: const TextStyle(color: Colors.tealAccent, fontWeight: FontWeight.w500),
            ),
            const SizedBox(width: 20),
            const Icon(
              Icons.calendar_month,
              color: Colors.white,
            ),
            const SizedBox(width: 10),
            Text(
              time,
              style: const TextStyle(color: Colors.tealAccent, fontWeight: FontWeight.w500),
            ),
          ],
        ),
        const SizedBox(height: 10),
        Row(
          children: [
            const Icon(
              Icons.location_pin,
              color: Colors.white,
            ),
            const SizedBox(width: 10),
            Text(
              location,
              style: const TextStyle(color: Colors.tealAccent, fontWeight: FontWeight.w500),
            ),
          ],
        )
      ],
    );
  }
}
