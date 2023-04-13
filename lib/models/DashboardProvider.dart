import 'package:flutter/cupertino.dart';
import 'DashboardData.dart';

class DashboardProvider with ChangeNotifier {
  List<PreviousWeighData> previousData = [];
  List<PendingWeighData> pendingData = [];

  addPreviousDataList(List<PreviousWeighData> previousData1) {
    previousData = previousData1;
    notifyListeners();
  }

  addPendingDataList(List<PendingWeighData> pendingData1) {
    pendingData = pendingData1;
    notifyListeners();
  }

}
