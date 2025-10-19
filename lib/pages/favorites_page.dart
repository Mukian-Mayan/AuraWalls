// ignore_for_file: deprecated_member_use

import 'package:aura_walls/models/wallpaper.dart';
import 'package:aura_walls/pages/home_page.dart';
import 'package:aura_walls/services/favorites_service.dart';
import 'package:aura_walls/widgets/bottom_nav_bar.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class FavoritesPage extends StatefulWidget {
  const FavoritesPage({super.key});

  @override
  State<FavoritesPage> createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  List<Wallpaper> favorites = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadFavorites();
  }

  Future<void> _loadFavorites() async {
    final loadedFavorites = await FavoritesService.getFavorites();
    setState(() {
      favorites = loadedFavorites;
      isLoading = false;
    });
  }

  Future<void> _removeFromFavorites(String wallpaperId) async {
    await FavoritesService.removeFromFavorites(wallpaperId);
    await _loadFavorites(); // Refresh the list
  }

  @override
  Widget build(BuildContext context) {
    int selectedIndex = 1;
    return Scaffold(
      bottomNavigationBar: BottomNavBar(selectedIndex: selectedIndex),
      backgroundColor: const Color(0xFF1a1a2e),
      appBar: AppBar(
        backgroundColor: const Color(0xFF1a1a2e),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            if (Navigator.canPop(context)) {
              Navigator.pop(context);
            } else {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => const HomePage()),
                (Route<dynamic> route) => false,
              );
            }
          },
        ),
        title: const Text(
          'Favorites',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: false,
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : favorites.isEmpty
              ? const Center(
                  child: Text(
                    'No favorites yet',
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                )
              : Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                  child: ScrollConfiguration(
                    behavior: const ScrollBehavior().copyWith(overscroll: false),
                    child: GridView.builder(
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 12.0,
                        mainAxisSpacing: 12.0,
                        childAspectRatio: 0.75,
                      ),
                      itemCount: favorites.length,
                      itemBuilder: (context, index) {
                        return _buildWallpaperCard(context, favorites[index]);
                      },
                    ),
                  ),
                ),
    );
  }

  Widget _buildWallpaperCard(BuildContext context, Wallpaper wallpaper) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16.0),
        child: Stack(
          children: [
            // Wallpaper Image
            wallpaper.url.startsWith('assets/')
                ? Image.asset(
                    wallpaper.url,
                    fit: BoxFit.cover,
                    width: double.infinity,
                    height: double.infinity,
                  )
                : CachedNetworkImage(
                    imageUrl: wallpaper.url,
                    fit: BoxFit.cover,
                    width: double.infinity,
                    height: double.infinity,
                    placeholder: (context, url) => Container(
                      color: Colors.grey[300],
                      child: const Center(child: CircularProgressIndicator()),
                    ),
                    errorWidget: (context, url, error) => Container(
                      color: Colors.grey[300],
                      child: const Icon(Icons.error),
                    ),
                  ),
            // Gradient overlay for better button visibility
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16.0),
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.transparent,
                    Colors.black.withOpacity(0.6),
                  ],
                ),
              ),
            ),
            // Favorite indicator
            Positioned(
              top: 8,
              right: 8,
              child: GestureDetector(
                onTap: () => _removeFromFavorites(wallpaper.id),
                child: Container(
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.5),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.favorite,
                    color: Colors.red,
                    size: 20,
                  ),
                ),
              ),
            ),
            // Apply button
            Positioned(
              bottom: 12,
              left: 12,
              right: 12,
              child: ElevatedButton(
                onPressed: () {
                  // Handle apply button tap
                  print('Apply button tapped for wallpaper ${wallpaper.id}');
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF6c63ff),
                  foregroundColor: Colors.white,
                  elevation: 4,
                  shadowColor: Colors.black.withOpacity(0.3),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                ),
                child: const Text(
                  'Apply',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
