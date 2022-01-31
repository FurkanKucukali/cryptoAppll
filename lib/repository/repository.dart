import 'dart:core';

import 'dart:convert';

import 'package:cryptoAppll/Models/bigDataModel.dart';
import 'package:http/http.dart' as http;
class Repository{
  var url = "https://pro-api.coinmarketcap.com/v1/cryptocurrency/listings/latest";
  final apikey = "90e80c55-50a8-428c-830b-4bb9eac6589b";


  Future<BigDataModel> getCoin() async{

    var  response = await http.get(Uri.parse(url),headers: {
      'X-CMC_PRO_API_KEY':'$apikey'
    });
    var decodedData = BigDataModel.fromJson(jsonDecode(response.body));
    return decodedData;

   // print(decodedData.dataModel.first.name.toString());

  }


}