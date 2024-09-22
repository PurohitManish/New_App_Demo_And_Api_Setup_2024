class AddCategoryResponse {
  String? message;
  Result? result;

  AddCategoryResponse({this.message, this.result});

  AddCategoryResponse.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    result =
        json['result'] != null ? new Result.fromJson(json['result']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    if (this.result != null) {
      data['result'] = this.result!.toJson();
    }
    return data;
  }
}

class Result {
  String? category;
  int? status;
  String? userId;
  String? sId;
  String? createdAt;
  String? updatedAt;
  int? iV;

  Result(
      {this.category,
      this.status,
      this.userId,
      this.sId,
      this.createdAt,
      this.updatedAt,
      this.iV});

  Result.fromJson(Map<String, dynamic> json) {
    category = json['category'];
    status = json['status'];
    userId = json['userId'];
    sId = json['_id'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['category'] = this.category;
    data['status'] = this.status;
    data['userId'] = this.userId;
    data['_id'] = this.sId;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    return data;
  }
}
