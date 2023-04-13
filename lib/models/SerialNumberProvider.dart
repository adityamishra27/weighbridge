import 'package:flutter/cupertino.dart';
import 'package:weigh_bridge/models/SerialNumberData.dart';

class SerialNumberProvider with ChangeNotifier {
  List<SerialNumberData> serialNumberData = [];

  addDataList(List<SerialNumberData> serialNumberData1) {
    serialNumberData = serialNumberData1;
    notifyListeners();
  }

  addMoreDataList(List<SerialNumberData> serialNumberData1) {
    serialNumberData.addAll(serialNumberData1);
    notifyListeners();
  }

  addData(SerialNumberData serialNumberData1) {
    serialNumberData.add(serialNumberData1);
    notifyListeners();
  }

  removeData(int index) {
    serialNumberData.removeAt(index);
    notifyListeners();
  }
}
