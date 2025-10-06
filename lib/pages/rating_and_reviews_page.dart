import 'package:aura_walls/Themes/app_theme.dart';
import 'package:flutter/material.dart';

class RatingAndReviewsPage extends StatelessWidget {
  const RatingAndReviewsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return   Scaffold(
      backgroundColor: AppTheme.color5,
      body: SingleChildScrollView(child: Column(children: [Text('Previews')])),
      
    );
  }
}