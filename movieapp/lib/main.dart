import 'package:flutter/material.dart';
import 'package:movieapp/utils/text.dart';
import 'package:movieapp/widgets/toprated.dart';
import 'package:movieapp/widgets/tv.dart'; // Import the Tv widget correctly
import 'package:movieapp/widgets/trending.dart';
import 'package:tmdb_api/tmdb_api.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Home(),
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: const Color.fromARGB(255, 74, 219, 245),
      ),
    );
  }
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List trendingmovies = [];
  List topratedmovies = [];
  List tv = [];
  final String apikey = '395f8d4d09a0f44dd87820ceabe113c6';
  final readacesstoken =
      'eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiIzOTVmOGQ0ZDA5YTBmNDRkZDg3ODIwY2VhYmUxMTNjNiIsInN1YiI6IjY1ZmQyOTk1NjA2MjBhMDE3YzI5MzIwZiIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.tS2k4_KBjxdeg5EAq2ZaGnkFs1P07YmLp0NvUEYYLD8';

  void initState() {
    loadmovies();
    super.initState();
  }

  loadmovies() async {
    TMDB tmdbWithCustomLogs = TMDB(ApiKeys(apikey, readacesstoken),
        logConfig: const ConfigLogger(showLogs: true, showErrorLogs: true));

    Map trendingresult = await tmdbWithCustomLogs.v3.trending.getTrending();
    Map topratedresult = await tmdbWithCustomLogs.v3.movies.getTopRated();
    Map tvresult = await tmdbWithCustomLogs.v3.tv.getPopular();
    // print(trendingresult);
    setState(() {
      trendingmovies = trendingresult['results'];
      topratedmovies = topratedresult['results'];
      tv = tvresult['results'];
    });
    print(trendingmovies);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 0, 0, 0),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 79, 82, 79),
        title: modified_text(
          text: 'Flutter Movie App 📽️ ❤️',
          color: Color.fromARGB(255, 255, 255, 255),
          size: 100,
        ),
      ),
      body: ListView(
        children: [
          TopRated(topRated: topratedmovies),
          TvWidget(tvShows: tv), // Use Tv widget instead of tv
          TrendingMovies(trending: trendingmovies),
        ],
      ),
    );
  }
}
