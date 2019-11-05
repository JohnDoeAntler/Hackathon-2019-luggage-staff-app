class PurchaseLog {
  int id;
  int userId;
  int storeId;
  double spaceIncreasement;
  String createdAt;
  String updatedAt;

  PurchaseLog(
      {this.id,
      this.userId,
      this.storeId,
      this.spaceIncreasement,
      this.createdAt,
      this.updatedAt});

  PurchaseLog.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    storeId = json['store_id'];
    spaceIncreasement = double.parse(json['space_increasement']);
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['store_id'] = this.storeId;
    data['space_increasement'] = this.spaceIncreasement;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}