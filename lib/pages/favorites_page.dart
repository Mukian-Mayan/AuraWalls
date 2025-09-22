import 'package:aura_walls/widgets/bottom_nav_bar.dart';
import 'package:flutter/material.dart';

class FavoritesPage extends StatelessWidget {
  const FavoritesPage({super.key});

  @override
  Widget build(BuildContext context) {
    int selectedIndex = 1;
    return Scaffold(bottomNavigationBar: BottomNavBar(selectedIndex: selectedIndex),);
  }
}
