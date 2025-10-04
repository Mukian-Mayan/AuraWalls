import 'package:aura_walls/Themes/app_theme.dart';
import 'package:aura_walls/pages/discover_page.dart';
import 'package:aura_walls/pages/home_page.dart';
import 'package:aura_walls/pages/settings_page.dart';
import 'package:aura_walls/widgets/favorites_page.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class BottomNavBar extends StatelessWidget {
  final int selectedIndex;
  const BottomNavBar({super.key, required this.selectedIndex});

  void _handleTabChange(BuildContext context, int index) {
    switch (index) {
      case 0:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => HomePage()),
        );
        break;
      case 1:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => FavoritesPage()),
        );
        break;
      case 2:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => DiscoverPage()),
        );
        break;
      case 3:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => SettingsPage()),
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15, left: 10, right: 10),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(40),
            topRight: Radius.circular(40),
            bottomLeft: Radius.circular(40),
            bottomRight: Radius.circular(40),
          ),
          color: AppTheme.color2,
          boxShadow: [
            BoxShadow(
              color: AppTheme.black,
              blurRadius: 5,
              offset: Offset(2, 2),
              spreadRadius: 2,
            ),
          ],
        ),

        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 10),
          child: GNav(
            selectedIndex: selectedIndex,
            backgroundColor: AppTheme.color2,
            textStyle: TextStyle(
              fontFamily: 'LeagueSpartan-Bold',
              color: AppTheme.color2,
            ),
            gap: 7,
            padding: EdgeInsets.all(8),
            activeColor: AppTheme.color2,
            color: AppTheme.color5,
            tabBackgroundColor: AppTheme.color5,
            onTabChange: (index) => _handleTabChange(context, index),

            tabs: [
              const GButton(icon: Icons.home, text: 'Home'),
              const GButton(icon: Icons.favorite, text: 'Favorites'),
              const GButton(icon: Icons.explore_outlined, text: 'Discover'),
              const GButton(icon: Icons.settings, text: 'Settings'),
            ],
          ),
        ),
      ),
    );
  }
}
