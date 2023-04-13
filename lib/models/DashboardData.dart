class PreviousWeighData {
  String serial_no;
  String truck_no;
  String gross_weight;
  String tare_weight;
  String net_weight;
  String remark;

  PreviousWeighData(
      {required this.serial_no,
        required this.truck_no,
        required this.gross_weight,
        required this.tare_weight,
        required this.net_weight,
        required this.remark
      });

  factory PreviousWeighData.fromJson(Map<String, dynamic> responseData) {
    return PreviousWeighData(
        serial_no: responseData['serial_no'],
        truck_no: responseData['truck_no'],
        gross_weight: responseData['gross_weight'],
        tare_weight: responseData['tare_weight'],
        net_weight: responseData['net_weight'],
        remark: responseData['remark']
    );
  }

}

class PendingWeighData {
  String weighment_id;
  String serial_no;
  String truck_no;
  String gross_weight;
  String tare_weight;
  String net_weight;
  String remark;

  PendingWeighData(
      {
        required this.weighment_id,
        required this.serial_no,
        required this.truck_no,
        required this.gross_weight,
        required this.tare_weight,
        required this.net_weight,
        required this.remark
      });

  factory PendingWeighData.fromJson(Map<String, dynamic> responseData) {
    return PendingWeighData(
        weighment_id: responseData['weighment_id'],
        serial_no: responseData['serial_no'],
        truck_no: responseData['truck_no'],
        gross_weight: responseData['gross_weight'],
        tare_weight: responseData['tare_weight'],
        net_weight: responseData['net_weight'],
        remark: responseData['remark']
    );
  }
}
