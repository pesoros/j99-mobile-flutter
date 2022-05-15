import 'package:url_launcher/url_launcher_string.dart';

class UrlLauncher {
  static url(String url) async {
    if (canLaunchUrlString(url) != null) {
      launchUrlString(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
