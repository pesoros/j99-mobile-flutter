// ignore_for_file: non_constant_identifier_names

class FoodModel {
  final String id;
  final String id_resto;
  final String food_name;

  FoodModel({
    this.id,
    this.id_resto,
    this.food_name,
  });

  factory FoodModel.fromJson(Map<String, dynamic> json) {
    if (json == null) return null;
    return FoodModel(
      id: json["id"],
      id_resto: json["id_resto"],
      food_name: json["food_name"],
    );
  }

  static List<FoodModel> fromJsonList(List list) {
    if (list == null) return null;
    return list.map((item) => FoodModel.fromJson(item)).toList();
  }

  ///this method will prevent the override of toString
  String userAsString() {
    return '#${this.id_resto} ${this.food_name}';
  }

  ///custom comparing function to check if two users are equal
  bool isEqual(FoodModel model) {
    return this?.id_resto == model?.id_resto;
  }

  @override
  String toString() => food_name;
}
