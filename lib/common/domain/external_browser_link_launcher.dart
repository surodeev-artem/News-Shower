import 'package:news_shower/common/domain/link_launcher.dart';
import 'package:url_launcher/url_launcher.dart';

final class ExternalBrowserLinkLauncher extends LinkLauncher {
  @override
  Future<bool> launch(Uri uri) async =>
      await launchUrl(uri, mode: LaunchMode.externalApplication);
}
