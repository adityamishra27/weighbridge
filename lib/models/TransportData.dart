class TransportData {
  String id;
  String transporter_code;
  String transporter_name;
  String transporter_person;
  String transporter_contact;
  String transporter_email;
  String transporter_address;
  String is_active;

  TransportData(
      {required this.id,
      required this.transporter_code,
      required this.transporter_name,
      required this.transporter_person,
      required this.transporter_contact,
      required this.transporter_email,
      required this.transporter_address,
      required this.is_active});

  factory TransportData.fromJson(Map<String, dynamic> responseData) {
    return TransportData(
        id: responseData['id'],
        transporter_code: responseData['transporter_code'],
        transporter_name: responseData['transporter_name'],
        transporter_person: responseData['transporter_person'],
        transporter_contact: responseData['transporter_contact'],
        transporter_email: responseData['transporter_email'],
        transporter_address: responseData['transporter_address'],
        is_active: responseData['is_active']);
  }
}
