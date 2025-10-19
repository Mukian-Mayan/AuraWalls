import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/wallpaper.dart';

class WallpaperService {
  static const String _baseUrl = 'https://api.unsplash.com';
  static const String _accessKey = 'YOUR_UNSPLASH_ACCESS_KEY'; // Replace with actual key

  // For now, use sample data from assets
  static List<Wallpaper> getSampleWallpapers() {
    return [
      Wallpaper(
        id: '1',
        url: 'assets/images/Categories, discover, explore.jpg',
        thumbnailUrl: 'assets/images/Categories, discover, explore.jpg',
        category: 'Nature',
        downloads: 150,
        rating: 4.5,
      ),
      Wallpaper(
        id: '2',
        url: 'assets/images/charts and ratings.jpg',
        thumbnailUrl: 'assets/images/charts and ratings.jpg',
        category: 'Abstract',
        downloads: 200,
        rating: 4.2,
      ),
      Wallpaper(
        id: '3',
        url: 'assets/images/color schema.jpg',
        thumbnailUrl: 'assets/images/color schema.jpg',
        category: 'Colors',
        downloads: 180,
        rating: 4.7,
      ),
      Wallpaper(
        id: '4',
        url: 'assets/images/dashboard.png',
        thumbnailUrl: 'assets/images/dashboard.png',
        category: 'Tech',
        downloads: 120,
        rating: 4.0,
      ),
      Wallpaper(
        id: '5',
        url: 'assets/images/Diamond_Sapphire_Blue_Gemstone_PNG-removebg-preview.png',
        thumbnailUrl: 'assets/images/Diamond_Sapphire_Blue_Gemstone_PNG-removebg-preview.png',
        category: 'Gems',
        downloads: 300,
        rating: 4.8,
      ),
      Wallpaper(
        id: '6',
        url: 'assets/images/Download_Diamond_gemstone_jewelry_emerald_Shining_Green_Gemstone_On_Transparent_Background_for_free-removebg-preview.png',
        thumbnailUrl: 'assets/images/Download_Diamond_gemstone_jewelry_emerald_Shining_Green_Gemstone_On_Transparent_Background_for_free-removebg-preview.png',
        category: 'Gems',
        downloads: 250,
        rating: 4.6,
      ),
      Wallpaper(
        id: '7',
        url: 'assets/images/Favourites and collections.jpg',
        thumbnailUrl: 'assets/images/Favourites and collections.jpg',
        category: 'UI',
        downloads: 90,
        rating: 3.8,
      ),
      Wallpaper(
        id: '8',
        url: 'assets/images/history and downloads.jpg',
        thumbnailUrl: 'assets/images/history and downloads.jpg',
        category: 'UI',
        downloads: 110,
        rating: 4.1,
      ),
    ];
  }

  // Future method to fetch from API (when API key is available)
  static Future<List<Wallpaper>> fetchWallpapers({String query = 'wallpaper', int page = 1}) async {
    try {
      final response = await http.get(
        Uri.parse('$_baseUrl/search/photos?query=$query&page=$page&per_page=20&client_id=$_accessKey'),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final results = data['results'] as List;
        return results.map((json) => Wallpaper.fromJson({
          'id': json['id'],
          'url': json['urls']['full'],
          'thumbnailUrl': json['urls']['thumb'],
          'category': query,
          'downloads': json['downloads'] ?? 0,
          'rating': 4.0, // Unsplash doesn't provide ratings
        })).toList();
      } else {
        throw Exception('Failed to load wallpapers');
      }
    } catch (e) {
      // Fallback to sample data
      return getSampleWallpapers();
    }
  }

  static List<Wallpaper> getWallpapersByCategory(String category) {
    return getSampleWallpapers().where((wallpaper) => wallpaper.category == category).toList();
  }

  static List<String> getCategories() {
    return ['Nature', 'Abstract', 'Colors', 'Tech', 'Gems', 'UI'];
  }
}
