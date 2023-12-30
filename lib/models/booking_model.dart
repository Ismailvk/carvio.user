class BookingModel {
  String id;
  String userId;
  Vehicle vehicle;
  String startDate;
  String endDate;
  String pickup;
  String dropoff;
  double total;
  double grandTotal;
  String status;
  String razorId;
  int v;

  BookingModel({
    required this.id,
    required this.userId,
    required this.vehicle,
    required this.startDate,
    required this.endDate,
    required this.pickup,
    required this.dropoff,
    required this.total,
    required this.grandTotal,
    required this.status,
    required this.razorId,
    required this.v,
  });

  factory BookingModel.fromJson(Map<String, dynamic> json) {
    return BookingModel(
      id: json['_id'],
      userId: json['userId'],
      vehicle: Vehicle.fromJson(json['vehicleId']),
      startDate: json['startDate'],
      endDate: json['endDate'],
      pickup: json['pickup'],
      dropoff: json['dropoff'],
      total: json['total'].toDouble(),
      grandTotal: json['grandTotal'].toDouble(),
      status: json['status'],
      razorId: json['razorId'],
      v: json['__v'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'userId': userId,
      'vehicleId': vehicle.toJson(),
      'startDate': startDate,
      'endDate': endDate,
      'pickup': pickup,
      'dropoff': dropoff,
      'total': total,
      'grandTotal': grandTotal,
      'status': status,
      'razorId': razorId,
      '__v': v,
    };
  }
}

class Vehicle {
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
  List<dynamic> review;
  int v;
  String document;

  Vehicle({
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
  });

  factory Vehicle.fromJson(Map<String, dynamic> json) {
    return Vehicle(
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
      review: List<dynamic>.from(json['review']),
      v: json['__v'],
      document: json['document'],
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
    };
  }
}
