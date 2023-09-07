import 'package:ecinema_mobile/screens/seats_screen.dart';
import 'package:flutter/material.dart';

import '../models/movie.dart';

class MovieDetailScreen extends StatefulWidget {
  const MovieDetailScreen({super.key, required this.movie});

  static const String routeName = '/movie';
  final Movie movie;

  @override
  State<MovieDetailScreen> createState() => _MovieDetailScreenState();
}

class _MovieDetailScreenState extends State<MovieDetailScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Movie details"),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Expanded(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(15.0),
                        child: Image.network('https://picsum.photos/250?image=${widget.movie.photoId}',
                          fit: BoxFit.cover,
                          height: 280,
                          width: 210,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 20),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          InfoCard(widget.movie.duration.toString(), Icons.timer),
                          InfoCard(widget.movie.releaseYear.toString(), Icons.calendar_today),
                          InfoCard(widget.movie.numberOfViews.toString(), Icons.star),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                  vertical: 10, horizontal: 40.0),
              child: Text(
                  widget.movie.title, style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold,)),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 40.0),
              child: Text(widget.movie.description, style: TextStyle(fontSize: 18)),
            ),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
              child: SizedBox(
                width: 400,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size.fromHeight(50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onPressed: () {
                    Navigator.pushNamed(
                      context,
                      SeatsScreen.routeName,
                      arguments: widget.movie
                    );
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      SizedBox(width: 10),
                      Text('Make reservation'),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
  Widget InfoCard(String text,IconData icon)
  {
    return Card(
        elevation: 4,
        color: Colors.teal,
        child: Container(
            height: 80,
            width: 80,
            padding: EdgeInsets.all(10),
            child: Column(
              children: <Widget>[
                Icon(icon,       // Added Icon
                    size: 35,
                  color: Colors.white,
                ),
                SizedBox(height: 5),    // Added SizeBox
                Text(text,style: TextStyle(color: Colors.white),),
              ],
            )
        )
    );
  }
}
