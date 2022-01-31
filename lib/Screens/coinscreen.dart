import 'dart:async';
import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cryptoAppll/Constant/Colors.dart';
import 'package:cryptoAppll/Models/dataModel.dart';
import 'package:cryptoAppll/Provider/coinvalue.dart';
import 'package:cryptoAppll/Screens/sign_in_page.dart';
import 'package:cryptoAppll/Service/authentication_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fl_chart/fl_chart.dart';

class Coinvalue extends StatefulWidget {
  const Coinvalue({Key key, this.Uid}) : super(key: key);

  final Uid;

  @override
  _CoinvalueState createState() => _CoinvalueState();
}

int _bottomindex = 0;

class _CoinvalueState extends State<Coinvalue> {
  TextEditingController quantitycontroller = TextEditingController();
  var dropdownValue = "Bitcoin";
  var walletValue ;
  var walletdolar;
  var contactvalue;
  List<String> coins = <String>[
    "Bitcoin",
    "Ethereum",
    "Tether",
    "BNB",
    "USD Coin",
    "Cardano",
    "XRP",
    "Solana",
    "Terra",
    "DogeCoin",
    "Polkadot",
    "Avalanche"
  ];
  List<String> coinsIcons = <String>[
    "assets/icons/Bitcoin.png",
    "assets/icons/Ethereum.png",
    "assets/icons/Tether.png",
    "assets/icons/BNB.png",
    "assets/icons/USDCoin.png",
    "assets/icons/Cardano.png",
    "assets/icons/XRP.png",
    "assets/icons/Solana.png",
    "assets/icons/Terra.png",
    "assets/icons/DogeCoin.png",
    "assets/icons/Polkadot.png",
    "assets/icons/Avalanche.png"
  ];
  FirebaseFirestore  _firestore = FirebaseFirestore.instance;
  @override

  void initState() {
     values();
     profile();
    // TODO: implement initState

    super.initState();

    //Apiye göre 1 dk da bir değişiyor
    Timer.periodic(Duration(minutes: 1), (timer) {
      setState(() {
        print("timer");
      });
    });
  }

  Future<void> values() async {
     walletValue = await _firestore.collection("users").doc(widget.Uid).collection("wallet").doc("${dropdownValue}").get().then((value) =>  value.data()["value"]);
    walletdolar = await _firestore.collection("users").doc(widget.Uid).collection("wallet").doc("dolar").get().then((value) => value.data()["value"]);
    walletdolar = (double.parse(walletdolar.toString()).toStringAsFixed(2)).toString();
    setState(() {

    });
  }

  @override
  void dispose() {
    _bottomindex = 0;
    // TODO: implement dispose
    super.dispose();
    Timer.periodic(Duration(minutes: 1), (timer) {
      setState(() {
        print("timer");
      });
    }).cancel();
  }


