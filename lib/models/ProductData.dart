class ProductData {
  String id;
  String product_name;
  String product_code;
  String product_unit;
  String created_at;
  String created_by;
  String updated_at;
  String updated_by;
  String company_id;
  String is_active;
  String product_unit_name;

  ProductData(
      {required this.id,
      required this.product_name,
      required this.product_code,
      required this.product_unit,
      required this.created_at,
      required this.created_by,
      required this.updated_at,
      required this.updated_by,
      required this.company_id,
      required this.is_active,
      required this.product_unit_name});

  factory ProductData.fromJson(Map<String, dynamic> responseData) {
    return ProductData(
        id: responseData['id'],
        product_name: responseData['product_name'],
        product_code: responseData['product_code'],
        product_unit: responseData['product_unit'],
        created_at: responseData['created_at'],
        created_by: responseData['created_by'],
        updated_at: responseData['updated_at'],
        updated_by: responseData['updated_by'],
        company_id: responseData['company_id'],
        is_active: responseData['is_active'],
		
        product_unit_name: responseData['product_unit_name']);
  }
}
