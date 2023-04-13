import 'package:flutter/cupertino.dart';
import 'package:weigh_bridge/models/BridgeLocationData.dart';
import 'UserData.dart';
import 'WeighBridgeData.dart';

class UserProvider with ChangeNotifier {
  List<UserData> userData = [];
  List<RoleData> roleData = [];
  List<WeighBridgeData> weighbridgeData = [];
  List<BridgeLocationData> bridgelocationData = [];

  addDataList(List<UserData> userData1) {
    userData = userData1;
    notifyListeners();
  }

  roleList(List<RoleData> roleData1) {
    roleData = roleData1;
    notifyListeners();
  }

  weighbridgeList(List<WeighBridgeData> weighbridgeData1) {
    weighbridgeData = weighbridgeData1;
    notifyListeners();
  }

  bridgelocationList(List<BridgeLocationData> bridgelocationData1) {
    bridgelocationData = bridgelocationData1;
    notifyListeners();
  }

  addMoreDataList(List<UserData> userData1) {
    userData.addAll(userData1);
    notifyListeners();
  }

  addData(UserData userData1) {
    userData.add(userData1);
    notifyListeners();
  }

  removeData(int index) {
    userData.removeAt(index);
    notifyListeners();
  }

  editData(int index, String username, String name, String mobile, String email,
      String roleid, String locationid, String weighbridgeid, String rolename) {
    userData[index].username = username;
    userData[index].name = name;
    userData[index].mobile = mobile;
    userData[index].email = email;
    userData[index].role_id = roleid;
    userData[index].location_id = locationid;
    userData[index].weighbridge_id = weighbridgeid;
    userData[index].role_name = rolename;
    notifyListeners();
  }
}
