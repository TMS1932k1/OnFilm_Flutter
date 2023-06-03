class Cast {
  final int id;
  final String name;
  final String character;
  final String? profilePath;

  Cast({
    required this.id,
    required this.name,
    required this.character,
    required this.profilePath,
  });

  Cast.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'],
        character = json['character'],
        profilePath = json['profile_path'];
}
