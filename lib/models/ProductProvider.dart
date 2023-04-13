import 'package:flutter/cupertino.dart';
import 'ProductData.dart';
import 'UnitData.dart';

class ProductProvider with ChangeNotifier {
  List<ProductData> productData = [];
  List<UnitData> unitData = [];

  addDataList(List<ProductData> productData1) {
    productData = productData1;
    notifyListeners();
  }

  unitList(List<UnitData> unitData1) {
    unitData = unitData1;
    notifyListeners();
  }

  addMoreDataList(List<ProductData> productData1) {
    productData.addAll(productData1);
    notifyListeners();
  }

  addData(ProductData productData1) {
    productData.add(productData1);
    notifyListeners();
  }

  removeData(int index) {
    productData.removeAt(index);
    notifyListeners();
  }

  editData(
      int index, String name, String pcode, String unit, String unitname) {
    productData[index].product_name = name;
    productData[index].product_code = pcode;
    productData[index].product_unit = unit;
    productData[index].product_unit_name = unitname;
    notifyListeners();
  }
}
