import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/wallpaper.dart';

class FavoritesService {
  static const String _favoritesKey = 'favorite_wallpapers';

  static Future<void> addToFavorites(Wallpaper wallpaper) async {
    final prefs = await SharedPreferences.getInstance();
    final favorites = await getFavorites();
    if (!favorites.any((w) => w.id == wallpaper.id)) {
      favorites.add(wallpaper);
      final favoritesJson = favorites.map((w) => w.toJson()).toList();
      await prefs.setString(_favoritesKey, json.encode(favoritesJson));
    }
  }

  static Future<void> removeFromFavorites(String wallpaperId) async {
    final prefs = await SharedPreferences.getInstance();
    final favorites = await getFavorites();
    favorites.removeWhere((w) => w.id == wallpaperId);
    final favoritesJson = favorites.map((w) => w.toJson()).toList();
    await prefs.setString(_favoritesKey, json.encode(favoritesJson));
  }

  static Future<List<Wallpaper>> getFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    final favoritesString = prefs.getString(_favoritesKey);
    if (favoritesString != null) {
      final favoritesJson = json.decode(favoritesString) as List;
      return favoritesJson.map((json) => Wallpaper.fromJson(json)).toList();
    }
    return [];
  }

  static Future<bool> isFavorite(String wallpaperId) async {
    final favorites = await getFavorites();
    return favorites.any((w) => w.id == wallpaperId);
  }
}
