import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/components/loader/gf_loader.dart';
import 'package:getwidget/types/gf_loader_type.dart';
import 'package:yellow_class/Screens/homepage.dart';
import 'package:yellow_class/models/googleSignin_provider.dart';
import 'package:provider/provider.dart';
import '../Widgets/SignUpWidget.dart';

class login extends StatelessWidget {
  const login({Key? key}) : super(key: key);

  Widget buildLoading() => Stack(
    fit: StackFit.expand,
    children: [
      Center(child:  GFLoader(
          type:GFLoaderType.ios
      ),),
    ],
  );

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: ChangeNotifierProvider(
          create: (context) =>GoogleSignInProvider(),
          child: StreamBuilder(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: (context,snapshot){
              final provider = Provider.of<GoogleSignInProvider>(context);
              if (provider.isSigningIn) {
                return buildLoading();
              } else if (snapshot.hasData) {
                return homepage();
              } else {
                return SignUpWidget();
              }
            },
          ),
        ),
      ),
    );
  }
}
