import 'package:flutter/cupertino.dart';
import 'DriverData.dart';
import 'TransportData.dart';

class DriverProvider with ChangeNotifier {
  List<DriverData> driverData = [];
  //List<TransportData> transportData = [];

  addDataList(List<DriverData> driverData1) {
    driverData = driverData1;
    notifyListeners();
  }

  /* transportList(List<TransportData> transportData1) {
    transportData = transportData1;
    notifyListeners();
  }*/

  addMoreDataList(List<DriverData> driverData1) {
    driverData.addAll(driverData1);
    notifyListeners();
  }

  addData(DriverData driverData1) {
    driverData.add(driverData1);
    notifyListeners();
  }

  removeData(int index) {
    driverData.removeAt(index);
    notifyListeners();
  }

  editData(
      int index,
      String transporterid,
      String drivername,
      String contactno,
      String licenseno,
      String validitydate,
      String dob,
      String age,
      // String photo,
      String type,
      String aadhaarno,
      String voterid,
      String transportername) {
    driverData[index].transporter_id = transporterid;
    driverData[index].driver_name = drivername;
    driverData[index].contact_no = contactno;
    driverData[index].license_no = licenseno;
    driverData[index].validity_date = validitydate;
    driverData[index].dob = dob;
    driverData[index].age = age;
    // driverData[index].photo = photo;
    driverData[index].type = type;
    driverData[index].aadhaar_no = aadhaarno;
    driverData[index].voter_id = voterid;
    driverData[index].transporter_name = transportername;
    notifyListeners();
  }
}
