// Profile Model [image, name, email, phone, address, designation]
class ProfileModel {
  final String? image;
  final String? name;
  final String? email;
  final String? phone;
  final String? address;
  final String? designation;

  ProfileModel({
    this.image,
    this.name,
    this.email,
    this.phone,
    this.address,
    this.designation,
  });

  // convert toJson
  Map<String, dynamic> toJson() {
    return {
      'image': image,
      'name': name,
      'email': email,
      'phone': phone,
      'address': address,
      'designation': designation,
    };
  }

  // convert fromJson
  factory ProfileModel.fromJson(Map<dynamic, dynamic> json) {
    return ProfileModel(
      image: json['image'],
      name: json['name'],
      email: json['email'],
      phone: json['phone'],
      address: json['address'],
      designation: json['designation'],
    );
  }
}
