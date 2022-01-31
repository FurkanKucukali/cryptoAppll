class StatusModel {
  String timestamp;
  int errorCode;
  String errorMessage;
  int elapsed;
  int creditCount;
  String notice;

  StatusModel(String error, 
      {this.timestamp,
        this.errorCode,
        this.errorMessage,
        this.elapsed,
        this.creditCount,
        this.notice});

  StatusModel.fromJson(Map<String, dynamic> json) {
    timestamp = json['timestamp'];
    errorCode = json['error_code'];
    errorMessage = json['error_message'];
    elapsed = json['elapsed'];
    creditCount = json['credit_count'];
    notice = json['notice'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['timestamp'] = this.timestamp;
    data['error_code'] = this.errorCode;
    data['error_message'] = this.errorMessage;
    data['elapsed'] = this.elapsed;
    data['credit_count'] = this.creditCount;
    data['notice'] = this.notice;
    return data;
  }
}
