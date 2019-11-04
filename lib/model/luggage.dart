class Luggage {
  int id;
  int userId;
  double length;
  double width;
  double height;
  String imageUrl;
  int spaceIndex;
  String createdAt;
  String updatedAt;

  Luggage(
      {this.id,
      this.userId,
      this.length,
      this.width,
      this.height,
      this.imageUrl,
      this.spaceIndex,
      this.createdAt,
      this.updatedAt});

  Luggage.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    length = double.parse(json['length']);
    width = double.parse(json['width']);
    height = double.parse(json['height']);
    imageUrl = json['image_url'];
    spaceIndex = json['space_index'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['length'] = this.length;
    data['width'] = this.width;
    data['height'] = this.height;
    data['image_url'] = this.imageUrl;
    data['space_index'] = this.spaceIndex;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}