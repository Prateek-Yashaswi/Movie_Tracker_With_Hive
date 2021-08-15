import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:yellow_class/Screens/Plot.dart';
import 'package:yellow_class/Screens/allMovies.dart';
import 'package:yellow_class/Screens/homepage.dart';
import 'package:yellow_class/Screens/login.dart';
import 'Screens/addMovies.dart';
import 'Screens/addToHive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart' as path_provider;

import 'models/hive.dart';
void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await Hive.initFlutter();

  Hive.registerAdapter(hiveModelAdapter());
  await Hive.openBox<hiveModel>('hiveModel');
  runApp(
    MaterialApp(
      initialRoute: '/login',
      routes: {
        '/login':(context) =>login(),
        '/homepage':(context) => homepage(),
        '/allMovies':(context) => allMovies(),
        '/addMovies': (context) => addMovies(movieName: "None",movieDate: "None", moviePoster: "None",imdbID: "None",),
        '/readPlot': (context) => readPlot(imdbID: "None",movieTitle: "None",),
        '/addToHive': (context) => addToHive(movieName: "None",moviePoster: "None",production: "None",),
      },
    )
  );
}