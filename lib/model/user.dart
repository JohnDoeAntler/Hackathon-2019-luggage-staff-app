class User {
  int id;
  String ticketId;
  int seatIndex;
  int airplaneClassId;
  int flightId;
  String createdAt;
  String updatedAt;

  User({
    this.id,
    this.ticketId,
    this.seatIndex,
    this.airplaneClassId,
    this.flightId,
    this.createdAt,
    this.updatedAt
  });

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    ticketId = json['ticket_id'];
    seatIndex = json['seat_index'];
    airplaneClassId = json['airplane_class_id'];
    flightId = json['flight_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['ticket_id'] = this.ticketId;
    data['seat_index'] = this.seatIndex;
    data['airplane_class_id'] = this.airplaneClassId;
    data['flight_id'] = this.flightId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}