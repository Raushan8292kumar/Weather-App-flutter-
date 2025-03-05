import 'package:flutter/material.dart';

class WeatherForcasting extends StatelessWidget {
  final IconData icon;
  final String lebal;
  final String value;
  const WeatherForcasting({
    super.key,
    required this.icon,
    required this.lebal,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(
          icon,
          size: 35,
        ),
        SizedBox(height: 10),
        Text(
          lebal,
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w300),
        ),
        SizedBox(height: 10),
        Text(
          value,
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
