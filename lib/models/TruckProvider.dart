import 'package:flutter/cupertino.dart';
import 'TruckData.dart';
import 'TransportData.dart';

class TruckProvider with ChangeNotifier {
  List<TruckData> truckData = [];
  List<TransportData> transportData = [];

  addDataList(List<TruckData> truckData1) {
    truckData = truckData1;
    notifyListeners();
  }

  transportList(List<TransportData> transportData1) {
    transportData = transportData1;
    notifyListeners();
  }

  addMoreDataList(List<TruckData> truckData1) {
    truckData.addAll(truckData1);
    notifyListeners();
  }

  addData(TruckData truckData1) {
    truckData.add(truckData1);
    notifyListeners();
  }

  removeData(int index) {
    truckData.removeAt(index);
    notifyListeners();
  }

  editData(int index, String truckno, String transportcode,
      String truckcapacity, String tareweight, String transportname) {
    truckData[index].truck_no = truckno;
    truckData[index].transporter = transportcode;
    truckData[index].capacity = truckcapacity;
    truckData[index].tare_weight = tareweight;
    truckData[index].transporter_name = transportname;
    notifyListeners();
  }
}