  @override
  Widget build(BuildContext context) {
    Provider.of<CoinValueProvider>(context, listen: false).getvalue();
    return Consumer<CoinValueProvider>(builder: (context, value, child) {
     return value != null ?
       Scaffold(

         resizeToAvoidBottomInset: false,
          backgroundColor: Colorsapp().backgroundcolor,
          bottomNavigationBar: buildBottomNavigationBar(),
          body: SafeArea(
                child:_bottomindex == 0?walletBuySell(value):_bottomindex==1?valueList(context,value):profileInfo(context))):CircularProgressIndicator();
    });
  }
  Widget profileInfo(BuildContext context){
   return Column(
     children: [
       SizedBox(height: 20,),
       Icon(Icons.person,color: Colors.grey,size: 100,),
       Center(
         child: Column(
           children: [
             Text("Profile",style: TextStyle(color: Colors.white,fontSize: 25),),
             SizedBox(height: 50,),
             Row(mainAxisAlignment: MainAxisAlignment.center,children: [ Text("Ad: ",style: TextStyle(color: Colors.white,fontSize: 25),), Text("${contactvalue["Ad"]}",style: TextStyle(color: Colors.grey.shade200,fontSize: 25),),]),
             SizedBox(height: 20,),
             Row(mainAxisAlignment: MainAxisAlignment.center,children: [ Text("Soyad: ",style: TextStyle(color: Colors.white,fontSize: 25),), Text("${contactvalue["Soyad"]}",style: TextStyle(color: Colors.grey.shade200,fontSize: 25),),]),
             SizedBox(height: 20,),
             Row(mainAxisAlignment: MainAxisAlignment.center,children: [ Text("No: ",style: TextStyle(color: Colors.white,fontSize: 25),), Text(" ${contactvalue["no"]}",style: TextStyle(color: Colors.grey.shade200,fontSize: 25),),]),
             SizedBox(height: 25,),
             Row(mainAxisAlignment: MainAxisAlignment.center,children: [ Text("Dolar: ",style: TextStyle(color: Colors.white,fontSize: 25),), Text(" ${walletdolar} ",style: TextStyle(color: Colors.grey.shade200,fontSize: 25),),]),

           ],
         ),
       ),
       SizedBox(height: 35,),
       Container(
         height: 50,
         width: 200,
         child: RaisedButton(child: Text("Oturum Kapat"),onPressed: ()  {
           FirebaseAuth.instance.signOut();
           setState(() {});
         },color :Colors.grey.shade100),
       )
     ],
   );
  }
  Widget valueList(BuildContext context,CoinValueProvider value){
    return ListView.builder(itemCount: coins.length,itemBuilder: (context,i){
      print(value.coinValues.elementAt(i).name);
      return ListTile(
        leading: Image.asset(coinsIcons[i],width: 30,),
        trailing: Text("${value.coinValues.elementAt(i).quoteModel.usdModel.price.toStringAsFixed(3)}",style: TextStyle(color:Colors.white,fontSize: 17),),
        title: Text(coins[i],style: TextStyle(color: Colors.white,fontSize: 22),),
        onTap: (){

        },
      );
    }
    );

  }

   Column walletBuySell(CoinValueProvider value)  {
    return  Column(
          children: [
            SizedBox(
              height: 100,
            ),
            DropdownButton<String>(
                icon: Icon(
                  Icons.keyboard_arrow_down,
                  color: Colors.blue,
                ),
                value: dropdownValue,
                dropdownColor: Colorsapp().backgroundcolor,
                style: TextStyle(color: Colors.white),
                onChanged: (String newValue) async {
                  setState(() {
                    dropdownValue = newValue;
                  });
                  await values();
                },
                items: coins.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(
                      value,
                      style: TextStyle(fontSize: 25),
                    ),
                  );
                }).toList()),
            // myWalletpart(),

            SizedBox(
              height: 25,
            ),

            // Container(width: MediaQuery.of(context).size.width*0.95,height: MediaQuery.of(context).size.height*0.4,
            // child: LineChart(
            //   LineChartData(
            //     minY: 0,
            //     maxY: 100000,
            //     minX: 0,
            //     maxX: 12,
            //
            //
            //     titlesData: FlTitlesData(show: true,
            //         rightTitles: SideTitles(),
            //         leftTitles: SideTitles(showTitles: true,reservedSize: 30,getTextStyles: (context,value){return TextStyle(color: Colors.white);}),
            //         topTitles: SideTitles(interval: 12,margin: 0,),bottomTitles: SideTitles(
            //
            //       getTextStyles: (context,double value){
            //         return TextStyle(color: Colors.white);
            //       },
            //
            //       showTitles: true,
            //       margin: 12,
            //         interval: 1,
            //       getTitles: (value){
            //         switch(value.toInt()){
            //           case 1:
            //             return 'JA';
            //           case 2:
            //             return 'FE';
            //           case 3 :
            //             return 'MA';
            //           case 4:
            //             return 'AP';
            //           case 5:
            //             return 'MA';
            //           case 6 :
            //             return 'JUL';
            //           case 7:
            //             return 'JU';
            //           case 8:
            //             return 'AU';
            //           case 9 :
            //             return 'SE';
            //           case 10:
            //             return 'DE';
            //           case 11:
            //             return 'NO';
            //           case 12 :
            //             return 'OC';
            //         }
            //         return '';
            //       }
            //     )),
            //     lineBarsData: [
            //       LineChartBarData(
            //         isCurved: false,
            //         barWidth: 1,
            //
            //         spots: [
            //
            //           FlSpot(1, 25000),
            //           FlSpot(2, 35000),
            //           FlSpot(3, 32000),
            //           FlSpot(4, 10000),
            //           FlSpot(5, 25000),
            //           FlSpot(6, 35000),
            //           FlSpot(7, 32000),
            //           FlSpot(8, 10000),
            //           FlSpot(9, 25000),
            //           FlSpot(10, 80000),
            //           FlSpot(11, 43000),
            //           FlSpot(12, value.coinValues.first.quoteModel.usdModel.price),
            //
            //         ]
            //       )
            //     ]
            //   )
            // ),),

