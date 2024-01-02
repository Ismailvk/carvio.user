class CarModel {
  String id;
  String name;
  int price;
  int model;
  String transmission;
  String brand;
  String fuel;
  String location;
  Owner createdBy;
  List<String> images;
  bool isVerified;
  List<dynamic> review;
  int v;
  String document;

  CarModel({
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

  factory CarModel.fromJson(Map<String, dynamic> json) {
    return CarModel(
      id: json['_id'],
      name: json['name'],
      price: json['price'],
      model: json['model'],
      transmission: json['transmission'],
      brand: json['brand'],
      fuel: json['fuel'],
      location: json['location'],
      createdBy: Owner.fromJson(json['createdBy']),
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
      'createdBy': createdBy.toJson(),
      'images': images,
      'isVerified': isVerified,
      'review': review,
      '__v': v,
      'document': document,
    };
  }
}

class Owner {
  String id;
  String name;
  String email;
  int phone;
  String password;
  bool isBlocked;
  bool isVerified;
  int v;
  String? profile;

  Owner({
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

  factory Owner.fromJson(Map<String, dynamic> json) {
    return Owner(
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
