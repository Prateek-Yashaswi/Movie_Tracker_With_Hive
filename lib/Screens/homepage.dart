import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:getwidget/getwidget.dart';
import 'package:provider/provider.dart';
import 'package:yellow_class/models/googleSignin_provider.dart';

import 'addToHive.dart';


class homepage extends StatefulWidget {
  const homepage({Key? key}) : super(key: key);

  @override
  _homepageState createState() => _homepageState();
}


class _homepageState extends State<homepage> {
  @override
  final List<String> imageList = [
    "https://cdn.pixabay.com/photo/2018/01/03/01/17/film-3057394_960_720.jpg",
    "https://cdn.pixabay.com/photo/2019/04/24/21/55/cinema-4153289_960_720.jpg",
    "https://cdn.pixabay.com/photo/2017/11/24/10/43/ticket-2974645_960_720.jpg",
    "https://cdn.pixabay.com/photo/2015/12/09/17/12/popcorn-1085072_960_720.jpg",
    "https://cdn.pixabay.com/photo/2019/05/23/13/11/headphones-4223911_960_720.jpg",
  ];

  Widget homeCarousel(){
    return GFCarousel(
      autoPlay: true,
      autoPlayInterval: Duration(seconds: 3),
      items: imageList.map(
            (url) {
          return Container(
            margin: EdgeInsets.all(8.0),
            child: ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(8.0)),
              child: Image.network(
                  url,
                  fit: BoxFit.cover,
                  width: 1000.0
              ),
            ),
          );
        },
      ).toList(),
      onPageChanged: (index) {
        setState(() {
          index;
        });
      },
    );
  }
  
  Widget featuresList(String data){
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Icon(
            Icons.check_circle_outline
        ),
        SizedBox(width: 8,),
        Expanded(
            child: Text("$data",
            style: TextStyle(fontWeight: FontWeight.bold),
            overflow: TextOverflow.fade,
            maxLines: 3,
            softWrap: true,)),
      ],
    );
  }

  Widget myDrawer(String photoURL,String email,String name){
    return GFDrawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          GFDrawerHeader(
            decoration: BoxDecoration(
            color: Colors.amber),
            currentAccountPicture: GFAvatar(
              radius: 80.0,
              backgroundImage: NetworkImage(photoURL),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(name,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),),
                Text(email,style: TextStyle(fontSize: 12),),
              ],
            ),
          ),
          Container(
            child: GFButton(
              fullWidthButton: true,
              onPressed: (){
                Navigator.pushNamed(context, '/allMovies');
              },
              child:Text("Get Poster And Other Details",style: TextStyle(fontSize: 16,color: Colors.black),),
              color: Colors.transparent,
            ),
          ),
          Container(
            child: GFButton(
              fullWidthButton: true,
              onPressed: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => addToHive(movieName: "movieName",moviePoster: "moviePoster",production: "production",)),
                );
              },
              child:Text("See Added/Add Movies To Hive",style: TextStyle(fontSize: 16,color: Colors.black),),
              color: Colors.transparent,
            ),
          ),
          Container(
            child: GFButton(
              fullWidthButton: true,
              onPressed: () {
                final provider = Provider.of<GoogleSignInProvider>(context,listen: false);
                provider.logout();
              },
              child:Text("Logout",style: TextStyle(fontSize: 16,color: Colors.black),),
              color: Colors.transparent,
            ),
          ),
          Container(
            child: GFButton(
              fullWidthButton: true,
              onPressed: (){
                SystemNavigator.pop();
              },
              child:Text("Exit App",style: TextStyle(fontSize: 16,color: Colors.black),),
              color: Colors.transparent,
            ),
          ),
        ],
      ),
    );
  }

  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    String photoUrl="https://cdn.pixabay.com/photo/2017/06/02/22/01/dog-2367414_960_720.png";
    String email="Data Unavailable";
    String name="Date Unavailable";
    if(user!.photoURL!=null){
      photoUrl = user.photoURL!;
      email = user.email!;
      name = user.displayName!;
    }
    return SafeArea(
      child: Scaffold(
        drawer: myDrawer(photoUrl,email,name),
        appBar: GFAppBar(
          iconTheme:IconThemeData(color: Colors.black),
          backgroundColor: Colors.amber,
          centerTitle: false,
          title: Text("Movie Tracker Using Hive",style: TextStyle(color: Colors.black),),
        ),
        body: SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(child: homeCarousel(),),
                Container(
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      children: [
                        GFTypography(
                          text: 'Features:',
                          type: GFTypographyType.typo1,
                        ),
                        SizedBox(height: 20,),
                        featuresList("Simple Aesthetic App To Add/Edit/Delete/List Movies That A User Has Watched."),
                        SizedBox(height: 8,),
                        featuresList("An Infinite Scrollable Listview Containing All The Movies That A User Has Created."),
                        SizedBox(height: 8,),
                        featuresList("A Form To Add A New Movie Or Edit An Existing One."),
                        SizedBox(height: 8,),
                        featuresList("List Item Should Having A Delete Icon To Remove That Movie From The List And An Edit Icon To Allow Edit On That Movie."),
                        SizedBox(height: 8,),
                        featuresList("Data Stored In Hive."),
                        SizedBox(height: 16,),
                        GFButton(
                          onPressed: (){
                            Navigator.pushNamed(context, '/allMovies');
                          },
                          child:Text("Get Poster And Other Details",style: TextStyle(fontSize: 16,color: Colors.black),),
                          splashColor: Colors.yellow,
                          color: Colors.amber,
                          fullWidthButton: true,
                          type: GFButtonType.outline2x,
                          size: GFSize.LARGE,
                          shape: GFButtonShape.pills,
                          highlightColor: Colors.amber,
                        ),
                        SizedBox(height: 12,),
                        GFButton(
                          onPressed: (){
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => addToHive(movieName: "movieName",moviePoster: "moviePoster",production: "production",)),
                            );
                          },
                          child:Text("See Added/Add Movies To Hive",style: TextStyle(fontSize: 16,color: Colors.black),),
                          splashColor: Colors.yellow,
                          color: Colors.amber,
                          fullWidthButton: true,
                          type: GFButtonType.outline2x,
                          size: GFSize.LARGE,
                          shape: GFButtonShape.pills,
                          highlightColor: Colors.amber,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

