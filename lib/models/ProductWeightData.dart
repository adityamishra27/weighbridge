class ProductWeightData {
  String id;
  String weighment_id;
  String product_name;
  String product_weight;
  String product_pcs;
  String created_at;
  String created_by;
  String is_active;
  String product_rname;
  String product_price;
  String product_freight;

  ProductWeightData({
    required this.id,
    required this.weighment_id,
    required this.product_name,
    required this.product_weight,
    required this.product_pcs,
    required this.created_at,
    required this.created_by,
    required this.is_active,
    required this.product_rname,
    required this.product_price,
    required this.product_freight,
  });

  factory ProductWeightData.fromJson(Map<String, dynamic> responseData) {
    return ProductWeightData(
        id: responseData['id'],
        weighment_id: responseData['weighment_id'],
        product_name: responseData['product_name'],
        product_weight: responseData['product_weight'],
        product_pcs: responseData['product_pcs'],
        created_at: responseData['created_at'],
        created_by: responseData['created_by'],
        is_active: responseData['is_active'],
        product_rname: responseData['product_rname'],
        product_price: responseData['product_price'],
        product_freight: responseData['product_freight']);
  }
}
