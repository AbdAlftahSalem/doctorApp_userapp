class LabModel {
  String address,
      city,
      country,
      id,
      name,
      image,
      lat,
      lang,
      phone,
      doctorId,
      detailImage;

  LabModel({
    required this.address,
    required this.city,
    required this.country,
    required this.id,
    required this.name,
    required this.image,
    required this.lat,
    required this.lang,
    required this.phone,
    required this.doctorId,
    required this.detailImage,
  });

  Map<String, dynamic> toMap() {
    return {
      'address': this.address,
      'city': this.city,
      'country': this.country,
      'id': this.id,
      'name': this.name,
      'image': this.image,
      'lat': this.lat,
      'lang': this.lang,
      'phone': this.phone,
      'doctorId': this.doctorId,
      'detailImage': this.detailImage,
    };
  }

  factory LabModel.fromMap(Map<String, dynamic> map) {
    return LabModel(
      address: map['address'] as String,
      city: map['city'] as String,
      country: map['country'] as String,
      id: map['id'] as String,
      name: map['name'] as String,
      image: map['iamge'] as String,
      lat: map['lat'] as String,
      lang: map['lang'] as String,
      phone: map['phone'] as String,
      doctorId: map['doctorId'] as String,
      detailImage: map['detailImage'] as String,
    );
  }
}
