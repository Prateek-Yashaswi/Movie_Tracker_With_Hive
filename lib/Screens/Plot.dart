import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';
import 'package:http/http.dart' as http;

class readPlot extends StatefulWidget {
  String imdbID,movieTitle;
  readPlot({Key? key,required this.imdbID,required this.movieTitle}) : super(key: key);

  @override
  _readPlotState createState() => _readPlotState(imdbID:imdbID,movieTitle: movieTitle);
}

class _readPlotState extends State<readPlot> {

  String imdbID="";
  String movieTitle="";
  _readPlotState({required this.imdbID,required this.movieTitle});

  @override
  void initState(){
    super.initState();
    fetchPlot();
  }

  String plot="Fetching...Please Wait";
  String releaseDate="Fetching...Please Wait";
  String budget="Fetching...Please Wait";
  String avgVote="Fetching...Please Wait";
  String status="Fetching...Please Wait";
  String production="Fetching...Please Wait";
  bool showFloatingToast=true;
  String countryOfOrigin="Data Not Available";

  Future fetchPlot() async{
    print(imdbID);
    String myurl="https://api.themoviedb.org/3/movie/$imdbID?api_key=d73637ac0851a364c2cc78187cc65504&language=en-US";
    final response = await http.get(Uri.parse(myurl));
    print(response.statusCode);
    if(response.statusCode==200){
      final result = jsonDecode(response.body);
      setState(() {
        plot = result["overview"];
        releaseDate = result["release_date"];
        budget = result["budget"].toString();
        avgVote = result["vote_average"].toString();
        status = result["status"];
        production = result["production_companies"][0]["name"];
        countryOfOrigin = result["production_countries"][0]["name"];
      });
    }
    else{
      setState(() {
        plot = "Data Not Available";
        releaseDate = "Data Not Available";
        budget = "Data Not Available";
        avgVote = "Data Not Available";
        status = "Data Not Available";
        production = "Data Not Available";
      });
    }
  }

  Widget displayDetails(String title,String content){
    return GFAccordion(
        title: '$title',
        contentChild: Text("$content",style: TextStyle(fontSize: MediaQuery.of(context).size.width*0.04,),textAlign: TextAlign.start,),
        showAccordion: true,
        textStyle: TextStyle(fontWeight: FontWeight.bold,fontSize: MediaQuery.of(context).size.width*0.06),
        collapsedIcon: Icon(Icons.add),
        expandedIcon: Text('Hide')
    );
  }

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
          title: Text("Movie Details",style: TextStyle(color: Colors.black)),
        ),

        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: 20,),
                  displayDetails("Movie Name", movieTitle),
                  displayDetails("Plot", plot),
                  displayDetails("Production", production),
                  displayDetails("Release Date", "Format: YYYY-MM-DD\n$releaseDate"),
                  displayDetails("Country Of Origin", "$countryOfOrigin"),
                  displayDetails("Budget", "Currency Depending On The Country Of Origin\n$budget"),
                  displayDetails("Average Vote", avgVote),
                  displayDetails("Status", status),
                ],
              )
          ),
        ),
      ),
    );
  }
}
