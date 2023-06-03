class Genre {
  final int id;
  final String name;

  Genre({
    required this.id,
    required this.name,
  });

  Genre.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'];
}
