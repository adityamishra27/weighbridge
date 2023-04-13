import 'package:flutter/cupertino.dart';
import 'ProductWeightData.dart';

class ProductWeightProvider with ChangeNotifier {
  List<ProductWeightData> productweightData = [];

  addDataList(List<ProductWeightData> productweightData1) {
    productweightData = productweightData1;
    notifyListeners();
  }

  addMoreDataList(List<ProductWeightData> productweightData1) {
    productweightData.addAll(productweightData1);
    notifyListeners();
  }

  addData(ProductWeightData productweightData1) {
    productweightData.add(productweightData1);
    notifyListeners();
  }

  removeData(int index) {
    productweightData.removeAt(index);
    notifyListeners();
  }

}