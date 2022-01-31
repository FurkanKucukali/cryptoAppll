
import 'package:cryptoAppll/Models/dataModel.dart';
import 'package:cryptoAppll/repository/repository.dart';
import 'package:flutter/material.dart';

class CoinValueProvider with ChangeNotifier{
List<DataModel> _value;
List<DataModel> get coinValues => _value;

getvalue( ) async{

  await Repository().getCoin().then((value) {
    _value = value.dataModel;
    notifyListeners();
  });
}

}