import 'package:flutter/cupertino.dart';

import 'BridgeLocationData.dart';

class BridgeLocationProvider with ChangeNotifier {
  List<BridgeLocationData> bridgelocationData = [];

  addDataList(List<BridgeLocationData> bridgelocationData1) {
    bridgelocationData = bridgelocationData1;
    notifyListeners();
  }

  addMoreDataList(List<BridgeLocationData> bridgelocationData1) {
    bridgelocationData.addAll(bridgelocationData1);
    notifyListeners();
  }

  addData(BridgeLocationData bridgelocationData1) {
    bridgelocationData.add(bridgelocationData1);
    notifyListeners();
  }

  removeData(int index) {
    bridgelocationData.removeAt(index);
    notifyListeners();
  }

  editData(int index, String name) {
    bridgelocationData[index].location_name = name;
    notifyListeners();
  }
}
