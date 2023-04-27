import 'package:url_launcher/url_launcher.dart';

void openTermsOfService() =>
    _openInBrowser('https://quabynah-bilson.github.io/realvy/terms/');

/// helper function to open url in supported browsers
Future<void> _openInBrowser(String url) async {
  final uri = Uri.parse(url);
  if (await canLaunchUrl(uri)) {
    await launchUrl(uri);
  } else {
    throw 'Could not launch $url';
  }
}
