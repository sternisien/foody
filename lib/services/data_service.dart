import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:foody/model/food.dart';

class DataService {
  //not necessary to be explicit to initialize variable to null;
  static DataService? _dataService;
  final _firestoreInstance = FirebaseFirestore.instance;

  /// Function to get a instance of service (Singleton)
  static DataService? getInstance() {
    //this syntax equivalent if(_dataservice == null)
    _dataService ??= DataService();
    return _dataService;
  }

  Future<List<Food>> getFood() async {
    List<Food> foodList = [];
    await _firestoreInstance
        .collection("food")
        .get()
        .then((value) => value.docs.forEach((element) {
              foodList.add(Food.fromJson(element.data(), element.id));
            }));
    return foodList;
  }
}
