import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:getwidget/getwidget.dart';
import 'package:http/http.dart' as http;
import 'package:yellow_class/Screens/addToHive.dart';
import 'package:yellow_class/Widgets/hiveDialog.dart';
import 'package:yellow_class/models/Boxes.dart';
import 'package:yellow_class/models/hive.dart';

class addMovies extends StatefulWidget {
  String movieName;
  String movieDate;
  String moviePoster;
  String imdbID;
  addMovies({Key? key,required this.movieName,required this.movieDate,required this.moviePoster,required this.imdbID}) : super(key: key);

  @override
  _addMoviesState createState() => _addMoviesState(movieName: movieName,movieDate: movieDate,moviePoster:moviePoster,imdbID: imdbID);
}

class _addMoviesState extends State<addMovies> {

  String movieName;
  String movieDate;
  String moviePoster;
  String imdbID;

  _addMoviesState({required this.movieName,required this.movieDate,required this.moviePoster,required this.imdbID});

  @override
  void initState(){
    super.initState();
    fetchProduction();
  }
  String production="Fetching...Please Wait";
  Future fetchProduction() async{
    String myurl="https://api.themoviedb.org/3/movie/$imdbID?api_key=d73637ac0851a364c2cc78187cc65504&language=en-US";
    final response = await http.get(Uri.parse(myurl));
    if(response.statusCode==200){
      final result = jsonDecode(response.body);
      setState(() {
        production = result["production_companies"][0]["name"];
      });
    }
    else{
      setState(() {
        production = "Data Not Available";
      });
    }
  }

  void showToast(String data){
    Fluttertoast.showToast(
        msg: '$data',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.amber,
        textColor: Colors.black
    );
  }

  Widget movieData(String mName,String mDate, String mPoster,String production){
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GFTypography(
          text: 'Movie Name',
          type: GFTypographyType.typo4,
        ),
        SizedBox(height: 8,),
        Container(
          child: TextField(
            enabled: false,
            decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: '$mName',
                labelStyle: TextStyle(color: Colors.black)
            ),
          ),
        ),
        SizedBox(height: 16,),
        GFTypography(
          text: 'Movie Date',
          type: GFTypographyType.typo4,
        ),
        Container(
          child: TextField(
            enabled: false,
            decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: '$mDate',
                labelStyle: TextStyle(color: Colors.black)
            ),
          ),
        ),
        SizedBox(height: 16,),
        GFTypography(
          text: 'Movie Poster',
          type: GFTypographyType.typo4,
        ),
        mPoster=="N/A"?
        Container(
          child: TextField(
          enabled: false,
          decoration: InputDecoration(
          border: OutlineInputBorder(),
          labelText: 'Not Available',
          labelStyle: TextStyle(color: Colors.black)
          ),
          ),
        ):
        Column(
          children: [
            Container(
              alignment: Alignment.topLeft,
              child: Image.network(mPoster,width: MediaQuery.of(context).size.width/3,height: MediaQuery.of(context).size.height*0.3,),
            ),
            Container(
              alignment: Alignment.centerLeft,
              child: GFButton(
                  onPressed: (){
                    var data = moviePoster;
                    print(data);
                    Clipboard.setData(ClipboardData(text: data.toString()));
                    showToast("Link Copied To Clipboard");
                  },
                  text:"Copy Link",
                  textColor: Colors.black,
                  color: Colors.amber,
                  splashColor: Colors.yellow,
                  type: GFButtonType.solid,
                  shape: GFButtonShape.pills,
              ),
            ),
          ],
        ),
        SizedBox(height: 16,),
        GFTypography(
          text: 'Production',
          type: GFTypographyType.typo4,
        ),
        Container(
          child: TextField(
            enabled: false,
            decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: '$production',
                labelStyle: TextStyle(color: Colors.black)
            ),
          ),
        ),
      ],
    );
  }

  Future addTransaction(String name, String mPoster, String mProduction,bool isWatched) async {
    final transaction = hiveModel()
      ..movieName = name
      ..poster = mPoster
      ..production = mProduction
      ..watched = isWatched;

    final box = Boxes.getModel();
    box.add(transaction);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
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
          title: Text("Add Movie To Hive",style: TextStyle(color: Colors.black)),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                movieData(movieName,movieDate,moviePoster,production),
                SizedBox(height: 20,),
                GFButton(
                  onPressed: () async{
                    await showDialog(
                      context: context,
                      builder: (context) => hiveDialog(
                        onClickedDone: addTransaction,
                      ),
                    );

                    showToast("Data Added");
                  },
                  highlightColor: Colors.yellow,
                  text: "Add To Hive",
                  textStyle: TextStyle(color: Colors.black),
                  color: Colors.amber,
                  splashColor: Colors.yellow,
                  type: GFButtonType.solid,
                  shape: GFButtonShape.pills,
                  fullWidthButton: true,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
