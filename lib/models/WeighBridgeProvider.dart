import 'package:flutter/cupertino.dart';
import 'WeighBridgeData.dart';
import 'BridgeLocationData.dart';

class WeighBridgeProvider with ChangeNotifier {
  List<WeighBridgeData> weighbridgeData = [];
  List<BridgeLocationData> bridgelocationData = [];

  addDataList(List<WeighBridgeData> weighbridgeData1) {
    weighbridgeData = weighbridgeData1;
    notifyListeners();
  }

  bridgelocationList(List<BridgeLocationData> bridgelocationData1) {
    bridgelocationData = bridgelocationData1;
    notifyListeners();
  }

  addMoreDataList(List<WeighBridgeData> weighbridgeData1) {
    weighbridgeData.addAll(weighbridgeData1);
    notifyListeners();
  }

  addData(WeighBridgeData weighbridgeData1) {
    weighbridgeData.add(weighbridgeData1);
    notifyListeners();
  }

  removeData(int index) {
    weighbridgeData.removeAt(index);
    notifyListeners();
  }

  editData(
      int index,
      String weighbridgelocation,
      String weighbridgecode,
      String weighbridgecapacity,
      String serialport,
      String baudrate,
      String databit,
      String stopbit,
      String weighbridgelocationname) {
    weighbridgeData[index].weighbridge_location = weighbridgelocation;
    weighbridgeData[index].weighbridge_code = weighbridgecode;
    weighbridgeData[index].weighbridge_capacity = weighbridgecapacity;
    weighbridgeData[index].serial_port = serialport;
    weighbridgeData[index].baud_rate = baudrate;
    weighbridgeData[index].data_bit = databit;
    weighbridgeData[index].stop_bit = stopbit;
    weighbridgeData[index].weighbridge_location_name = weighbridgelocationname;
    notifyListeners();
  }
}
