import 'package:flutter/cupertino.dart';
import 'CustomerData.dart';

class CustomerProvider with ChangeNotifier {
  List<CustomerData> customerData = [];

  addDataList(List<CustomerData> customerData1) {
    customerData = customerData1;
    notifyListeners();
  }

  addMoreDataList(List<CustomerData> customerData1) {
    customerData.addAll(customerData1);
    notifyListeners();
  }

  addData(CustomerData customerData1) {
    customerData.add(customerData1);
    notifyListeners();
  }

  removeData(int index) {
    customerData.removeAt(index);
    notifyListeners();
  }

  editData(
      int index, String name, String mobile, String gstno, String address) {
    customerData[index].customer_name = name;
    customerData[index].contact_no = mobile;
    customerData[index].gst_no = gstno;
    customerData[index].address = address;
    notifyListeners();
  }
}
