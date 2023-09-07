import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../helpers/constants.dart';
import '../models/genre.dart';
import '../models/movie.dart';
import '../providers/genre_provider.dart';
import '../providers/movie_provider.dart';
import '../utils/authorization.dart';
import '../utils/error_dialog.dart';
import 'movie_detail_screen.dart';


class MoviesScreen extends StatefulWidget {
  const MoviesScreen({Key? key}) : super(key: key);

  @override
  State<MoviesScreen> createState() => _MoviesScreenState();
}

class _MoviesScreenState extends State<MoviesScreen> {
  late MovieProvider _movieProvider;
  late GenreProvider _genreProvider;
  List<Genre> genres = <Genre>[];
  List<Movie> movies = <Movie>[];
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  int? selectedGenre;
  bool loading = false;

  @override
  void initState() {
    super.initState();

    _movieProvider = context.read<MovieProvider>();
    _genreProvider = context.read<GenreProvider>();
    loadData();
  }

  void loadData() async {
    loadGenres();
    loadMovies();
  }

  Future loadGenres() async {
    try {
      var data = await _genreProvider.get(null);
      setState(() {
        genres = data;
      });
      print(genres);
    } on Exception catch (e) {
      showErrorDialog(context, e.toString().substring(11));
    }
  }

  void loadMovies() async {
    loading = true;
    try {
      var params = <String, String>{};
      if(selectedGenre!=null)
        {
          params.addAll({'GenreId': selectedGenre!.toString()});
        }
      var data = await _movieProvider.get(params);
      setState(() {
        movies = data;
      });
      loading = false;
    } on Exception catch (e) {
      showErrorDialog(context, e.toString().substring(11));
    }
  }
  void loadMostWatchedMovies() async {
    loading = true;
    try {
      var data = await _movieProvider.getMostWatchedMovies(1000);
      setState(() {
        movies = data;
      });
      loading = false;
    } on Exception catch (e) {
      showErrorDialog(context, e.toString().substring(11));
    }
  }
  void loadLastAddMovies() async {
    loading = true;
    try {
      var data = await _movieProvider.getLastAddMovies(1000);
      setState(() {
        movies = data;
      });
      loading = false;
    } on Exception catch (e) {
      showErrorDialog(context, e.toString().substring(11));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Filmovi"),
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            ListTile(
              title: Text("Najgledaniji filmovi"),
              onTap: () {
                loadMostWatchedMovies();
              },
            ),
            ListTile(
              title: Text("Posljednje dodani filmovi"),
              onTap: () {
                loadLastAddMovies();
              },
            ),
            Divider(),
            ...genres.map((e) =>
                ListTile(
                  title: Text(e.name),
                  onTap: () {
                    setState(() {
                      selectedGenre = e.id;
                    });
                    loadMovies();
                    // Handle onTap action
                  },
                )),
          ],
        ),
      ),
      body: Column(
        children: [
          SizedBox(height: 20,),
          _buildMovieList(movies)
        ],
      )
    );
  }

  Widget _buildMovieList(List<Movie> movies) {
    return Expanded(
      child: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          childAspectRatio: 0.7,
        ),
        padding: const EdgeInsets.all(8),
        itemCount: movies.length,
        itemBuilder: (context, index) {
          return _buildMovies(context, movies[index]);
        },
      ),
    );
  }

  Widget _buildMovies(BuildContext context, Movie movie) {
    return GestureDetector(
      onTap: () => Navigator.pushNamed(
        context,
        MovieDetailScreen.routeName,
        arguments: movie,
      ),
      child: Container(
        margin: EdgeInsets.all(8),
        child: Column(
          children: [
            Expanded( // Dodajte Expanded oko slike
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15.0),
                child: Image.network(
                  'https://picsum.photos/250?image=${movie.photoId}',
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}