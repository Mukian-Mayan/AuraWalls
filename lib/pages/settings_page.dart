import 'package:aura_walls/widgets/bottom_nav_bar.dart';
import 'package:flutter/material.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

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
          onPressed: () => Navigator.pop(context),
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
      body: Padding(
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
            itemCount: 8, // You can change this to your actual item count
            itemBuilder: (context, index) {
              return _buildGridItem(context, index);
            },
          ),
        ),
      ),
    );
  }

  Widget _buildGridItem(BuildContext context, int index) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.0),
        color: Colors.grey[800], // Placeholder color for your images
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Stack(
        children: [
          // This is where your image will go
          Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16.0),
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.grey[700]!,
                  Colors.grey[900]!,
                ],
              ),
            ),
            child: const Center(
              child: Icon(
                Icons.image,
                color: Colors.white54,
                size: 40,
              ),
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
          // Apply button
          Positioned(
            bottom: 12,
            left: 12,
            right: 12,
            child: ElevatedButton(
              onPressed: () {
                // Handle apply button tap
                print('Apply button tapped for item $index');
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
    );
  }
}