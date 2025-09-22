import 'package:aura_walls/widgets/bottom_nav_bar.dart';
import 'package:flutter/material.dart';

class DiscoverPage extends StatelessWidget {
  const DiscoverPage({super.key});

  @override
  Widget build(BuildContext context) {
    int selectedIndex = 2;
    return Scaffold(
      backgroundColor: Colors.green,
      bottomNavigationBar: BottomNavBar(selectedIndex: selectedIndex),
    );
    ;
  }
}
