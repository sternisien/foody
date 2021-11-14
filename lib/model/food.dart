// ignore_for_file: file_names

class Food {
  late String _id;
  late String _imgLink;
  late Map<String, String> _name;
  late Map<String, String> _description;
  late String _idFoodType;

  Food(String id, String imgLink, Map<String, String> name,
      Map<String, String> description, String idFoodType) {
    _id = id;
    _imgLink = imgLink;
    _name = name;
    _description = description;
    _idFoodType = idFoodType;
  }

  ///Function to get ID
  String getId() {
    return _id;
  }

  ///Function to get image link
  String getImgLink() {
    return _imgLink;
  }

  ///Function to get name of food (english / french)
  Map<String, String> getName() {
    return _name;
  }

  ///Function to get description of food (english / french)
  Map<String, String> getDescription() {
    return _description;
  }

  ///Function to get id of food type
  String getIdFoodType() {
    return _idFoodType;
  }

  Food.fromJson(Map<String, dynamic> json, String id)
      : _id = id,
        _imgLink = json['img_link'],
        _name = convertMapFromFireStore(json['name'] as Map<String, dynamic>),
        _description = convertMapFromFireStore(
            json['description'] as Map<String, dynamic>),
        _idFoodType = json['idFoodType'];

  Map<String, dynamic> toJson() {
    return {
      'id': _id,
      'imgLink': _imgLink,
      'name': _name,
      'description': _description,
      'idFoodType': _idFoodType
    };
  }

  static Map<String, String> convertMapFromFireStore(
      Map<String, dynamic> data) {
    return data.map((key, value) => MapEntry(key, value.toString()));
  }
}
