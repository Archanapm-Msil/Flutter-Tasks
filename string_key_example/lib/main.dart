import 'package:flutter/material.dart';

class Movie {
  String title;
  String description;
  String posterUrl;

  Movie({required this.title, required this.description, required this.posterUrl});
}

Map<String, Movie> movieCatalog = {
  "movie1": Movie(
    title: "Movie 1",
    description: "Description of Movie 1",
    posterUrl: "https://example.com/poster1.jpg",
  ),
  "movie2": Movie(
    title: "Movie 2",
    description: "Description of Movie 2",
    posterUrl: "https://example.com/poster2.jpg",
  ),
};

class MovieCatalogApp extends StatelessWidget {
  const MovieCatalogApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Movie Catalog'),
        ),
        body: ListView.builder(
          itemCount: movieCatalog.length,
          itemBuilder: (context, index) {
            String movieId = movieCatalog.keys.elementAt(index);
            Movie movie = movieCatalog[movieId]!;
            return ListTile(
              leading: Image.network(movie.posterUrl),
              title: Text(movie.title),
              subtitle: Text(movie.description),
            );
          },
        ),
      ),
    );
  }
}

void main() {
  runApp(MovieCatalogApp());
}
