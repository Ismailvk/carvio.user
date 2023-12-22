class UserModel {
  String id;
  String name;
  String email;
  int phone;
  bool isBlocked;
  String? profile;
  int? wallet;
  int v;
  Choices? choices;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.isBlocked,
    this.profile,
    this.wallet,
    required this.v,
    this.choices,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['_id'],
      name: json['name'],
      email: json['email'],
      phone: json['phone'],
      isBlocked: json['isBlocked'],
      profile: json['profile'],
      wallet: json['wallet'],
      v: json['__v'],
      choices: Choices.fromJson(json['choices']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'name': name,
      'email': email,
      'phone': phone,
      'isBlocked': isBlocked,
      'profile': profile,
      'wallet': wallet,
      '__v': v,
      'choices': choices!.toJson(),
    };
  }
}

class Choices {
  String startDate;
  String endDate;
  String pickup;
  String dropoff;

  Choices({
    required this.startDate,
    required this.endDate,
    required this.pickup,
    required this.dropoff,
  });

  static Choices? fromJson(Map<String, dynamic>? json) {
    if (json == null) return null;
    return Choices(
      startDate: json['startDate'] ?? '',
      endDate: json['endDate'] ?? '',
      pickup: json['pickup'] ?? '',
      dropoff: json['dropoff'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'startDate': startDate,
      'endDate': endDate,
      'pickup': pickup,
      'dropoff': dropoff,
    };
  }
}
