import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:power_trip_sample/models/movies.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late Future<Movie> futureMovie;

  @override
  void initState() {
    super.initState();
    futureMovie = fetchMovies();
  }

  Future<Movie> fetchMovies() async {
  final response = await http
      .get(Uri.parse('http://www.omdbapi.com/?i=tt3896198&apikey=a5e42fd1'));
  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    return Movie.fromJson(jsonDecode(response.body));
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load movies');
  }
}

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Movies',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Movies'),
        ),
        body: Center(
          child: FutureBuilder<Movie>(
            future: futureMovie,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Image(
                          image : NetworkImage(snapshot.data!.poster),
                        ),
                        Text(snapshot.data!.title),
                        Text(snapshot.data!.description),
                      ],
                    ),
                  ),
                );
              } else if (snapshot.hasError) {
                return Text('${snapshot.error}');
              }
              // By default, show a loading spinner.
              return const CircularProgressIndicator();
            },
          ),
        ),
      ),
    );
  }
}
