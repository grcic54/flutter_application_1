class Igre {
  final String id;
  final String title;
  final String genre;
  final String platform;
  final String publisher;
  final String developer;
  final String releaseDate;
  final String description;
  final String thumbnail;

  Igre({
    required this.id,
    required this.title,
    required this.genre,
    required this.platform,
    required this.publisher,
    required this.developer,
    required this.releaseDate,
    required this.description,
    required this.thumbnail,
  });

  factory Igre.fromJson(Map<String, dynamic> json) {
    return Igre(
      id: json['id'].toString(),
      title: json['title']?.toString() ?? 'Nepoznato',
      genre: json['genre']?.toString() ?? 'Nepoznato',
      platform: json['platform']?.toString() ?? 'Nepoznato',
      publisher: json['publisher']?.toString() ?? 'Nepoznato',
      developer: json['developer']?.toString() ?? 'Nepoznato',
      releaseDate: json['release_date']?.toString() ?? 'Nepoznato',
      description:
          json['short_description']?.toString() ??
          'Nema opisa', // bez ovog ne radi
      thumbnail: json['thumbnail']?.toString() ?? '',
    );
  }
}
