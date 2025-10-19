import 'package:aura_walls/Themes/app_theme.dart';
import 'package:aura_walls/models/wallpaper.dart';
import 'package:aura_walls/services/favorites_service.dart';
import 'package:aura_walls/services/wallpaper_service.dart';
import 'package:aura_walls/widgets/bottom_nav_bar.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late List<Wallpaper> wallpapers;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadWallpapers();
  }

  Future<void> _loadWallpapers() async {
    // For now, use sample data
    wallpapers = WallpaperService.getSampleWallpapers();
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    int selectedIndex = 0;
    return Scaffold(
      backgroundColor: AppTheme.color5,
      appBar: AppBar(
        backgroundColor: AppTheme.color5,
        elevation: 0,
        title: Text(
          'AuraWalls',
          style: TextStyle(
            color: AppTheme.color2,
            fontFamily: 'LeagueSpartan-Bold',
            fontSize: 24,
            fontWeight: FontWeight.w700,
          ),
        ),
        centerTitle: true,
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Column(
                children: [
                  // Featured Section
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      'Featured Wallpapers',
                      style: TextStyle(
                        color: AppTheme.color2,
                        fontFamily: 'LeagueSpartan-Bold',
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  // Grid View
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 12.0,
                        mainAxisSpacing: 12.0,
                        childAspectRatio: 0.75,
                      ),
                      itemCount: wallpapers.length,
                      itemBuilder: (context, index) {
                        return _buildWallpaperCard(context, wallpapers[index]);
                      },
                    ),
                  ),
                ],
              ),
            ),
      bottomNavigationBar: BottomNavBar(selectedIndex: selectedIndex),
    );
  }

  Widget _buildWallpaperCard(BuildContext context, Wallpaper wallpaper) {
    return GestureDetector(
      onTap: () {
        // Navigate to wallpaper detail/preview page (to be implemented)
        print('Tapped on wallpaper: ${wallpaper.id}');
      },
      child: Container(
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
              // Favorite button
              Positioned(
                top: 8,
                right: 8,
                child: FutureBuilder<bool>(
                  future: FavoritesService.isFavorite(wallpaper.id),
                  builder: (context, snapshot) {
                    final isFavorite = snapshot.data ?? false;
                    return GestureDetector(
                      onTap: () async {
                        if (isFavorite) {
                          await FavoritesService.removeFromFavorites(wallpaper.id);
                        } else {
                          await FavoritesService.addToFavorites(wallpaper);
                        }
                        setState(() {}); // Refresh to update favorite status
                      },
                      child: Container(
                        padding: const EdgeInsets.all(6),
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.5),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          isFavorite ? Icons.favorite : Icons.favorite_border,
                          color: isFavorite ? Colors.red : Colors.white,
                          size: 20,
                        ),
                      ),
                    );
                  },
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
      ),
    );
  }
}
