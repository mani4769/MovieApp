class Movie {
  final String id;
  final String title;
  final String posterPath;
  final String overview;
  final String releaseDate;
  final double rating;

  Movie({
    required this.id,
    required this.title,
    required this.posterPath,
    required this.overview,
    required this.releaseDate,
    required this.rating,
  });

  // For search results
  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
      id: json['imdbID'] ?? '',
      title: json['Title'] ?? '',
      posterPath: json['Poster'] ?? '',
      overview: '', // Search doesn't include plot
      releaseDate: json['Year'] ?? '',
      rating: 0.0, // Search doesn't include rating
    );
  }

  // For detailed movie info
  factory Movie.fromDetailJson(Map<String, dynamic> json) {
    return Movie(
      id: json['imdbID'] ?? '',
      title: json['Title'] ?? '',
      posterPath: json['Poster'] ?? '',
      overview: json['Plot'] ?? '',
      releaseDate: json['Year'] ?? '',
      rating: double.tryParse(json['imdbRating'] ?? '0') ?? 0.0,
    );
  }
}