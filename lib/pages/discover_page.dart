import 'package:aura_walls/models/wallpaper.dart';
import 'package:aura_walls/services/favorites_service.dart';
import 'package:aura_walls/services/wallpaper_service.dart';
import 'package:aura_walls/widgets/bottom_nav_bar.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class DiscoverPage extends StatefulWidget {
  const DiscoverPage({super.key});

  @override
  State<DiscoverPage> createState() => _DiscoverPageState();
}

class _DiscoverPageState extends State<DiscoverPage> {
  late List<Wallpaper> wallpapers;
  List<Wallpaper> filteredWallpapers = [];
  bool isLoading = true;
  String selectedTab = 'Categories';
  String searchQuery = '';
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadWallpapers();
  }

  Future<void> _loadWallpapers() async {
    wallpapers = WallpaperService.getSampleWallpapers();
    filteredWallpapers = wallpapers;
    setState(() {
      isLoading = false;
    });
  }

  void _filterWallpapers() {
    setState(() {
      if (selectedTab == 'Categories') {
        filteredWallpapers = wallpapers;
      } else if (selectedTab == 'Ratings') {
        filteredWallpapers = wallpapers.where((w) => w.rating >= 4.0).toList();
      } else if (selectedTab == 'Previews') {
        filteredWallpapers = wallpapers.where((w) => w.downloads > 150).toList();
      }

      if (searchQuery.isNotEmpty) {
        filteredWallpapers = filteredWallpapers
            .where((w) => w.category.toLowerCase().contains(searchQuery.toLowerCase()))
            .toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    int selectedIndex = 2;
    return Scaffold(
      backgroundColor: const Color(0xFF1a1a2e),
      bottomNavigationBar: BottomNavBar(selectedIndex: selectedIndex),
      body: Column(
        children: [
          // Header Section
          Container(
            decoration: const BoxDecoration(
              color: Color(0xFF7B2CBF),
            ),
            child: SafeArea(
              bottom: false,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    // Search Bar
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 4,
                      ),
                      child: TextField(
                        controller: _searchController,
                        onChanged: (value) {
                          searchQuery = value;
                          _filterWallpapers();
                        },
                        decoration: const InputDecoration(
                          hintText: 'Search wallpapers...',
                          hintStyle: TextStyle(
                            color: Colors.grey,
                            fontSize: 14,
                          ),
                          border: InputBorder.none,
                          suffixIcon: Icon(
                            Icons.search,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Tab Navigation
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        _buildTab(
                          icon: Icons.star,
                          label: 'Ratings',
                          isActive: selectedTab == 'Ratings',
                          onTap: () {
                            setState(() {
                              selectedTab = 'Ratings';
                              _filterWallpapers();
                            });
                          },
                        ),
                        _buildTab(
                          icon: Icons.dashboard,
                          label: 'Categories',
                          isActive: selectedTab == 'Categories',
                          onTap: () {
                            setState(() {
                              selectedTab = 'Categories';
                              _filterWallpapers();
                            });
                          },
                        ),
                        _buildTab(
                          icon: Icons.play_circle_filled,
                          label: 'Previews',
                          isActive: selectedTab == 'Previews',
                          onTap: () {
                            setState(() {
                              selectedTab = 'Previews';
                              _filterWallpapers();
                            });
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),

          // Scrollable Masonry Grid
          Expanded(
            child: isLoading
                ? const Center(child: CircularProgressIndicator())
                : SingleChildScrollView(
                    padding: const EdgeInsets.all(12),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Left Column
                        Expanded(
                          child: Column(
                            children: _buildMasonryColumn(0),
                          ),
                        ),
                        const SizedBox(width: 12),

                        // Right Column
                        Expanded(
                          child: Column(
                            children: _buildMasonryColumn(1),
                          ),
                        ),
                      ],
                    ),
                  ),
          ),
        ],
      ),
    );
  }

  List<Widget> _buildMasonryColumn(int columnIndex) {
    List<Widget> widgets = [];
    for (int i = columnIndex; i < filteredWallpapers.length; i += 2) {
      widgets.add(_buildWallpaperCard(filteredWallpapers[i]));
      if (i + 2 < filteredWallpapers.length) {
        widgets.add(const SizedBox(height: 12));
      }
    }
    return widgets;
  }

  Widget _buildWallpaperCard(Wallpaper wallpaper) {
    double height = [200, 140, 170][wallpaper.id.hashCode % 3].toDouble();
    return GestureDetector(
      onTap: () {
        // Navigate to wallpaper detail/preview page (to be implemented)
        print('Tapped on wallpaper: ${wallpaper.id}');
      },
      child: Container(
        height: height,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.3),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16),
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
              // Gradient overlay
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
                          size: 16,
                        ),
                      ),
                    );
                  },
                ),
              ),
              // Category and rating info
              Positioned(
                top: 8,
                left: 8,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.5),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    wallpaper.category,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
              // Apply button
              Positioned(
                bottom: 8,
                left: 8,
                right: 8,
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
                    padding: const EdgeInsets.symmetric(vertical: 6.0),
                  ),
                  child: const Text(
                    'Apply',
                    style: TextStyle(
                      fontSize: 12,
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

  Widget _buildTab({
    required IconData icon,
    required String label,
    required bool isActive,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            color: isActive ? Colors.white : Colors.white70,
            size: 28,
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              color: isActive ? Colors.white : Colors.white70,
              fontSize: 12,
              fontWeight: isActive ? FontWeight.w600 : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }
}

