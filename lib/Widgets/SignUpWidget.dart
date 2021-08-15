import 'package:flutter/material.dart';
import 'package:getwidget/components/image/gf_image_overlay.dart';
import 'google_signup_button_widget.dart';

class SignUpWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Stack(
    fit: StackFit.expand,
    children: [
      buildSignUp(),
    ],
  );

  Widget buildSignUp() => Column(
    children: [
      Spacer(),
      Align(
        alignment: Alignment.centerLeft,
        child: Center(
          child: Column(
            children: [
              Container(
                child: Text(
                  'Yellow Class Assignment',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(height: 30,),
              Padding(
                padding: const EdgeInsets.only(top:28.0),
                child: Container(
                  alignment: Alignment.center,
                  child: Image(
                    image: AssetImage(
                      'assets/login.png',),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      Spacer(),
      GoogleSignupButtonWidget(),
      SizedBox(height: 12),
      Text(
        'Login to continue',
        style: TextStyle(fontSize: 16),
      ),
      Spacer(),
    ],
  );
}