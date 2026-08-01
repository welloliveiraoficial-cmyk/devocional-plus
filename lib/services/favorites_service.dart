import 'package:shared_preferences/shared_preferences.dart';

class FavoritesService {
  static const String _favoritesKey = 'favorite_devotionals';

  static Future<List<String>> getFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getStringList(_favoritesKey) ?? [];
  }

  static Future<bool> isFavorite(String devotionalId) async {
    final favorites = await getFavorites();
    return favorites.contains(devotionalId);
  }

  static Future<void> addFavorite(String devotionalId) async {
    final prefs = await SharedPreferences.getInstance();
    final favorites = await getFavorites();

    if (!favorites.contains(devotionalId)) {
      favorites.add(devotionalId);
      await prefs.setStringList(_favoritesKey, favorites);
    }
  }

  static Future<void> removeFavorite(String devotionalId) async {
    final prefs = await SharedPreferences.getInstance();
    final favorites = await getFavorites();

    favorites.remove(devotionalId);
    await prefs.setStringList(_favoritesKey, favorites);
  }

  static Future<void> toggleFavorite(String devotionalId) async {
    if (await isFavorite(devotionalId)) {
      await removeFavorite(devotionalId);
    } else {
      await addFavorite(devotionalId);
    }
  }
}
