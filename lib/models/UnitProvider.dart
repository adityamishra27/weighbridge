import 'package:flutter/cupertino.dart';

import 'UnitData.dart';

class UnitProvider with ChangeNotifier {
  List<UnitData> unitData = [];

  addDataList(List<UnitData> unitData1) {
    unitData = unitData1;
    notifyListeners();
  }

  addMoreDataList(List<UnitData> unitData1) {
    unitData.addAll(unitData1);
    notifyListeners();
  }

  addData(UnitData unitData1) {
    unitData.add(unitData1);
    notifyListeners();
  }

  removeData(int index) {
    unitData.removeAt(index);
    notifyListeners();
  }

  editData(int index, String name) {
    unitData[index].unit_name = name;
    notifyListeners();
  }
}
