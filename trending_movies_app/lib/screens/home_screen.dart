import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/movie_provider.dart';
import '../models/movie.dart';
import '../widgets/movie_card.dart';
import '../widgets/trending_slider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _searchController = TextEditingController();
  bool _isSearching = false;

  @override
  void initState() {
    super.initState();
    // Load trending movies when screen initializes
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<MovieProvider>(context, listen: false).fetchMovies();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            expandedHeight: 80,
            flexibleSpace: FlexibleSpaceBar(
              titlePadding: const EdgeInsets.only(left: 16, bottom: 16),
              title: _isSearching
                  ? Container(
                      width: MediaQuery.of(context).size.width * 0.7,
                      height: 40,
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      decoration: BoxDecoration(
                        color: Colors.grey[900],
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: TextField(
                        controller: _searchController,
                        decoration: const InputDecoration(
                          hintText: 'Search movies...',
                          border: InputBorder.none,
                          hintStyle: TextStyle(color: Colors.grey),
                          icon: Icon(Icons.search, color: Colors.grey),
                        ),
                        style: const TextStyle(color: Colors.white, fontSize: 16),
                        onSubmitted: (query) {
                          if (query.isNotEmpty) {
                            Provider.of<MovieProvider>(context, listen: false)
                                .searchMovies(query);
                          }
                        },
                      ),
                    )
                  : const Text(
                      'MoviesHub',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
            ),
            actions: [
              IconButton(
                icon: Icon(_isSearching ? Icons.close : Icons.search),
                onPressed: () {
                  setState(() {
                    _isSearching = !_isSearching;
                    if (!_isSearching) {
                      _searchController.clear();
                      Provider.of<MovieProvider>(context, listen: false)
                          .fetchMovies();
                    }
                  });
                },
              ),
            ],
          ),
          Consumer<MovieProvider>(
            builder: (context, movieProvider, child) {
              if (movieProvider.isLoading) {
                return const SliverFillRemaining(
                  child: Center(
                    child: CircularProgressIndicator(
                      color: Color(0xFFE50914),
                    ),
                  ),
                );
              }
              
              if (movieProvider.movies.isEmpty) {
                return const SliverFillRemaining(
                  child: Center(
                    child: Text('No movies found'),
                  ),
                );
              }
              
              return SliverList(
                delegate: SliverChildListDelegate([
                  // Featured slider for first 5 movies
                  if (!_isSearching && movieProvider.movies.length > 4)
                    TrendingSlider(movies: movieProvider.movies.take(5).toList()),
                  
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 24, 16, 8),
                    child: Text(
                      _isSearching ? 'Search Results' : 'Popular Movies',
                      style: const TextStyle(
                        fontSize: 20, 
                        fontWeight: FontWeight.bold
                      ),
                    ),
                  ),
                  
                  GridView.builder(
                    padding: const EdgeInsets.all(16),
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 0.7,
                      crossAxisSpacing: 16,
                      mainAxisSpacing: 16,
                    ),
                    itemCount: movieProvider.movies.length,
                    itemBuilder: (context, index) {
                      return MovieCard(movie: movieProvider.movies[index]);
                    },
                  ),
                ]),
              );
            },
          ),
        ],
      ),
    );
  }
}