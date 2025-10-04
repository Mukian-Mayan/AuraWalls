import 'package:aura_walls/Themes/app_theme.dart';
import 'package:aura_walls/pages/downloads_page.dart';
import 'package:aura_walls/pages/notifications_pane.dart';
import 'package:aura_walls/pages/rating_and_reviews_page.dart';
import 'package:aura_walls/widgets/Container1.dart';
import 'package:aura_walls/widgets/bottom_nav_bar.dart';
import 'package:aura_walls/widgets/button1.dart';
import 'package:aura_walls/widgets/edit_profile.dart';
import 'package:aura_walls/widgets/favorites_page.dart';
import 'package:aura_walls/widgets/layout1.dart';
import 'package:flutter/material.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    int selectedIndex = 3;
    return Scaffold(
      bottomNavigationBar: BottomNavBar(selectedIndex: selectedIndex),
      backgroundColor: AppTheme.color2,
      appBar: AppBar(
        backgroundColor: AppTheme.color5,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Settings',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),

      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              Layout1(),

              const SizedBox(height: 10),
              Button1(
                text: 'edit',
                icon: Icons.edit,
                fontSize: 17,
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => EditProfile()),
                ),
              ),

              const SizedBox(height: 10),
              Container(
                height: MediaQuery.of(context).size.height * 0.35,
                width: MediaQuery.of(context).size.width * 0.92,

                decoration: BoxDecoration(
                  color: AppTheme.color5,
                  borderRadius: BorderRadius.circular(16),
                ),
                //color: AppTheme.color5,
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container1(
                        secondIcon: Icons.navigate_next_outlined,
                        textIcon: Icons.light_mode,
                        iconText: 'Mode',
                        fontSize: 20,
                        onTap: () => {},
                      ),
                      Container1(
                        secondIcon: Icons.navigate_next_outlined,
                        textIcon: Icons.favorite_border,
                        iconText: 'Favorites',
                        fontSize: 20,
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => FavoritesPage(),
                          ),
                        ),
                      ),
                      Container1(
                        secondIcon: Icons.navigate_next_outlined,
                        textIcon: Icons.file_download,
                        iconText: 'Downloads',
                        fontSize: 20,
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => DownloadsPage(),
                          ),
                        ),
                      ),
                      Container1(
                        secondIcon: Icons.navigate_next_outlined,
                        textIcon: Icons.star,
                        iconText: 'Rating and reviews',
                        fontSize: 20,
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => RatingAndReviewsPage(),
                          ),
                        ),
                      ),
                      Container1(
                        secondIcon: Icons.navigate_next_outlined,
                        textIcon: Icons.notifications_active,
                        iconText: 'Notifications',
                        fontSize: 20,
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => NotificationsPane(),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
