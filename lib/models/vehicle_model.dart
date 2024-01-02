class HostDetails {
  String id;
  String name;
  String email;
  int phone;
  String password;
  bool isBlocked;
  bool isVerified;
  int v;
  String? profile;

  HostDetails({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.password,
    required this.isBlocked,
    required this.isVerified,
    required this.v,
    this.profile,
  });

  factory HostDetails.fromJson(Map<String, dynamic> json) {
    return HostDetails(
      id: json['_id'],
      name: json['name'],
      email: json['email'],
      phone: json['phone'],
      password: json['password'],
      isBlocked: json['isBlocked'],
      isVerified: json['isVerified'],
      v: json['__v'],
      profile: json['profile'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'name': name,
      'email': email,
      'phone': phone,
      'password': password,
      'isBlocked': isBlocked,
      'isVerified': isVerified,
      '__v': v,
      'profile': profile,
    };
  }
}

class VehicleModel {
  String id;
  String name;
  double price;
  int model;
  String transmission;
  String brand;
  String fuel;
  String location;
  String createdBy;
  List<String> images;
  bool isVerified;
  List<String> review;
  int v;
  String document;
  List<Booking> bookings; // Add bookings field
  HostDetails hostDetails;

  VehicleModel({
    required this.id,
    required this.name,
    required this.price,
    required this.model,
    required this.transmission,
    required this.brand,
    required this.fuel,
    required this.location,
    required this.createdBy,
    required this.images,
    required this.isVerified,
    required this.review,
    required this.v,
    required this.document,
    required this.bookings,
    required this.hostDetails,
  });

  factory VehicleModel.fromJson(Map<String, dynamic> json) {
    return VehicleModel(
      id: json['_id'],
      name: json['name'],
      price: json['price'].toDouble(),
      model: json['model'],
      transmission: json['transmission'],
      brand: json['brand'],
      fuel: json['fuel'],
      location: json['location'],
      createdBy: json['createdBy'],
      images: List<String>.from(json['images']),
      isVerified: json['isVerified'],
      review: List<String>.from(json['review']),
      v: json['__v'],
      document: json['document'],
      bookings: List<Booking>.from(
          json['bookings'].map((booking) => Booking.fromJson(booking))),
      hostDetails: HostDetails.fromJson(json['hostDetails'][0]),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'name': name,
      'price': price,
      'model': model,
      'transmission': transmission,
      'brand': brand,
      'fuel': fuel,
      'location': location,
      'createdBy': createdBy,
      'images': images,
      'isVerified': isVerified,
      'review': review,
      '__v': v,
      'document': document,
      'bookings': bookings.map((booking) => booking.toJson()).toList(),
      'hostDetails': hostDetails.toJson(),
    };
  }
}

class Booking {
  String id;
  String userId;
  String vehicleId;
  String startDate;
  String endDate;
  String pickup;
  String dropoff;
  double total;
  double grandTotal;
  String status;
  int v;

  Booking({
    required this.id,
    required this.userId,
    required this.vehicleId,
    required this.startDate,
    required this.endDate,
    required this.pickup,
    required this.dropoff,
    required this.total,
    required this.grandTotal,
    required this.status,
    required this.v,
  });

  factory Booking.fromJson(Map<String, dynamic> json) {
    return Booking(
      id: json['_id'],
      userId: json['userId'],
      vehicleId: json['vehicleId'],
      startDate: json['startDate'],
      endDate: json['endDate'],
      pickup: json['pickup'],
      dropoff: json['dropoff'],
      total: json['total'].toDouble(),
      grandTotal: json['grandTotal'].toDouble(),
      status: json['status'],
      v: json['__v'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'userId': userId,
      'vehicleId': vehicleId,
      'startDate': startDate,
      'endDate': endDate,
      'pickup': pickup,
      'dropoff': dropoff,
      'total': total,
      'grandTotal': grandTotal,
      'status': status,
      '__v': v,
    };
  }
}
