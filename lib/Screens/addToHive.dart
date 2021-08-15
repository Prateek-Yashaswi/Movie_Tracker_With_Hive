import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';
import 'package:hive/hive.dart';
import 'package:yellow_class/Widgets/hiveDialog.dart';
import 'package:yellow_class/models/Boxes.dart';
import 'package:yellow_class/models/hive.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class addToHive extends StatefulWidget {
  String movieName;
  String moviePoster;
  String production;
  addToHive({Key? key,required this.movieName,required this.moviePoster,required this.production}) : super(key: key);

  @override
  _addToHiveState createState() => _addToHiveState(movieName: movieName,moviePoster: moviePoster,production: production);
}

class _addToHiveState extends State<addToHive> {
  String movieName;
  String moviePoster;
  String production;

  _addToHiveState({required this.movieName, required this.moviePoster, required this.production});

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: GFAppBar(
      backgroundColor: Colors.amber,
      title: Text("Your List",style: TextStyle(color: Colors.black),),
      iconTheme: IconThemeData(color: Colors.black),
    ),
    body: ValueListenableBuilder<Box<hiveModel>>(
      valueListenable: Boxes.getModel().listenable(),
      builder: (context, box, _) {
        final transactions = box.values.toList().cast<hiveModel>();

        return buildContent(transactions);
      },
    ),
    floatingActionButton: FloatingActionButton(
      child: Icon(Icons.add),
      backgroundColor: Colors.amber,
      onPressed: () => showDialog(
        context: context,
        builder: (context) => hiveDialog(
          onClickedDone: addTransaction,
        ),
      ),
    ),
  );

  Widget buildContent(List<hiveModel> transactions) {
    if (transactions.isEmpty) {
      return Center(
        child: Column(
          children: [
            Image.asset("assets/notadded.png"),
            Text(
              'No Movies Added Yet',
              style: TextStyle(fontSize: 24),
            ),
          ],
        ),
      );
    } else {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                padding: EdgeInsets.all(8),
                itemCount: transactions.length,
                itemBuilder: (BuildContext context, int index) {
                  final transaction = transactions[index];

                  return buildTransaction(context, transaction);
                },
              ),
            ),
          ],
        ),
      );
    }
  }

  Widget buildTransaction(BuildContext context,hiveModel transaction,) {
    final color = transaction.watched ? Colors.green : Colors.red;
    final watched_text = transaction.watched ? "Watched" : "Not Watched";
    final poster = transaction.poster;
    final notAvailable = "Poster Not Available";
    return Card(
      color: Colors.white,
      child: ExpansionTile(
        tilePadding: EdgeInsets.symmetric(horizontal: 24, vertical: 8),
        title: Text(
          transaction.movieName,
          maxLines: 1,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18,color: Colors.black),
        ),
        subtitle: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 12,),
            Text("Directed By, "+transaction.production,style: TextStyle(color: Colors.black)),
            SizedBox(height: 5,),
            Text(
              watched_text,
              style: TextStyle(
                  color: color, fontWeight: FontWeight.bold, fontSize: 16),
            ),
          ],
        ),
        trailing: Uri.tryParse(transaction.poster)?.hasAbsolutePath == true ? Image.network(transaction.poster.toString(),fit: BoxFit.fill,): Text(notAvailable,style: TextStyle(color: Colors.black),),
        children: [
          buildButtons(context, transaction),
        ],
      ),
    );
  }

  void _myToast(){
    Fluttertoast.showToast(
        msg: 'The Link You Have Provided Is Invalid',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 2,
        backgroundColor: Colors.amber,
        textColor: Colors.black
    );
  }

  void _myToast1(String data){
    Fluttertoast.showToast(
        msg: '$data',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 2,
        backgroundColor: Colors.amber,
        textColor: Colors.black
    );
  }

  Widget buildButtons(BuildContext context, hiveModel transaction) => Row(
    children: [
      Expanded(
        child: GFButton(
          onPressed: () => Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => hiveDialog(
                transaction: transaction,
                onClickedDone: (name, mPoster, mProduction ,isWatched) =>
                    editTransaction(transaction, name, mPoster,mProduction, isWatched),
              ),
            ),
          ),
          text: "Edit",
          textColor: Colors.amber,
          icon: Icon(Icons.edit,color: Colors.amber,),
          color: Colors.transparent,
          shape: GFButtonShape.standard,
        ),
      ),
      Expanded(
        child: GFButton(

          onPressed: Uri.tryParse(transaction.poster)?.hasAbsolutePath == true ? () async{
            dynamic url = transaction.poster.toString();
            if (await canLaunch(url)) {
            await launch(url);
            } else {
            throw 'Could not launch $url';
            }
          }:_myToast,
          text: "Poster",
          textColor: Colors.blue,
          icon: Icon(Icons.link,color: Colors.blue,),
          color: Colors.white,
          shape: GFButtonShape.standard,
        ),
      ),
      Expanded(
        child: GFButton(
          onPressed: () => deleteTransaction(transaction),
          text: "Delete",
          textColor: Colors.red,
          icon: Icon(Icons.delete,color: Colors.red,),
          color: Colors.transparent,
          shape: GFButtonShape.standard,
        ),
      )
    ],
  );



  Future addTransaction(String name, String mPoster, String mProduction,bool isWatched) async {
    final transaction = hiveModel()
      ..movieName = name
      ..poster = mPoster
      ..production = mProduction
      ..watched = isWatched;

    final box = Boxes.getModel();
    box.add(transaction);
    _myToast1("Data Added");
  }

  void editTransaction(hiveModel transaction, String name, String mPoster, String mProduction, bool isWatched,) {
    transaction.movieName = name;
    transaction.poster = mPoster;
    transaction.watched = isWatched;
    transaction.production = mProduction;

    transaction.save();
    _myToast1("Data Updated");
  }

  void deleteTransaction(hiveModel transaction) {
    transaction.delete();
    _myToast1("Data Removed");
  }

}