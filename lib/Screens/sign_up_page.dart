import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cryptoAppll/Constant/Colors.dart';
import 'package:cryptoAppll/Service/authentication_service.dart';
import 'package:cryptoAppll/Screens/coinscreen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SignUpPage extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController noController = TextEditingController();
  final TextEditingController adController = TextEditingController();
  final TextEditingController soyadController = TextEditingController();
  FirebaseFirestore  _firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colorsapp().backgroundcolor,
      body: Center(
        child: Column(
          children: [
            SizedBox(height: 150,),
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
                obscureText: true,

                decoration: InputDecoration(
                    hintText: "  Password",
                    hintStyle: TextStyle(color: Colors.grey)
                ),
              ),
            ),
            SizedBox(height: 20,),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                border: Border.all(
                    color: Colors.white, width: 1.25),
              ),
              child: TextField(
                style: TextStyle(color: Colors.white),

                controller: noController,
                decoration: InputDecoration(
                    hintText: "  Telefon Numarası",
                    hintStyle: TextStyle(color: Colors.grey)
                ),
              ),
            ),
            SizedBox(height: 20,),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                border: Border.all(
                    color: Colors.white, width: 1.25),
              ),
              child: TextField(
                style: TextStyle(color: Colors.white),

                controller: adController,
                decoration: InputDecoration(
                    hintText: "  Ad",
                    hintStyle: TextStyle(color: Colors.grey)
                ),
              ),
            ),
            SizedBox(height: 20,),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                border: Border.all(
                    color: Colors.white, width: 1.25),
              ),
              child: TextField(
                style: TextStyle(color: Colors.white),


                controller: soyadController,
                decoration: InputDecoration(
                    hintText: "  Soyad",
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
                  if(passwordController.text.length > 6 && emailController.text.contains("@") ) {
                    String value = await context.read<AuthenticationService>()
                        .signUp(
                      email: emailController.text.trim(),
                      password: passwordController.text.trim(),
                    );

                    await _firestore.collection("users").doc("$value")
                        .collection("contact").doc("contact")
                        .set({
                      "Ad": adController.text,
                      "Soyad": soyadController.text,
                      "no": noController.text
                    });
                    await _firestore.collection("users").doc("$value")
                        .collection("wallet").doc("dolar")
                        .set({"value": 150000});
                    await _firestore.collection("users").doc("$value")
                        .collection("wallet").doc("Bitcoin")
                        .set({"value": 0});
                    await _firestore.collection("users").doc("$value")
                        .collection("wallet").doc("Ethereum")
                        .set({"value": 0});
                    await _firestore.collection("users").doc("$value")
                        .collection("wallet").doc("Solana")
                        .set({"value": 0});
                    await _firestore.collection("users").doc("$value")
                        .collection("wallet").doc("Terra")
                        .set({"value": 0});
                    await _firestore.collection("users").doc("$value")
                        .collection("wallet").doc("BNB")
                        .set({"value": 0});
                    await _firestore.collection("users").doc("$value")
                        .collection("wallet").doc("Avalanche")
                        .set({"value": 0});
                    await _firestore.collection("users").doc("$value")
                        .collection("wallet").doc("XRP")
                        .set({"value": 0});
                    await _firestore.collection("users").doc("$value")
                        .collection("wallet").doc("USD Coin")
                        .set({"value": 0});
                    await _firestore.collection("users").doc("$value")
                        .collection("wallet").doc("Polkadot")
                        .set({"value": 0});
                    await _firestore.collection("users").doc("$value")
                        .collection("wallet").doc("Tether")
                        .set({"value": 0});
                    await _firestore.collection("users").doc("$value")
                        .collection("wallet").doc("Cardano")
                        .set({"value": 0});
                    await _firestore.collection("users").doc("$value")
                        .collection("wallet").doc("DogeCoin")
                        .set({"value": 0});
                    Navigator.push(context, MaterialPageRoute(
                        builder: (builder) => Coinvalue(Uid: value,)));
                  }
                },
                child: Text("Kayıt ol"),
              ),
            )
          ],
        ),
      ),
    );
  }
}
