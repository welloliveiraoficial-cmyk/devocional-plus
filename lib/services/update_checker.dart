import 'dart:convert';
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

  static Future<UpdateInfo?> check() async {
    try {
      final packageInfo = await PackageInfo.fromPlatform();
      final currentVersion = packageInfo.version;

      final response = await http.get(
        Uri.parse('https://api.github.com/repos/$_repoOwner/$_repoName/releases/latest'),
      );

      if (response.statusCode != 200) return null;

      final data = jsonDecode(response.body);
      String latestVersion = (data['tag_name'] ?? '').toString();
      latestVersion = latestVersion.replaceAll('v', '').trim();

      const downloadUrl =
          'https://github.com/$_repoOwner/$_repoName/releases/latest/download/app-release.apk';

      final hasUpdate = latestVersion.isNotEmpty && latestVersion != currentVersion;

      return UpdateInfo(
        hasUpdate: hasUpdate,
        latestVersion: latestVersion,
        downloadUrl: downloadUrl,
      );
    } catch (_) {
      return null;
    }
  }
}
