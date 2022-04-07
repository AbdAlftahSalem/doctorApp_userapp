class LastMessageModel {
  String dateTime,
      senderId,
      profileImageSender,
      nameReceiver,
      receiverId,
      read,
      idMessage,
      nameSender,
      profileImageReceiver,
      content,
      address,
      city,
      experience,
      lat,
      long,
      phoneNumber,
      typeDoctor;

  int index;

  LastMessageModel(
      {required this.dateTime,
      required this.senderId,
      required this.profileImageSender,
      required this.nameReceiver,
      required this.receiverId,
      required this.read,
      required this.idMessage,
      required this.nameSender,
      required this.profileImageReceiver,
      required this.content,
      required this.address,
      required this.city,
      required this.experience,
      required this.lat,
      required this.long,
      required this.phoneNumber,
      required this.typeDoctor,
      required this.index});

  Map<String, dynamic> toMap() {
    return {
      'dateTime': this.dateTime,
      'senderId': this.senderId,
      'profileImageSender': this.profileImageSender,
      'nameReceiver': this.nameReceiver,
      'receiverId': this.receiverId,
      'read': this.read,
      'idMessage': this.idMessage,
      'nameSender': this.nameSender,
      'profileImageReceiver': this.profileImageReceiver,
      'content': this.content,
      'address': this.address,
      'city': this.city,
      'experience': this.experience,
      'lat': this.lat,
      'long': this.long,
      'phoneNumber': this.phoneNumber,
      'typeDoctor': this.typeDoctor,
      'index': this.index,
    };
  }

  factory LastMessageModel.fromMap(Map<String, dynamic> map) {
    return LastMessageModel(
      dateTime: map['dateTime'] as String,
      senderId: map['senderId'] as String,
      profileImageSender: map['profileImageSender'] as String,
      nameReceiver: map['nameReceiver'] as String,
      receiverId: map['receiverId'] as String,
      read: map['read'] as String,
      idMessage: map['idMessage'] as String,
      nameSender: map['nameSender'] as String,
      profileImageReceiver: map['profileImageReceiver'] as String,
      content: map['content'] as String,
      address: map['address'] as String,
      city: map['city'] as String,
      experience: map['experience'] as String,
      lat: map['lat'] as String,
      long: map['long'] as String,
      phoneNumber: map['phoneNumber'] as String,
      typeDoctor: map['typeDoctor'] as String,
      index: map['index'] as int,
    );
  }
}
