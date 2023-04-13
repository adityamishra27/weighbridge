class WeighbridgeData {
  String id;
  String weighbridge_location;
  String weighbridge_code;
  String created_at;
  String created_by;
  String updated_at;
  String updated_by;
  String company_id;
  String is_active;

  WeighbridgeData(
      {required this.id,
      required this.weighbridge_location,
      required this.weighbridge_code,
      required this.created_at,
      required this.created_by,
      required this.updated_at,
      required this.updated_by,
      required this.company_id,
      required this.is_active});

  factory WeighbridgeData.fromJson(Map<String, dynamic> responseData) {
    return WeighbridgeData(
        id: responseData['id'],
        weighbridge_location: responseData['weighbridge_location'],
        weighbridge_code: responseData['weighbridge_code'],
        created_at: responseData['created_at'],
        created_by: responseData['created_by'],
        updated_at: responseData['updated_at'],
        updated_by: responseData['updated_by'],
        company_id: responseData['company_id'],
        is_active: responseData['is_active']);
  }
}
