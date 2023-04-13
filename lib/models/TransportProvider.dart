import 'package:flutter/cupertino.dart';
import 'package:weigh_bridge/models/TransportData.dart';

class TransportProvider with ChangeNotifier {
  List<TransportData> transportData = [];

  addDataList(List<TransportData> transportData1) {
    // print( "++++++++++++++++transportData1 : ${transportData1[0].transporter_name}");
    transportData = transportData1;
    notifyListeners();
  }

  addMoreDataList(List<TransportData> transportData1) {
    transportData.addAll(transportData1);
    notifyListeners();
  }

  addData(TransportData transportData1) {
    print(
        "++++++++++++++++transportData1 : ${transportData1.transporter_name}");

    transportData.add(transportData1);
    notifyListeners();
    print("+++++++++++++after ${transportData.length}");
  }

  removeData(int index) {
    transportData.removeAt(index);
    notifyListeners();
  }

  editData(int index, String name, String contact_name, String mobile,
      String email, String address) {
    transportData[index].transporter_name = name;
    transportData[index].transporter_person = contact_name;
    transportData[index].transporter_contact = mobile;
    transportData[index].transporter_email = email;
    transportData[index].transporter_address = address;
    notifyListeners();
  }
}
