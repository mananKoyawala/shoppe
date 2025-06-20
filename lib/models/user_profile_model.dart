class UserProfileModel {
  final String id;
  final String first_name;
  final String last_name;
  final String full_name;
  final String image_url;
  final String gender;
  final String country;
  final String state;
  final String city;
  final String address;
  final String email;
  final String phone_number;
  final String dob;
  final String pin_code;
  final bool is_mobile_verified;
  final bool is_email_verified;
  final String access_token;

  UserProfileModel({
    required this.id,
    required this.first_name,
    required this.last_name,
    required this.full_name,
    required this.image_url,
    required this.gender,
    required this.country,
    required this.state,
    required this.city,
    required this.address,
    required this.email,
    required this.phone_number,
    required this.dob,
    required this.pin_code,
    required this.is_mobile_verified,
    required this.is_email_verified,
    required this.access_token,
  });

  factory UserProfileModel.fromJson(Map<String, dynamic> json) {
    return UserProfileModel(
      id: json['id'] ?? '',
      first_name: json['first_name'] ?? '',
      last_name: json['last_name'] ?? '',
      full_name: json['full_name'] ?? '',
      image_url: json['image_url'] ?? '',
      gender: json['gender'] ?? '',
      country: json['country'] ?? '',
      state: json['state'] ?? '',
      city: json['city'] ?? '',
      address: json['address'] ?? '',
      email: json['email'] ?? '',
      phone_number: json['phone_number'] ?? '',
      dob: json['dob'] ?? '',
      pin_code: json['pin_code'] ?? '',
      is_mobile_verified: json['is_mobile_verified'] ?? false,
      is_email_verified: json['is_email_verified'] ?? false,
      access_token: json['access_token'] ?? '',
    );
  }
}
