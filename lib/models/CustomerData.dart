class CustomerData {
  String id;
  String customer_name;
  String contact_no;
  String gst_no;
  String address;
  String created_by;
  String created_at;
  String updated_at;
  String updated_by;
  String company_id;
  String is_active;

  CustomerData(
      {required this.id,
      required this.customer_name,
      required this.contact_no,
      required this.gst_no,
      required this.address,
      required this.created_by,
      required this.created_at,
      required this.updated_at,
      required this.updated_by,
      required this.company_id,
      required this.is_active});

  factory CustomerData.fromJson(Map<String, dynamic> responseData) {
    return CustomerData(
        id: responseData['id'],
        customer_name: responseData['customer_name'],
        contact_no: responseData['contact_no'],
        gst_no: responseData['gst_no'],
        address: responseData['address'],
        created_by: responseData['created_by'],
        created_at: responseData['created_at'],
        updated_at: responseData['updated_at'],
        updated_by: responseData['updated_by'],
        company_id: responseData['company_id'],
        is_active: responseData['is_active']);
  }
}
