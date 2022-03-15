class ClassModel {
  final String id;
  final String kelas;

  ClassModel({
    this.id,
    this.kelas,
  });

  factory ClassModel.fromJson(Map<String, dynamic> json) {
    if (json == null) return null;
    return ClassModel(
      id: json["id"],
      kelas: json["kelas"],
    );
  }

  static List<ClassModel> fromJsonList(List list) {
    if (list == null) return null;
    return list.map((item) => ClassModel.fromJson(item)).toList();
  }

  ///this method will prevent the override of toString
  String userAsString() {
    return '#${this.id} ${this.kelas}';
  }

  ///custom comparing function to check if two users are equal
  bool isEqual(ClassModel model) {
    return this?.id == model?.id;
  }

  @override
  String toString() => kelas;
}
