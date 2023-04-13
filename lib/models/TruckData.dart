class TruckData {
  String id;
  String truck_no;
  String transporter;
  String capacity;
  String tare_weight;
  String created_at;
  String created_by;
  String updated_at;
  String updated_by;
  String company_id;
  String is_active;
  String transporter_name;

  TruckData(
      {required this.id,
        required this.truck_no,
        required this.transporter,
        required this.capacity,
        required this.tare_weight,
        required this.created_at,
        required this.created_by,
        required this.updated_at,
        required this.updated_by,
        required this.company_id,
        required this.is_active,
        required this.transporter_name});

  factory TruckData.fromJson(Map<String, dynamic> responseData) {
    return TruckData(
        id: responseData['id'],
        truck_no: responseData['truck_no'],
        transporter: responseData['transporter'],
        capacity: responseData['capacity'],
        tare_weight: responseData['tare_weight'],
        created_at: responseData['created_at'],
        created_by: responseData['created_by'],
        updated_at: responseData['updated_at'],
        updated_by: responseData['updated_by'],
        company_id: responseData['company_id'],
        is_active: responseData['is_active'],
        transporter_name: responseData['transporter_name']
    );
  }
}
