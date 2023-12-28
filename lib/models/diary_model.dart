class DiaryModel {
  final String id;
  final String title;
  final String isiDiary;
  final String createdBy;
  final String createdAt;

  DiaryModel({
    required this.id,
    required this.createdBy,
    required this.title,
    required this.isiDiary,
    required this.createdAt,
  });

  Map<String, dynamic> toMap() {
    return {
      "id": this.id,
      "createdBy": this.createdBy,
      "title": this.title,
      "isiDiary": this.isiDiary,
      "createdAt": this.createdAt,
    };
  }

  factory DiaryModel.fromSnapshot(Map<String, dynamic> snapshot) {
    return DiaryModel(
      id: snapshot["id"],
      createdBy: snapshot["createdBy"],
      title: snapshot["title"],
      isiDiary: snapshot["isiDiary"],
      createdAt: snapshot["createdAt"],
    );
  }
}
