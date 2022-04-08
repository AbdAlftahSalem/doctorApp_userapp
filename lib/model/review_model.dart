class ReviewModel {
  String date, image, pain, numberStar, name, id, content;

  ReviewModel({
    required this.date,
    required this.image,
    required this.pain,
    required this.numberStar,
    required this.name,
    required this.id,
    required this.content,
  });

  Map<String, dynamic> toMap() {
    return {
      'date': this.date,
      'image': this.image,
      'pain': this.pain,
      'numberStar': this.numberStar,
      'name': this.name,
      'id': this.id,
      'content': this.content,
    };
  }

  factory ReviewModel.fromMap(Map<String, dynamic> map) {
    return ReviewModel(
      date: map['date'] as String,
      image: map['image'] as String,
      pain: map['pain'] as String,
      numberStar: map['numberStar'] as String,
      name: map['name'] as String,
      id: map['id'] as String,
      content: map['content'] as String,
    );
  }
}
