import 'package:flutter/material.dart';

class HourUpdateWeather extends StatelessWidget {
  final String time;
  final IconData icon;
  
  final String temp;
  const HourUpdateWeather({
    super.key,
    required this.time,
    required this.icon,
    required this.temp,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 10.0,
      child: Container(
        width: 140,
        padding: const EdgeInsets.all(15.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          children: [
            Text(
              time,
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(height: 10),
            Icon(
              icon,
              size: 30,
            ),
            SizedBox(height: 10),
            Text(
              temp,
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
