import 'package:dio/dio.dart';
import '../models/movie.dart';

class ApiService {
  final Dio _dio = Dio();
  final String apiKey = '5553b77e';  // Your OMDB API key

  Future<List<Movie>> searchMovies(String query, {int page = 1}) async {
    try {
      final response = await _dio.get(
        'https://www.omdbapi.com/',
        queryParameters: {
          'apikey': apiKey,
          's': query,
          'page': page,
        },
      );

      if (response.statusCode == 200) {
        final data = response.data;
        if (data['Response'] == 'True' && data['Search'] != null) {
          final results = data['Search'] as List;
          return results.map((json) => Movie.fromJson(json)).toList();
        }
      }
      return [];
    } catch (e) {
      print('Error searching movies: $e');
      return [];
    }
  }

  // Add this method to get detailed movie info by ID
  Future<Movie?> getMovieDetails(String imdbId) async {
    try {
      final response = await _dio.get(
        'https://www.omdbapi.com/',
        queryParameters: {
          'apikey': apiKey,
          'i': imdbId,
          'plot': 'full',  // Get full plot
        },
      );

      if (response.statusCode == 200) {
        final data = response.data;
        if (data['Response'] == 'True') {
          return Movie.fromDetailJson(data);
        }
      }
      return null;
    } catch (e) {
      print('Error getting movie details: $e');
      return null;
    }
  }

  Future<List<Movie>> fetchTrendingMovies() async {
    return searchMovies('marvel');
  }
}