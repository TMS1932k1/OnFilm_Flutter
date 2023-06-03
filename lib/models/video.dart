class Video {
  final String id;
  final String publishedAt;
  final String type;
  final int size;
  final String key;
  final String name;
  final String language;
  final String country;

  Video({
    required this.id,
    required this.publishedAt,
    required this.type,
    required this.size,
    required this.key,
    required this.name,
    required this.language,
    required this.country,
  });

  Video.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        publishedAt = json['published_at'],
        type = json['type'],
        size = json['size'],
        key = json['key'],
        language = json['iso_639_1'],
        country = json['iso_3166_1'],
        name = json['name'];
}
