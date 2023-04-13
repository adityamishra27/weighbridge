class DriverData {
  String id;
  String transporter_id;
  String driver_code;
  String driver_barcode;
  String driver_name;
  String contact_no;
  String license_no;
  String validity_date;
  String dob;
  String age;
  // String photo;
  String type;
  String aadhaar_no;
  String voter_id;
  String transporter_name;

  DriverData(
      {required this.id,
      required this.transporter_id,
      required this.driver_code,
      required this.driver_barcode,
      required this.driver_name,
      required this.contact_no,
      required this.license_no,
      required this.validity_date,
      required this.dob,
      required this.age,
      // required this.photo,
      required this.type,
      required this.aadhaar_no,
      required this.voter_id,
      required this.transporter_name});

  factory DriverData.fromJson(Map<String, dynamic> responseData) {
    return DriverData(
        id: responseData['id'],
        transporter_id: responseData['transporter_id'],
        driver_code: responseData['driver_code'],
        driver_barcode: responseData['driver_barcode'],
        driver_name: responseData['driver_name'],
        contact_no: responseData['contact_no'],
        license_no: responseData['license_no'],
        validity_date: responseData['validity_date'],
        dob: responseData['dob'],
        age: responseData['age'],
        // photo: responseData['photo'],
        type: responseData['type'],
        aadhaar_no: responseData['aadhaar_no'],
        voter_id: responseData['voter_id'],
        transporter_name: responseData['transporter_name']);
  }
}
