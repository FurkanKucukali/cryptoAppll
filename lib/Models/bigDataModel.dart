
import 'package:cryptoAppll/Models/dataModel.dart';
import 'package:cryptoAppll/Models/statusModel.dart';


class BigDataModel {
  final StatusModel statusModel;
  final List<DataModel> dataModel;

  BigDataModel({
    this.statusModel,
    this.dataModel,
  });

  factory BigDataModel.fromJson(Map<String, dynamic> json) {
    var dataList = json['data'] as List;
    List<DataModel> dataModelList = dataList.map((e) =>  DataModel.fromJson(e)).toList();
    return BigDataModel(
      statusModel: StatusModel.fromJson(json["status"]),
      dataModel: dataModelList,
    );
  }
}