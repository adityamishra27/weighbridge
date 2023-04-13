class BridgeLocationData {
  String id;
  String location_name;
  String created_at;
  String created_by;
  String updated_at;
  String updated_by;
  String company_id;
  String is_active;

  BridgeLocationData(
      {required this.id,
      required this.location_name,
      required this.created_at,
      required this.created_by,
      required this.updated_at,
      required this.updated_by,
      required this.company_id,
      required this.is_active});

  factory BridgeLocationData.fromJson(Map<String, dynamic> responseData) {
    return BridgeLocationData(
        id: responseData['id'],
        location_name: responseData['location_name'],
        created_at: responseData['created_at'],
        created_by: responseData['created_by'],
        updated_at: responseData['updated_at'],
        updated_by: responseData['updated_by'],
        company_id: responseData['company_id'],
        is_active: responseData['is_active']);
  }
}
