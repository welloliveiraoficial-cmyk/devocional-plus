import 'package:http/http.dart' as http;
import 'package:package_info_plus/package_info_plus.dart';

class UpdateInfo {
  final bool hasUpdate;
  final String latestVersion;
  final String downloadUrl;
  UpdateInfo({required this.hasUpdate, required this.latestVersion, required this.downloadUrl});
}

class UpdateChecker {
  static const String _repoOwner = 'welloliveiraoficial-cmyk';
  static const String _repoName = 'devocional-plus';

  static String? lastError;

  static Future<UpdateInfo?> check() async {
    lastError = null;

    for (int attempt = 1; attempt <= 3; attempt++) {
      try {
        final packageInfo = await PackageInfo.fromPlatform();
        final currentVersion = packageInfo.version;

        final response = await http
            .get(Uri.parse('https://raw.githubusercontent.com/$_repoOwner/$_repoName/main/version.txt'))
            .timeout(const Duration(seconds: 10));

        if (response.statusCode != 200) {
          lastError = 'HTTP ${response.statusCode}';
          if (attempt < 3) {
            await Future.delayed(const Duration(seconds: 3));
            continue;
          }
          return null;
        }

        final latestVersion = response.body.trim();
        const downloadUrl =
            'https://github.com/$_repoOwner/$_repoName/releases/latest/download/app-release.apk';

        final hasUpdate = latestVersion.isNotEmpty && latestVersion != currentVersion;

        return UpdateInfo(hasUpdate: hasUpdate, latestVersion: latestVersion, downloadUrl: downloadUrl);
      } catch (e) {
        lastError = e.toString();
        if (attempt < 3) await Future.delayed(const Duration(seconds: 3));
      }
    }
    return null;
  }
}
