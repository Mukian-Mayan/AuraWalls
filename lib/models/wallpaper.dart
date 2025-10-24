class Wallpaper {
  final String id;
  final String url;
  final String thumbnailUrl;
  final String category;
  final int downloads;
  final double rating;

  Wallpaper({
    required this.id,
    required this.url,
    required this.thumbnailUrl,
    required this.category,
    this.downloads = 0,
    this.rating = 0.0,
  });

  factory Wallpaper.fromJson(Map<String, dynamic> json) {
    return Wallpaper(
      id: json['id'] ?? '',
      url: json['url'] ?? '',
      thumbnailUrl: json['thumbnailUrl'] ?? json['url'] ?? '',
      category: json['category'] ?? 'General',
      downloads: json['downloads'] ?? 0,
      rating: (json['rating'] ?? 0.0).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'url': url,
      'thumbnailUrl': thumbnailUrl,
      'category': category,
      'downloads': downloads,
      'rating': rating,
    };
  }
}
