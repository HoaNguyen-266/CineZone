// lib/models/movie.dart

class Movie {
  final String title;
  final String imagePath;
  final double rating;
  final int duration;
  final String releaseDate;
  final String description;
  final List<Map<String, String>> actors;
  final Map<String, String> director;

  Movie(this.title, this.imagePath, this.rating, this.duration, this.releaseDate,
      this.description, this.actors, this.director);

  Map<String,dynamic> toJson(){
    return {
      'title': title,
      'imagePath': imagePath,
      'rating': rating,
      'duration': duration,
      'releaseDate': releaseDate,
      'description': description,
      'actors': actors,
      'director': director,
      'updateAt': DateTime.now().toIso8601String(),
    };
  }
}