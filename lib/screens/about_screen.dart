import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '/l10n/app_localizations.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

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
        title: Text(AppLocalizations.of(context)!.aboutScreenTitle),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              AppLocalizations.of(context)!.aboutDescriptionTitle,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              AppLocalizations.of(context)!.aboutDescriptionText,
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 20),
            Text(
              AppLocalizations.of(context)!.aboutPrivacyTitle,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              AppLocalizations.of(context)!.aboutDescriptionText,
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 20),
            Text(
              AppLocalizations.of(context)!.aboutLinksTitle,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            InkWell(
              child: Text(
                AppLocalizations.of(context)!.aboutLinksViewSourceCode,
                style: TextStyle(fontSize: 16, color: Colors.blue),
              ),
              onTap: () => _launchURL('https://codeberg.org/retiolus/ExHale'),
            ),
            SizedBox(height: 10),
            InkWell(
              child: Text(
                AppLocalizations.of(context)!.aboutLinksReportAnIssue,
                style: TextStyle(fontSize: 16, color: Colors.blue),
              ),
              onTap: () => _launchURL('https://codeberg.org/retiolus/ExHale/issues'),
            ),
            SizedBox(height: 20),
            Text(
              AppLocalizations.of(context)!.aboutCreditsTitle,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              AppLocalizations.of(context)!.aboutCreditsText,
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 10),
            InkWell(
              child: Text(
                AppLocalizations.of(context)!.aboutCreditsOpenMoji,
                style: TextStyle(fontSize: 16, color: Colors.blue),
              ),
              onTap: () => _launchURL('https://openmoji.org/'),
            ),
            SizedBox(height: 10),
            InkWell(
              child: Text(
                AppLocalizations.of(context)!.aboutCreditsMyWebsite,
                style: TextStyle(fontSize: 16, color: Colors.blue),
              ),
              onTap: () => _launchURL('https://retiolus.net/'),
            ),
            SizedBox(height: 10),
            InkWell(
              child: Text(
                AppLocalizations.of(context)!.aboutCreditsLiberapay,
                style: TextStyle(fontSize: 16, color: Colors.blue),
              ),
              onTap: () => _launchURL('https://liberapay.com/retiolus/'),
            )
          ],
        ),
      ),
    );
  }
}
