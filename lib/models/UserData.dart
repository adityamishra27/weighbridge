class UserData {
  String id;
  String username;
  String name;
  String password;
  String mobile;
  String email;
  String role_id;
  String location_id;
  String weighbridge_id;
  String role_name;
  String company_id;

  UserData({
    required this.id,
    required this.username,
    required this.name,
    required this.password,
    required this.mobile,
    required this.email,
    required this.role_id,
    required this.location_id,
    required this.weighbridge_id,
    required this.role_name,
    required this.company_id,
  });

  factory UserData.fromJson(Map<String, dynamic> responseData) {
    return UserData(
      id: responseData['id'],
      username: responseData['username'],
      name: responseData['name'],
      password: responseData['password'],
      mobile: responseData['mobile'],
      email: responseData['email'],
      role_id: responseData['role_id'],
      location_id: responseData['location_id'],
      weighbridge_id: responseData['weighbridge_id'],
      role_name: responseData['role_name'],
      company_id: responseData['company_id'],
    );
  }
}

class RoleData {
  String id;
  String role_name;

  RoleData({required this.id, required this.role_name});

  factory RoleData.fromJson(Map<String, dynamic> responseData) {
    return RoleData(
        id: responseData['id'], role_name: responseData['role_name']);
  }
}
