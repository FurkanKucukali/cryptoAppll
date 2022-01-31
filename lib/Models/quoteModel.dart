
import 'package:cryptoAppll/Models/usdModel.dart';


class QuoteModel {
  final UsdModel usdModel;

  QuoteModel({
    this.usdModel,
  });
  factory QuoteModel.fromJson(Map<String, dynamic> json) {
    return QuoteModel(
      usdModel: UsdModel.fromJson(json["USD"]),
    );
  }
}