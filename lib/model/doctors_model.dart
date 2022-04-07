class DoctorModel {
  String phoneNumber,
      address,
      typeDoctor,
      city,
      name,
      id,
      experience,
      lat,
      long,
      reviewsNumbers,
      image;

  DoctorModel({
    required this.phoneNumber,
    required this.address,
    required this.typeDoctor,
    required this.city,
    required this.name,
    required this.id,
    required this.experience,
    required this.lat,
    required this.long,
    required this.reviewsNumbers,
    required this.image,
  });

  Map<String, dynamic> toMap() {
    return {
      'phoneNumber': this.phoneNumber,
      'address': this.address,
      'typeDoctor': this.typeDoctor,
      'city': this.city,
      'name': this.name,
      'id': this.id,
      'experience': this.experience,
      'lat': this.lat,
      'long': this.long,
      'reviewsNumbers': this.reviewsNumbers,
      'image': this.image,
    };
  }

  factory DoctorModel.fromMap(Map<String, dynamic> map) {
    return DoctorModel(
      phoneNumber: map['phoneNumber'] as String,
      address: map['address'] as String,
      typeDoctor: map['typeDoctor'] as String,
      city: map['city'] as String,
      name: map['name'] as String,
      id: map['id'] as String,
      experience: map['experience'] as String,
      lat: map['lat'] as String,
      long: map['long'] as String,
      reviewsNumbers: map['reviewsNumbers'] as String,
      image: map['image'] as String,
    );
  }
}
