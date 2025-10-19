import 'package:aura_walls/widgets/bottom_nav_bar.dart';
//import 'package:aura_walls/widgets/bottom_nav_bar2.dart';
import 'package:flutter/material.dart';

class DiscoverPage extends StatelessWidget {
  const DiscoverPage({super.key});

  @override
  Widget build(BuildContext context) {
    int selectedIndex = 2;
    return Scaffold(
      backgroundColor: Colors.green,
    bottomNavigationBar: BottomNavBar(selectedIndex: selectedIndex),
      //bottomNavigationBar: BottomNavBar2(),
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
                        vertical: 12,
                      ),
                      child: Row(
                        children: const [
                          Expanded(
                            child: Text(
                              'search',
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 14,
                              ),
                            ),
                          ),
                          Icon(
                            Icons.search,
                            color: Colors.grey,
                          ),
                        ],
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
                          isActive: true,
                        ),
                        _buildTab(
                          icon: Icons.dashboard,
                          label: 'Categories',
                          isActive: false,
                        ),
                        _buildTab(
                          icon: Icons.play_circle_filled,
                          label: 'Previews',
                          isActive: false,
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
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(12),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Left Column
                  Expanded(
                    child: Column(
                      children: [
                        _buildCard(height: 200),
                        const SizedBox(height: 12),
                        _buildCard(height: 140),
                        const SizedBox(height: 12),
                        _buildCard(height: 170),
                      ],
                    ),
                  ),
                  const SizedBox(width: 12),
                  
                  // Right Column
                  Expanded(
                    child: Column(
                      children: [
                        _buildCard(height: 170),
                        const SizedBox(height: 12),
                        _buildCard(height: 200),
                        const SizedBox(height: 12),
                        _buildCard(height: 140),
                      ],
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

  Widget _buildTab({
    required IconData icon,
    required String label,
    required bool isActive,
  }) {
    return Column(
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
    );
  }

  Widget _buildCard({required double height}) {
    return Container(
      height: height,
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadius.circular(16),
      ),
    );
  }
}

