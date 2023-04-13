class SupplierData {
  String id;
  String supplier_name;
  String supplier_contact;
  String supplier_email;
  String supplier_address;
  String created_at;
  String created_by;
  String updated_at;
  String updated_by;
  String company_id;
  String is_active;

  SupplierData(
      {required this.id,
        required this.supplier_name,
        required this.supplier_contact,
        required this.supplier_email,
        required this.supplier_address,
        required this.created_at,
        required this.created_by,
        required this.updated_at,
        required this.updated_by,
        required this.company_id,
        required this.is_active});

  factory SupplierData.fromJson(Map<String, dynamic> responseData) {
    return SupplierData(
        id: responseData['id'],
        supplier_name: responseData['supplier_name'],
        supplier_contact: responseData['supplier_contact'],
        supplier_email: responseData['supplier_email'],
        supplier_address: responseData['supplier_address'],
        created_at: responseData['created_at'],
        created_by: responseData['created_by'],
        updated_at: responseData['updated_at'],
        updated_by: responseData['updated_by'],
        company_id: responseData['company_id'],
        is_active: responseData['is_active']);
  }
}
