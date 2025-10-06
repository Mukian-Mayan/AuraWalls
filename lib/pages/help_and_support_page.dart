import 'package:aura_walls/Themes/app_theme.dart';
import 'package:aura_walls/widgets/custom_app_bar.dart';
import 'package:aura_walls/widgets/layout1.dart';
import 'package:flutter/material.dart';

class HelpAndSupportPage extends StatelessWidget {
  const HelpAndSupportPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.color2,

      appBar: CustomAppBar(
        color: AppTheme.color5,
        //title: "Help And Support",
        leadingIcon: Icons.arrow_back_ios,
        onLeadingPressed: () {
          Navigator.pop(context);
        },
      ),

      body: SingleChildScrollView(
        child: Column(
          children: [
            Layout1(
              child: Center(
                child: Text(
                  'Help and Support',
                  style: TextStyle(
                    color: AppTheme.color2,
                    fontFamily: 'LeagueSpartan-Bold',
                    fontSize: 30,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}