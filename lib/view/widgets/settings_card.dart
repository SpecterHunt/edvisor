import 'package:flutter/material.dart';

class SettingsCard extends StatelessWidget {
  const SettingsCard({Key? key, required this.icon, required this.title})
      : super(key: key);

  final String title;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Padding(
        padding: const EdgeInsets.only(top: 10.0, bottom: 10),
        child: Row(
          children: [
            Icon(
              icon,
            ),
            const SizedBox(
              width: 14,
            ),
            Expanded(
              child: Text(
                title,
                style: const TextStyle(
                    fontSize: 18, fontFamily: 'Poppins', color: Colors.black),
              ),
            ),
            const Icon(Icons.arrow_forward_ios)
          ],
        ),
      ),
    );
  }
}
