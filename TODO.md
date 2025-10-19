# TODO: Make Arrow Back Functional in Favorites Page

- [x] Import HomePage in favorites_page.dart
- [x] Update the onPressed callback in the IconButton to check if can pop; if yes, pop; otherwise, navigate to HomePage and clear the stack

# New Tasks for Wallpaper App Functionality

- [x] Add necessary dependencies (http, wallpaper_manager, cached_network_image) to pubspec.yaml
- [x] Create wallpaper data model (lib/models/wallpaper.dart)
- [x] Implement data fetching (from assets initially, expandable to API)
- [x] Update HomePage to display wallpapers in a grid
- [x] Update DiscoverPage to display wallpapers with search and categories
- [x] Implement persistence for favorites using SharedPreferences
- [x] Update FavoritesPage to load and display saved favorites
- [ ] Implement persistence for downloads
- [ ] Update DownloadsPage to display downloaded wallpapers
- [ ] Add wallpaper setting functionality (apply button using wallpaper_manager)
- [ ] Enhance bottom navigation to avoid stacking pages (use named routes or state management)
- [ ] Update dependent widgets and pages as needed
- [ ] Test on device for wallpaper setting
- [ ] Iterate on UI/UX based on assets
