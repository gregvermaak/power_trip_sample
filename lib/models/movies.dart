
class Movie {
  final String poster;
  final String title;
  final String description;
 
  const Movie({
    required this.poster,
    required this.title,
    required this.description,
  });

  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
      poster: json['Poster'],
      title: json['Title'],
      description: json['Plot'],
    );
  }
}