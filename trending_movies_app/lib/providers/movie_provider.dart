import 'package:flutter/foundation.dart';
import '../services/api_service.dart';
import '../models/movie.dart';

class MovieProvider with ChangeNotifier {
  final ApiService _apiService = ApiService();
  List<Movie> _movies = [];
  bool _isLoading = true;

  List<Movie> get movies => _movies;
  bool get isLoading => _isLoading;

  Future<void> fetchMovies() async {
    _isLoading = true;
    notifyListeners();

    _movies = await _apiService.fetchTrendingMovies();
    _isLoading = false;
    notifyListeners();
  }
  
  Future<void> searchMovies(String query) async {
    _isLoading = true;
    notifyListeners();

    _movies = await _apiService.searchMovies(query);
    _isLoading = false;
    notifyListeners();
  }
}