            Center(
                child: Text(
              "ŞUAN Kİ DEĞERİ",
              style: TextStyle(
                  fontSize: 13, color: Color.fromRGBO(124, 141, 180, 1)),
            )),
            SizedBox(
              height: 8,
            ),

            Text(
              "${getCoinsvalue(value.coinValues) ?? "0"}",
              style: TextStyle(fontSize: 22, color: Colors.white),
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.only(right: 35),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text("24 sa Değişim",
                      style: TextStyle(
                          fontSize: 13,
                          color: Color.fromRGBO(124, 141, 180, 1))),
                  Text(
                    "24 sa Hacim",
                    style: TextStyle(
                        fontSize: 13, color: Color.fromRGBO(124, 141, 180, 1)),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 8,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  "${getCoins24hvalue(value.coinValues) ?? "0"}",
                  style: TextStyle(
                      fontSize: 22,
                      color: getCoins24hvalue(value.coinValues)
                                  .toString()
                                  .split("")
                                  .first ==
                              "-"
                          ? Colors.red
                          :Colors.green ),
                ),
                Text(
                  "${getCoinsVolumevalue(value.coinValues).split(".").first.split("").length > 6 ? getCoinsVolumevalue(value.coinValues).split(".").first.split("").reversed.join().substring(6).split("").reversed.join() + " milyon" : ""}",
                  style: TextStyle(fontSize: 22, color: Colors.white),
                )
              ],
            ),
            SizedBox(
              height: 50,
            ),
            Padding(
              padding: const EdgeInsets.only(right: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    " ${dropdownValue}  ",
                    style: TextStyle(color: Colors.grey,fontSize: 20,),
                  ),
                  Text(
                    "  USD ",
                    style: TextStyle(color: Colors.grey,fontSize: 20),
                  ),
                ],
              ),
            ),
            Divider(height: 2,color: Colors.white,thickness: 1,indent: 50,endIndent: 50,),

            SizedBox(height: 10,),
            Padding(
              padding: const EdgeInsets.only(right: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    " ${walletValue??0} ",
                    style: TextStyle(color: Colors.white,fontSize: 25),
                  ),
                  Text(
                    " $walletdolar ",
                    style: TextStyle(color: Colors.white,fontSize: 25),
                  ),
                ],
              ),
            ),


            SizedBox(
              height: 15,
            ),
            Container(
              width: 150,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                border: Border.all(
                    color: Colors.white, width: 1.25),
              ),
              child: TextField(
                controller: quantitycontroller,

                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                    hintText: "  Miktar",
                    hintStyle: TextStyle(color: Colors.grey)
                ),
              ),
            ),
            SizedBox(height: 10,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                RaisedButton(

                  color: Colors.red,
                  onPressed: () async {

                    var negatiote =  getCoinsvalue(value.coinValues);

                    walletdolar = await _firestore.collection("users").doc(widget.Uid).collection("wallet").doc("dolar").get().then((value) => value.data()["value"]);
                    walletValue = await _firestore.collection("users").doc(widget.Uid).collection("wallet").doc("${dropdownValue}").get().then((value) => value.data()["value"]);
                  if((walletValue-(double.parse(quantitycontroller.text)))>=0){
                    walletdolar = walletdolar +  (negatiote*(double.parse(quantitycontroller.text)));
                    walletValue = walletValue -(double.parse(quantitycontroller.text)) ;
                    await _firestore.collection("users").doc(widget.Uid).collection("wallet").doc("${dropdownValue}").set({"value":walletValue});
                    await _firestore.collection("users").doc(widget.Uid).collection("wallet").doc("dolar").set({"value":walletdolar});
                    setState(() {

                      walletdolar = (double.parse(walletdolar.toString()).toStringAsFixed(2)).toString();
                    });
                  }
                  else{
                    print("yetersiz miktar");
                  }
                  quantitycontroller.text = "";
                  },
                  child: Text("SAT"),
                ),
                RaisedButton(
                  color: Colors.green,
                  onPressed: () async {
                    double positivity =  getCoinsvalue(value.coinValues);
                    walletdolar = await _firestore.collection("users").doc(widget.Uid).collection("wallet").doc("dolar").get().then((value) => value.data()["value"]);
                    walletValue = await _firestore.collection("users").doc(widget.Uid).collection("wallet").doc("${dropdownValue}").get().then((value) => value.data()["value"]);
                    if(walletdolar - positivity*(double.parse(quantitycontroller.text))>=0){
                      walletdolar = walletdolar -  (positivity*double.parse(quantitycontroller.text));
                      walletValue = walletValue +double.parse(quantitycontroller.text) ;

                      await _firestore.collection("users").doc(widget.Uid).collection("wallet").doc("${dropdownValue}").set({"value":walletValue});
                      await _firestore.collection("users").doc(widget.Uid).collection("wallet").doc("dolar").set({"value":walletdolar});

                      setState(() {
                        
                        walletdolar = (double.parse(walletdolar.toString()).toStringAsFixed(2)).toString();
                        quantitycontroller.text = "";
                      });
                    }
                    else{
                      print("yetersiz");
                    }



                  },
                  child: Text("AL"),
                )
              ],
            )
          ],
        );
  }

  double getCoinsvalue(List<DataModel> value) {
    int index = 0;
    String coin = "";


    value.forEach((element) {
      if (element.name == dropdownValue) {
        coin =
            value.elementAt(index).quoteModel.usdModel.price.toStringAsFixed(3);
      }
      index++;
    });

    return double.parse(coin);
  }

  String getCoinsVolumevalue(List<DataModel> value) {
    int index = 0;
    String coin;

    value.forEach((element) {
      if (element.name == dropdownValue) {
        coin = value
            .elementAt(index)
            .quoteModel
            .usdModel
            .volume24h
            .toStringAsFixed(4);
      }
      index++;
    });
    return coin;
  }

  String getCoins24hvalue(List<DataModel> value) {
    int index = 0;
    String coin;

    value.forEach((element) {
      if (element.name == dropdownValue) {
        coin = value
            .elementAt(index)
            .quoteModel
            .usdModel
            .percentChange24h
            .toStringAsFixed(3);
      }
      index++;
    });
    return coin;
  }

  Padding myWalletpart() {
    return Padding(
      padding: const EdgeInsets.only(left: 160),
      child: Row(
        children: [
          Text(
            "My wallet",
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
            ),
          ),
          SizedBox(
            width: 60,
          ),
          GestureDetector(
            onTap: () {},
            child: Container(
              height: 40,
              width: 40,
              decoration: BoxDecoration(
                  color: Color.fromRGBO(56, 53, 123, 1),
                  borderRadius: BorderRadius.circular(100)),
              child: Icon(
                Icons.add,
                color: Color.fromRGBO(154, 174, 216, 1),
              ),
            ),
          )
        ],
      ),
    );
  }

  BottomNavigationBar buildBottomNavigationBar() {
    return BottomNavigationBar(
      selectedItemColor: Color.fromRGBO(218, 218, 218, 1),
      unselectedItemColor: Color.fromRGBO(106, 118, 159, 1),
      backgroundColor: Color.fromRGBO(21, 20, 72, 1),
      iconSize: 27,
      showSelectedLabels: false,
      currentIndex: _bottomindex,
      showUnselectedLabels: false,
      onTap: (value) {
        _bottomindex = value;
        setState(() {});
      },
      items: [
        BottomNavigationBarItem(
            label: "", icon: Icon(Icons.account_balance_wallet_outlined)),
        BottomNavigationBarItem(label: "", icon: Icon(Icons.bar_chart)),
        BottomNavigationBarItem(
            label: "", icon: Icon(Icons.account_circle_outlined)),
      ],
    );
  }
  profile()  {

    _firestore.collection("users").doc(widget.Uid).collection("contact").doc("contact").get().then((valuex) {
      setState(()  async {
        contactvalue =  await valuex.data();

      });

    } );

  }


}

