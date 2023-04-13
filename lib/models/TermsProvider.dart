import 'package:flutter/cupertino.dart';

import 'TermsData.dart';

class TermsProvider with ChangeNotifier {
  List<TermsData> termsData = [];

  addDataList(List<TermsData> termsData1) {
    termsData = termsData1;
    notifyListeners();
  }

  addMoreDataList(List<TermsData> termsData1) {
    termsData.addAll(termsData1);
    notifyListeners();
  }

  addData(TermsData termsData1) {
    termsData.add(termsData1);
    notifyListeners();
  }

  removeData(int index) {
    termsData.removeAt(index);
    notifyListeners();
  }

  editData(int index, String name) {
    termsData[index].terms = name;
    notifyListeners();
  }
}
