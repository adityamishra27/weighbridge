import 'package:flutter/cupertino.dart';
import 'SupplierData.dart';

class SupplierProvider with ChangeNotifier {
  List<SupplierData> supplierData = [];

  addDataList(List<SupplierData> supplierData1) {
    supplierData = supplierData1;
    notifyListeners();
  }

  addMoreDataList(List<SupplierData> supplierData1) {
    supplierData.addAll(supplierData1);
    notifyListeners();
  }

  addData(SupplierData supplierData1) {
    supplierData.add(supplierData1);
    notifyListeners();
  }

  removeData(int index) {
    supplierData.removeAt(index);
    notifyListeners();
  }

  editData(
      int index, String name, String mobile, String email, String address) {
    supplierData[index].supplier_name = name;
    supplierData[index].supplier_contact = mobile;
    supplierData[index].supplier_email = email;
    supplierData[index].supplier_address = address;
    notifyListeners();
  }
}
