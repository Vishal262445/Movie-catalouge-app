import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(MovieCatalogApp());
}

class MovieCatalogApp extends StatefulWidget {
  @override
  _MovieCatalogAppState createState() => _MovieCatalogAppState();
}

class _MovieCatalogAppState extends State<MovieCatalogApp> {
  List<Map<String, dynamic>> _movies = [];
  bool _isLoading = false;
  bool _isDarkMode = false; // Variable to track dark mode status

  @override
  void initState() {
    super.initState();
    _fetchPopularMovies();
  }

  Future<void> _fetchPopularMovies() async {
    setState(() {
      _isLoading = true;
    });

    final apiKey =
        '395f8d4d09a0f44dd87820ceabe113c6'; // Replace with your TMDb API key
    final url =
        Uri.parse('https://api.themoviedb.org/3/movie/popular?api_key=$apiKey');

    try {
      final response = await http.get(url);
      final decodedData = jsonDecode(response.body);
      setState(() {
        _movies = List<Map<String, dynamic>>.from(decodedData['results']);
        _isLoading = false;
      });
    } catch (error) {
      print('Failed to fetch popular movies: $error');
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: _isDarkMode
          ? ThemeData.dark()
          : ThemeData.light(), // Toggle between dark and light theme
      home: Scaffold(
        appBar: AppBar(
          title: Text('Movie Catalog App'),
          actions: [
            IconButton(
              icon: Icon(Icons.lightbulb),
              onPressed: () {
                setState(() {
                  _isDarkMode = !_isDarkMode; // Toggle dark mode status
                });
              },
            ),
            PopupMenuButton<String>(
              itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
                PopupMenuItem<String>(
                  value: 'small',
                  child: Text('Small Text'),
                ),
                PopupMenuItem<String>(
                  value: 'medium',
                  child: Text('Medium Text'),
                ),
                PopupMenuItem<String>(
                  value: 'large',
                  child: Text('Large Text'),
                ),
              ],
              onSelected: (String value) {
                setState(() {
                  _updateFontSize(value);
                });
              },
            ),
          ],
        ),
        body: _isLoading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 8.0,
                  mainAxisSpacing: 8.0,
                  childAspectRatio: 0.65,
                ),
                itemCount: _movies.length,
                itemBuilder: (context, index) {
                  final movie = _movies[index];
                  return _buildMovieItem(movie);
                },
              ),
      ),
    );
  }

  Widget _buildMovieItem(Map<String, dynamic> movie) {
    return GestureDetector(
      onTap: () {
        // Handle tap on movie item (e.g., navigate to movie details screen)
      },
      child: Card(
        elevation: 4.0,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AspectRatio(
              aspectRatio: 0.7,
              child: Image.network(
                'https://image.tmdb.org/t/p/w200${movie['poster_path']}',
                fit: BoxFit.contain,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                movie['title'],
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize:
                      _getFontSize(), // Get font size based on current selection
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Text(
                'Release Date: ${movie['release_date']}',
                style: TextStyle(
                  color: Colors.grey[600],
                  fontSize: _getFontSize() -
                      2, // Adjust smaller font size for release date
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _updateFontSize(String value) {
    // Update font size based on selection
    switch (value) {
      case 'small':
        // Set font size to small
        break;
      case 'medium':
        // Set font size to medium
        break;
      case 'large':
        // Set font size to large
        break;
      default:
        break;
    }
  }

  double _getFontSize() {
    // Return the appropriate font size based on current selection
    // You can implement logic here to return different font sizes based on user selection
    // For simplicity, returning a fixed font size of 16.0
    return 16.0;
  }
}
