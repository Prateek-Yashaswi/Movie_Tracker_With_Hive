import 'package:flutter/material.dart';
import 'package:yellow_class/Screens/Plot.dart';
import 'package:yellow_class/Screens/addMovies.dart';
import 'package:yellow_class/models/movies.dart';
import 'package:getwidget/getwidget.dart';

class MoviesWidget extends StatelessWidget{
  List<Movie> movies;
  MoviesWidget({required this.movies});
  @override
  Widget build(BuildContext context){
    return ListView.builder(
        itemCount: movies.length,
        itemBuilder: (context, index) {

          final movie = movies[index];
          final poster;
          final imdbID = movie.imdbId;
          if(movie.poster=="N/A"){
            poster="https://cdn.pixabay.com/photo/2017/06/02/22/01/dog-2367414_960_720.png";
          }
          else{
            poster=movie.poster;
          }
          return Padding(
            padding: const EdgeInsets.all(12.0),
            child: ListTile(
                title: Row(children: [
                  SizedBox(
                      width: 100,
                      child: ClipRRect(
                        child: Image.network(poster),
                        borderRadius: BorderRadius.circular(10),
                      )

                  ),
                  SizedBox(width: 20,),
                  Flexible(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(movie.title,style: TextStyle(fontWeight: FontWeight.bold),),
                          SizedBox(height: 8,),
                          Text(movie.year),
                          GFButton(
                            onPressed: (){
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                  builder: (context) => addMovies(movieName: movie.title,movieDate: movie.year,moviePoster: movie.poster,imdbID: imdbID)),
                              );
                            },
                            text: "Add To Watched ",
                            textStyle: TextStyle(color: Colors.black),
                            shape: GFButtonShape.pills,
                            icon: Icon(Icons.add,color: Colors.amber,),
                            type: GFButtonType.outline,
                            color: Colors.amber,
                            splashColor: Colors.yellow,
                          ),
                          GFButton(
                            onPressed: (){
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => readPlot(imdbID: imdbID,movieTitle: movie.title,)),
                              );
                            },
                            text: "More Details ",
                            textStyle: TextStyle(color: Colors.black),
                            shape: GFButtonShape.pills,
                            icon: Icon(Icons.info_sharp,color: Colors.amber,),
                            type: GFButtonType.outline,
                            color: Colors.amber,
                            splashColor: Colors.yellow,
                          ),
                        ],),
                    ),
                  )
                ],)
            ),
          );
        }
    );
  }
}