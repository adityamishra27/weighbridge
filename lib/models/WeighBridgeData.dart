class WeighBridgeData {
  String id;
  String weighbridge_location;
  String weighbridge_code;
  String weighbridge_capacity;
  String serial_port;
  String baud_rate;
  String data_bit;
  String stop_bit;
  String created_at;
  String created_by;
  String updated_at;
  String updated_by;
  String company_id;
  String is_active;
  String weighbridge_location_name;

  WeighBridgeData(
      {required this.id,
      required this.weighbridge_location,
      required this.weighbridge_code,
      required this.weighbridge_capacity,
      required this.serial_port,
      required this.baud_rate,
      required this.data_bit,
      required this.stop_bit,
      required this.created_at,
      required this.created_by,
      required this.updated_at,
      required this.updated_by,
      required this.company_id,
      required this.is_active,
      required this.weighbridge_location_name});

  factory WeighBridgeData.fromJson(Map<String, dynamic> responseData) {
    return WeighBridgeData(
        id: responseData['id'],
        weighbridge_location: responseData['weighbridge_location'],
        weighbridge_code: responseData['weighbridge_code'],
        weighbridge_capacity: responseData['weighbridge_capacity'],
        serial_port: responseData['serial_port'],
        baud_rate: responseData['baud_rate'],
        data_bit: responseData['data_bit'],
        stop_bit: responseData['stop_bit'],
        created_at: responseData['created_at'],
        created_by: responseData['created_by'],
        updated_at: responseData['updated_at'],
        updated_by: responseData['updated_by'],
        company_id: responseData['company_id'],
        is_active: responseData['is_active'],
        weighbridge_location_name: responseData['weighbridge_location_name']);
  }
}
