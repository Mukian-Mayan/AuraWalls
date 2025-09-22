import 'package:aura_walls/Themes/app_theme.dart';
import 'package:aura_walls/widgets/bottom_nav_bar.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    int selectedIndex = 0;
    return Scaffold(
      backgroundColor: AppTheme.color5,
      body: SingleChildScrollView(child: Column(children: [Text('Home Page')])),
      bottomNavigationBar: BottomNavBar(selectedIndex: selectedIndex),
    );
  }
}
