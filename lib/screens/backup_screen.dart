import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '/l10n/app_localizations.dart';
import 'home_screen.dart';

class BackupScreen extends StatelessWidget {
  final VoidCallback onBackupPressed; // o Function() se preferisci
  const BackupScreen({super.key, required this.onBackupPressed});

  // Function to open URLs
  void _launchURL(String url) async {
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Backup app'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20),
            Text(
              'Backup App',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              'Share the Json backup file with any app.'
                  'You can restore this backup later, when it will be implemented',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: onBackupPressed,
              child: Text('Backup app data in json format'),
            ),
          ],
        ),
      ),
    );
  }
}
