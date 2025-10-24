// ignore_for_file: unused_field

import 'package:aura_walls/Themes/app_theme.dart';
import 'package:aura_walls/pages/about_us_page.dart';
import 'package:aura_walls/pages/downloads_page.dart';
import 'package:aura_walls/pages/help_and_support_page.dart';
import 'package:aura_walls/pages/notifications_pane.dart';
import 'package:aura_walls/pages/rating_and_reviews_page.dart';
import 'package:aura_walls/widgets/Container1.dart';
import 'package:aura_walls/widgets/bottom_nav_bar.dart';
import 'package:aura_walls/widgets/button1.dart';
import 'package:aura_walls/widgets/edit_profile.dart';
import 'package:aura_walls/pages/favorites_page.dart';
import 'package:aura_walls/widgets/layout1.dart';
import 'package:aura_walls/widgets/layout2.dart';
import 'package:flutter/material.dart';

import 'package:shared_preferences/shared_preferences.dart';

class SettingsPage extends StatefulWidget {
  //final String userName;
  //final String? profilePicUrl;

  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  String name = '';
  String? imageUrl;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadProfile();
  }

  Future<void> _loadProfile() async {
    try {
      final prefs = await SharedPreferences.getInstance();

      // Read values first
      final loadedName = prefs.getString('userName') ?? 'No name set';
      final loadedImageUrl = prefs.getString('profilePicUrl');

      // Keep loader visible for at least 2 seconds
      await Future.delayed(const Duration(seconds: 2));

      // Update state with loaded values
      setState(() {
        name = loadedName;
        imageUrl = loadedImageUrl;
        _isLoading = false; // stop spinner
      });
    } catch (e) {
      //print("Error loading profile: $e");
      await Future.delayed(const Duration(seconds: 2));
      setState(() {
        name = 'No name set';
        imageUrl = null;
        _isLoading = false; // stop spinner even on error
      });
    }
  }

  Widget build(BuildContext context) {
    int selectedIndex = 3;

    //String userName = _displayNameController.text;
    //String? profilePicUrl = _profileImageUrl;

    return Scaffold(
      extendBody: true,
      bottomNavigationBar: BottomNavBar(selectedIndex: selectedIndex),
      backgroundColor: AppTheme.color2,
      appBar: AppBar(
        backgroundColor: AppTheme.color5,
        elevation: 0,
        /*leading: Padding(
          padding: const EdgeInsets.all(15),
          child: IconButton(
            icon: const Icon(Icons.arrow_back, color: AppTheme.color2),
            onPressed: () => Navigator.pop(context),
          ),
        ),*/

        /*title: const Text(
          'Settings',
          style: TextStyle(
            fontFamily: 'League Spartan',
            fontWeight: FontWeight.w800,
            fontSize: 25,
            color: AppTheme.color2,
          ),
        ),*/
        actions: [
          Padding(
            padding: const EdgeInsets.all(15),
            child: IconButton(
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => NotificationsPane()),
              ),
              icon: Icon(Icons.notifications_active, color: AppTheme.color2),
            ),
          ),
        ],
        centerTitle: true,
      ),

      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              Layout1(
                child: Center(
                  child: Column(
                    // mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        radius: 60,
                        backgroundImage: imageUrl != null
                            ? NetworkImage(imageUrl!)
                            : null,
                        child: imageUrl == null
                            ? const Icon(Icons.person, size: 60)
                            : null,
                      ),
                      //const SizedBox(height: 10),
                      Text(
                        name.isNotEmpty ? name : 'No name set',
                        style: const TextStyle(
                          fontFamily: 'League Spartan',
                          fontWeight: FontWeight.w600,
                          fontSize: 25,
                          color: AppTheme.color2,
                        ),
                      ),

                      Button1(
                        text: 'edit',
                        icon: Icons.edit,
                        fontSize: 17,

                        //this onTap refreshes page on returning. reuse for future moen. dont forget
                        onTap: () async {
                          final updated = await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const EditProfile(),
                            ),
                          );
                          if (updated == true) _loadProfile();
                        },
                      ),
                    ],
                  ),
                ),
              ),

              //const SizedBox(height: 10),

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
                        onTap: () => Navigator.pushReplacement(
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

                        /*onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => NotificationsPane(),
                          ),
                        ),*/
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Layout2(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      const SizedBox(height: 10),
                      Container1(
                        secondIcon: Icons.navigate_next_outlined,
                        iconText: 'Rating and reviews',
                        fontSize: 18,
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => RatingAndReviewsPage(),
                          ),
                        ),
                      ),

                      const SizedBox(height: 10),

                      Container1(
                        secondIcon: Icons.navigate_next_outlined,
                        iconText: 'About Us',
                        fontSize: 18,
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => AboutUsPage(),
                          ),
                        ),
                      ),

                      const SizedBox(height: 10),

                      Container1(
                        secondIcon: Icons.navigate_next_outlined,
                        iconText: 'Help And Support',
                        fontSize: 18,
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => HelpAndSupportPage(),
                          ),
                        ),
                      ),

                      const SizedBox(height: 80),
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



//calling all the prof detail's stuff from other pages
/*final prefs = await SharedPreferences.getInstance();
final userName = prefs.getString('userName');
final imageUrl = prefs.getString('profilePicUrl');
*/