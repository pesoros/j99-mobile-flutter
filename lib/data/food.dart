// ignore_for_file: non_constant_identifier_names

class FoodModel {
  final String id;
  final String id_resto;
  final String food_name;
  final String food_class;
  final String image;

  FoodModel({
    this.id,
    this.id_resto,
    this.food_name,
    this.food_class,
    this.image,
  });

  factory FoodModel.fromJson(Map<String, dynamic> json) {
    return FoodModel(
      id: json["id"],
      id_resto: json["id_resto"],
      food_name: json["food_name"],
      food_class: json["class"],
      image: json["image"],
    );
  }

  static List<FoodModel> fromJsonList(List list) {
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
