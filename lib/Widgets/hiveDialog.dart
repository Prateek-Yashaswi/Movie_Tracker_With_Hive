import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:getwidget/getwidget.dart';

import '../models/hive.dart';

class hiveDialog extends StatefulWidget {
  final hiveModel? transaction;
  final Function(String name, String production, String poster, bool watched) onClickedDone;

  const hiveDialog({
    Key? key,
    this.transaction,
    required this.onClickedDone,
  }) : super(key: key);

  @override
  _hiveDialogState createState() => _hiveDialogState();
}

class _hiveDialogState extends State<hiveDialog> {
  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final posterController = TextEditingController();
  final productionController = TextEditingController();

  bool isWatched = true;

  @override
  void initState() {
    super.initState();

    if (widget.transaction != null) {
      final transaction = widget.transaction!;

      nameController.text = transaction.movieName;
      posterController.text = transaction.poster;
      productionController.text = transaction.production;
      isWatched = transaction.watched;
    }
  }

  @override
  void dispose() {
    nameController.dispose();
    productionController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isEditing = widget.transaction != null;
    final title = isEditing ? 'Edit Entry' : 'Add An Entry';

    return Scaffold(
      appBar: GFAppBar(
        backgroundColor: Colors.amber,
        title: Text("Data Entry",style: TextStyle(color: Colors.black),),
        centerTitle: false,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Form(
            key: formKey,
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Center(child: Image.asset("assets/cinema.png")),
                  SizedBox(height: 8),
                  buildName(),
                  SizedBox(height: 8),
                  buildPoster(),
                  SizedBox(height: 8),
                  buildProduction(),
                  SizedBox(height: 8),
                  buildRadioButtons(),
                  buildAddButton(context, isEditing: isEditing),
                  buildCancelButton(context),
                ],

              ),
            ),
          ),
      ),
    );
  }

  Widget buildName() => TextFormField(
    controller: nameController,
    decoration: InputDecoration(
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
      hintText: 'Enter Name',
    ),
    validator: (name) =>
    name != null && name.isEmpty ? 'Enter The Movie Name' : null,
  );

  Widget buildPoster() => TextFormField(
    decoration: InputDecoration(
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
      hintText: 'Give Poster Link',
    ),
    validator: (name) =>
    name != null && name.isEmpty ? 'Provide A Poster Link' : null,
    controller: posterController,
  );

  Widget buildProduction() => TextFormField(
    decoration: InputDecoration(
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
      hintText: 'Enter Director',
    ),
    validator: (name) =>
    name != null && name.isEmpty ? 'Enter Director' : null,
    controller: productionController,
  );

  Widget buildRadioButtons() => Column(
    children: [
      RadioListTile<bool>(
        activeColor: Colors.amber,
        title: Text('Watched'),
        value: true,
        groupValue: isWatched,
        onChanged: (value) => setState(() => isWatched = value!),
      ),
      RadioListTile<bool>(
        activeColor: Colors.amber,
        title: Text('Not Watched'),
        value: false,
        groupValue: isWatched,
        onChanged: (value) => setState(() => isWatched = value!),
      ),
    ],
  );

  Widget buildCancelButton(BuildContext context) => GFButton(
    fullWidthButton: true,
    child: Text('Cancel'),
    color: Colors.red,
    onPressed: () => Navigator.of(context).pop(),
  );

  Widget buildAddButton(BuildContext context, {required bool isEditing}) {
    final text = isEditing ? 'Save' : 'Add';

    return GFButton(
      fullWidthButton: true,
      color: Colors.amber,
        textColor: Colors.black,
        onPressed: () async {
          final isValid = formKey.currentState!.validate();

          if (isValid) {
            final name = nameController.text;
            final production = productionController.text;
            final poster = posterController.text;

            widget.onClickedDone(name, poster, production,isWatched);

            Navigator.of(context).pop();
          }
        },
        text:text
    );
  }
}