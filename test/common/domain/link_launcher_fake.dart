import 'package:news_shower/common/domain/link_launcher.dart';

final class LinkLauncherFake extends LinkLauncher {
  final Future<bool> Function() launchResult;
  final openedUris = <Uri>[];

  LinkLauncherFake(this.launchResult);

  @override
  Future<bool> launch(Uri uri) async {
    final result = await launchResult();
    if (result) {
      openedUris.add(uri);
    }
    return result;
  }
}
