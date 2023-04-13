class SerialNumberData {
  String weighment_id;
  String serial_no;
  String truck_no;
  String driver_name;
  String customer_name;
  String product;
  String p_quntity;
  String p_unit_id;
  String remark;
  String weighment_charges;
  String PCs;
  String supplier_id;
  String department_id;
  String destination;
  String gross_weight;
  String tare_weight;
  String net_weight;
  String Entrytype;
  String datetime_gross;
  String datetime_tare;

  SerialNumberData({
    required this.weighment_id,
    required this.serial_no,
    required this.truck_no,
    required this.driver_name,
    required this.customer_name,
    required this.product,
    required this.p_quntity,
    required this.p_unit_id,
    required this.remark,
    required this.weighment_charges,
    required this.PCs,
    required this.supplier_id,
    required this.department_id,
    required this.destination,
    required this.gross_weight,
    required this.tare_weight,
    required this.net_weight,
    required this.Entrytype,
    required this.datetime_gross,
    required this.datetime_tare,
  });

  factory SerialNumberData.fromJson(Map<String, dynamic> responseData) {
    return SerialNumberData(
      weighment_id: responseData['weighment_id'],
      serial_no: responseData['serial_no'],
      truck_no: responseData['truck_no'],
      driver_name: responseData['driver_name'],
      customer_name: responseData['customer_name'],
      product: responseData['product'],
      p_quntity: responseData['p_quntity'],
      p_unit_id: responseData['p_unit_id'],
      remark: responseData['remark'],
      weighment_charges: responseData['weighment_charges'],
      PCs: responseData['PCs'],
      supplier_id: responseData['supplier_id'],
      department_id: responseData['department_id'],
      destination: responseData['destination'],
      gross_weight: responseData['gross_weight'],
      tare_weight: responseData['tare_weight'],
      net_weight: responseData['net_weight'],
      Entrytype: responseData['Entrytype'],
      datetime_gross: responseData['datetime_gross'],
      datetime_tare: responseData['datetime_tare'],
    );
  }
}
