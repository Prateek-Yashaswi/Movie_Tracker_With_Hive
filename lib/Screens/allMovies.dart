import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';
import 'package:http/http.dart' as http;
import 'package:yellow_class/Widgets/movies.dart';
import '../models/movies.dart';

class allMovies extends StatefulWidget {
  const allMovies({Key? key}) : super(key: key);

  @override
  _allMoviesState createState() => _allMoviesState();
}

class _allMoviesState extends State<allMovies> {

  List<Movie> _movies = [];
  String query="";
  bool _status = false;
  String q="";
  bool error=true;
  @override
  void initState(){
    super.initState();
    _status=false;
    error = true;
  }

  void _populateAllMovies(String data) async{
    final movies = await _fetchAllMovies(data);
    setState(() {
      _movies = movies;
      _status = true;
      error=false;
    });
  }
  
  Future<List<Movie>> _fetchAllMovies(String query) async{
    String myUrl = "https://www.omdbapi.com/?s=$query&apikey=97abcb8c";
    final response = await http.get(Uri.parse(myUrl));

    if(response.statusCode == 200){
        final result = jsonDecode(response.body);
        Iterable list = result["Search"];
        return list.map((movie) => Movie.fromJson(movie)).toList();
    }

    else{
      throw Exception("Error");
    }
  }

  Widget searchQuery(){
    return Padding(
      padding: const EdgeInsets.all(18.0),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              child: Image.asset("assets/Image1.png"),
            ),
            SizedBox(height: 40,),
            TextFormField(
              decoration: new InputDecoration(
                labelText: "Enter A Movie Name",
                labelStyle: TextStyle(color: Colors.amber,fontSize: 18),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25.0),
                  borderSide: BorderSide(
                    color: Colors.amber
                  )
                ),
                focusedBorder: new OutlineInputBorder(
                  borderRadius: new BorderRadius.circular(25.0),
                  borderSide: new BorderSide(
                    color: Colors.amber
                  ),
                ),
              ),
              onChanged: (val){
                setState(() {
                  q=val;
                });
              },
              validator: (String? value) {
                if (value == null || value.isEmpty) {
                  return "Fail";
                }
                return null;
              },
            ),
            SizedBox(height: 20,),
            GFButton(
                onPressed: (){
                  _populateAllMovies(q);
                },
                color: GFColors.WARNING,
                size: GFSize.LARGE,
                fullWidthButton: true,
                shape: GFButtonShape.pills,
                text:"Search",
                textStyle: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 10,),
            error ? Text("Enter A Valid Movie Name To Continue (Must Be Spelled Correctly)",textAlign: TextAlign.center,): Text("")
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
            appBar: GFAppBar(
              backgroundColor: Colors.amber,
              leading:  GFIconButton(
                icon: Icon(
                  Icons.arrow_back,
                  color: Colors.black,
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
                type: GFButtonType.transparent,
              ),
              title: Text("Movie List",style: TextStyle(color: Colors.black)),
            ),
            body: _status ? MoviesWidget(movies: _movies) : searchQuery(),
        );
  }
}
