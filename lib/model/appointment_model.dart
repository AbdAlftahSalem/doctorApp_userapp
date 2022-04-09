class AppointmentModel {
  String date,
      doctorName,
      doctorType,
      doctorExp,
      time,
      doctorImage,
      id,
      idDoctor;

  AppointmentModel({
    required this.date,
    required this.doctorName,
    required this.doctorType,
    required this.doctorExp,
    required this.time,
    required this.doctorImage,
    required this.id,
    required this.idDoctor,
  });

  Map<String, dynamic> toMap() {
    return {
      'date': this.date,
      'doctorName': this.doctorName,
      'doctorType': this.doctorType,
      'doctorExp': this.doctorExp,
      'time': this.time,
      'doctorImage': this.doctorImage,
      'id': this.id,
      'idDoctor': this.idDoctor,
    };
  }

  factory AppointmentModel.fromMap(Map<String, dynamic> map) {
    return AppointmentModel(
      date: map['date'] as String,
      doctorName: map['doctorName'] as String,
      doctorType: map['doctorType'] as String,
      doctorExp: map['doctorExp'] as String,
      time: map['time'] as String,
      doctorImage: map['doctorImage'] as String,
      id: map['id'] as String,
      idDoctor: map['idDoctor'] as String,
    );
  }
}
