
import 'package:cryptoAppll/Models/dataModel.dart';


class DataModelID {
  final DataModel dataModel;

  DataModelID({
    this.dataModel,
  });

  factory DataModelID.fromJson(Map<String, dynamic> json) {
  return DataModelID(
    dataModel: json["1"]
  );
  }
  }