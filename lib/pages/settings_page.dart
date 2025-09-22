import 'package:aura_walls/widgets/bottom_nav_bar.dart';
import 'package:flutter/material.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    int selectedIndex = 3;
    return Scaffold(
      backgroundColor: Colors.black,
      bottomNavigationBar: BottomNavBar(selectedIndex: selectedIndex),
    );
  }
}
