class WeighmentData {
  int id;
  int log_id;
  int weighment_id;
  String invoice_no;
  String serial_no;
  String truck_no;
  String driver_name;
  String customer_name;
  String product;
  int p_quntity;
  String p_unit_id;
  String remark;
  double weighment_charges;
  int PCs;
  int supplier_id;
  int department_id;
  String destination;
  double gross_weight;
  double tare_weight;
  double net_weight;
  DateTime datetime_gross;
  DateTime datetime_tare;
  String Entrytype;
  String location_id;
  String weighbridge_id;
  String company_id;
  DateTime created_at;
  int created_by;
  DateTime updated_at;
  int updated_by;
  DateTime we_date;
  String unit_name;
  String supplier_name;
  String department_name;
  String created_by_name;
  String updated_by_name;
  String location_name;
  String weighbridge_name;
  String company_name;

  double product_price;
  double freight_charge;
  int gst_type;
  double gst_price;
  double freight_gst_price;
  double other_ch;
  double total_price;
  String gst_name;
  String gst_per;

  WeighmentData(
    this.id,
    this.log_id,
    this.weighment_id,
    this.invoice_no,
    this.serial_no,
    this.truck_no,
    this.driver_name,
    this.customer_name,
    this.product,
    this.p_quntity,
    this.p_unit_id,
    this.remark,
    this.weighment_charges,
    this.PCs,
    this.supplier_id,
    this.department_id,
    this.destination,
    this.gross_weight,
    this.tare_weight,
    this.net_weight,
    this.datetime_gross,
    this.datetime_tare,
    this.Entrytype,
    this.location_id,
    this.weighbridge_id,
    this.company_id,
    this.created_at,
    this.created_by,
    this.updated_at,
    this.updated_by,
    this.we_date,
    this.unit_name,
    this.supplier_name,
    this.department_name,
    this.created_by_name,
    this.updated_by_name,
    this.location_name,
    this.weighbridge_name,
    this.company_name,
    this.product_price,
    this.freight_charge,
    this.gst_type,
    this.gst_price,
    this.freight_gst_price,
    this.other_ch,
    this.total_price,
    this.gst_name,
    this.gst_per,
  );

  factory WeighmentData.fromJson(Map<String, dynamic> json) {
    return WeighmentData(
      json['id'] as int,
      json['log_id'] as int,
      json['weighment_id'] as int,
      json['invoice_no'] as String,
      json['serial_no'] as String,
      json['truck_no'] as String,
      json['driver_name'] as String,
      json['customer_name'] as String,
      json['product'] as String,
      json['p_quntity'] as int,
      json['p_unit_id'] as String,
      json['remark'] as String,
      json['weighment_charges'] as double,
      json['PCs'] as int,
      json['supplier_id'] as int,
      json['department_id'] as int,
      json['destination'] as String,
      json['gross_weight'] as double,
      json['tare_weight'] as double,
      json['net_weight'] as double,
      json['datetime_gross'] as DateTime,
      json['datetime_tare'] as DateTime,
      json['Entrytype'] as String,
      json['location_id'] as String,
      json['weighbridge_id'] as String,
      json['company_id'] as String,
      json['created_at'] as DateTime,
      json['created_by'] as int,
      json['updated_at'] as DateTime,
      json['updated_by'] as int,
      json['we_date'] as DateTime,
      json['unit_name'] as String,
      json['supplier_name'] as String,
      json['department_name'] as String,
      json['created_by_name'] as String,
      json['updated_by_name'] as String,
      json['location_name'] as String,
      json['weighbridge_name'] as String,
      json['company_name'] as String,
      json['product_price'] as double,
      json['freight_charge'] as double,
      json['gst_type'] as int,
      json['gst_price'] as double,
      json['freight_gst_price'] as double,
      json['other_ch'] as double,
      json['total_price'] as double,
      json['gst_name'] as String,
      json['gst_per'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'log_id': log_id,
      'weighment_id': weighment_id,
      'invoice_no': weighment_id,
      'serial_no': serial_no,
      'truck_no': truck_no,
      'driver_name': driver_name,
      'customer_name': customer_name,
      'product': product,
      'p_quntity': p_quntity,
      'p_unit_id': p_unit_id,
      'remark': remark,
      'weighment_charges': weighment_charges,
      'PCs': PCs,
      'supplier_id': supplier_id,
      'department_id': department_id,
      'destination': destination,
      'gross_weight': gross_weight,
      'tare_weight': tare_weight,
      'net_weight': net_weight,
      'datetime_gross': datetime_gross,
      'datetime_tare': datetime_tare,
      'Entrytype': Entrytype,
      'location_id': location_id,
      'weighbridge_id': weighbridge_id,
      'company_id': company_id,
      'created_at': created_at,
      'created_by': created_by,
      'updated_at': updated_at,
      'updated_by': updated_by,
      'we_date': we_date,
      'unit_name': unit_name,
      'supplier_name': supplier_name,
      'department_name': department_name,
      'created_by_name': created_by_name,
      'updated_by_name': updated_by_name,
      'location_name': location_name,
      'weighbridge_name': weighbridge_name,
      'company_name': company_name,
      'product_price': product_price,
      'freight_charge': freight_charge,
      'gst_type': gst_type,
      'gst_price': gst_price,
      'freight_gst_price': freight_gst_price,
      'other_ch': other_ch,
      'total_price': total_price,
      'gst_name': gst_name,
      'gst_per': gst_per,
    };
  }
}
