import 'package:cryptoAppll/Constant/Colors.dart';
import 'package:cryptoAppll/Service/authentication_service.dart';
import 'package:cryptoAppll/Screens/sign_up_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SignInPage extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colorsapp().backgroundcolor,
      body: Center(
        child: Column(
          children: [
            SizedBox(height: 200,),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                border: Border.all(
                    color: Colors.white, width: 1.25),
              ),
              child: TextField(
                style: TextStyle(color: Colors.white),

                controller: emailController,
                decoration: InputDecoration(
                    hintText: "  Email",
                    hintStyle: TextStyle(color: Colors.grey)
                ),
              ),
            ),
            SizedBox(height: 25,),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                border: Border.all(
                    color: Colors.white, width: 1.25),
              ),
              child: TextField(
                style: TextStyle(color: Colors.white),
                controller: passwordController,
                decoration: InputDecoration(
                  hintText: "  Password",
                  hintStyle: TextStyle(color: Colors.grey)
                ),
              ),
            ),
            SizedBox(height: 20,),
            Container(
              width: 120,
              height: 40,


              child: RaisedButton(
                color: Colors.grey.shade300,
                elevation: 2,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),

                onPressed: () async {
                   context.read<AuthenticationService>().signIn(
                        email: emailController.text.trim(),
                        password: passwordController.text.trim(),
                      );


                },
                child: Text("Sign in"),
              ),
            ), SizedBox(height: 20,),
            Container(
              width: 120,
              height: 40,


              child: RaisedButton(
                color: Colors.grey.shade300,
                elevation: 2,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),

                onPressed: () async {
                  Navigator.push(context, MaterialPageRoute(builder: (builder) => SignUpPage()));


                },
                child: Text("Sign up"),
              ),
            )
          ],
        ),
      ),
    );
  }
}
