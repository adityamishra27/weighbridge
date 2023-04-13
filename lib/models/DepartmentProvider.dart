import 'package:flutter/cupertino.dart';

import 'DepartmentData.dart';

class DepartmentProvider with ChangeNotifier {
  List<DepartmentData> departmentData = [];

  addDataList(List<DepartmentData> departmentData1) {
    departmentData = departmentData1;
    notifyListeners();
  }

  addMoreDataList(List<DepartmentData> departmentData1) {
    departmentData.addAll(departmentData1);
    notifyListeners();
  }

  addData(DepartmentData departmentData1) {
    departmentData.add(departmentData1);
    notifyListeners();
  }

  removeData(int index) {
    departmentData.removeAt(index);
    notifyListeners();
  }

  editData(int index, String name) {
    departmentData[index].department_name = name;
    notifyListeners();
  }
}
