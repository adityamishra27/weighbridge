import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../models/UserData.dart';
import '../shared_preference/UserPreferences.dart';
import '../util/colors.dart';
import '../util/config.dart';
import '../util/mysql_conn.dart';
import 'dashboard.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final loginidController = TextEditingController();
  final loginpwdController = TextEditingController();
  bool visible = false;
  var db = Mysql();

  @override
  void dispose() {
    super.dispose();
    loginidController.dispose();
    loginpwdController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      backgroundColor: ColorSelect.white,
      appBar: AppBar(
        title: const Text(
          "Login",
          style: TextStyle(color: ColorSelect.white),
        ),
      ),
      body: Center(
        child: Container(
            width: MediaQuery.of(context).size.width * 0.95,
            height: MediaQuery.of(context).size.height * 0.70,
            margin: const EdgeInsets.all(10.0),
            child: SingleChildScrollView(
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 100),
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                      color: ColorSelect.colorPrimary,
                      style: BorderStyle.solid,
                      width: 2),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      flex: 1,
                      child: Column(
                        children: [
                          Image.asset(
                            'assets/images/logo2.png',
                            height: 300,
                            width: 300,
                          ),
                          const SizedBox(
                            height: 2,
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Column(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: ColorSelect.white,
                            ),
                            child: const Text(APP_NAME,
                                style: TextStyle(
                                    color: ColorSelect.colorPrimary,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 22)),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(8, 20, 8, 0),
                            child: TextField(
                                controller: loginidController,
                                //maxLength: 10,
                                inputFormatters: [
                                  LengthLimitingTextInputFormatter(20),
                                ],
                                decoration: InputDecoration(
                                  prefixIcon: const Icon(
                                    Icons.person,
                                    color: ColorSelect.iconColor,
                                  ),
                                  filled: true,
                                  fillColor: Colors.white,
                                  labelText: "Email Id *",
                                  hintText: "Email Id *",
                                  contentPadding: const EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 5),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                                keyboardType: TextInputType.text),
                          ),
                          const SizedBox(
                            height: 10.0,
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(8, 20, 8, 0),
                            child: TextField(
                                obscureText: true,
                                controller: loginpwdController,
                                //maxLength: 10,
                                inputFormatters: [
                                  LengthLimitingTextInputFormatter(20),
                                ],
                                decoration: InputDecoration(
                                  prefixIcon: const Icon(
                                    Icons.key,
                                    color: ColorSelect.iconColor,
                                  ),
                                  filled: true,
                                  fillColor: Colors.white,
                                  labelText: "Login Password *",
                                  hintText: "Login Password *",
                                  contentPadding: const EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 5),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                                keyboardType: TextInputType.text),
                          ),
                          const SizedBox(
                            height: 10.0,
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(8, 20, 8, 10),
                            child: SizedBox(
                              height: 50, //height of button
                              width: double.infinity,
                              child: ElevatedButton(
                                child: const Text('Login',
                                    style: TextStyle(
                                      color: ColorSelect.white,
                                    )),
                                onPressed: () {
                                  checkLoginCredentials();
                                },
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 10.0,
                          ),
                          const Center(
                            child: Text(
                                "IF YOU FORGOT YOUR PASSWORD, KINDLY CONTACT YOUR ADMIN",
                                style: TextStyle(
                                    color: ColorSelect.colorPrimary,
                                    fontWeight: FontWeight.bold)),
                          ),
                          const SizedBox(
                            height: 10.0,
                          ),
                          Visibility(
                              visible: visible,
                              child: Container(
                                  margin: const EdgeInsets.only(bottom: 30),
                                  child: const CircularProgressIndicator())),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            )),
      ),
    );
  }

  //method to check login credentials
  checkLoginCredentials() async {
    String login_id = loginidController.text.trim();
    String login_pwd = loginpwdController.text.trim();

    if (login_id.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Enter email id"),
      ));
    } else if (login_pwd.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Enter password"),
      ));
    } else {
      setState(() {
        visible = true;
      });
      String sql =
          "select * from users where email='$login_id' and password=MD5('$login_pwd') and is_active=1";

      await db.getConnection().then((conn) async {
        await conn.query(sql).then((results) async {
          //  print(results);
          for (var res in results) {
            //  print(res); weighment_id: res['weighment_id'].toString(),
            String id = res['id'].toString();
            String username = res['username'].toString();
            String name = res['name'].toString();
            String mobile = res['mobile'].toString();
            String email = res['email'].toString();
            String role_id = res['role_id'].toString();
            String location_id = res['location_id'].toString();
            String weighbridge_id = res['weighbridge_id'].toString();
            String role_name = res['role_name'].toString();
            String company_id = res['company_id'].toString();

            UserData user = UserData(
              id: id,
              username: username,
              name: name,
              password: '',
              mobile: mobile,
              email: email,
              role_id: role_id,
              location_id: location_id,
              weighbridge_id: weighbridge_id,
              role_name: role_name,
              company_id: company_id,
            );

            UserPreferences().saveUser(user);
          }

          /* String? user_id1 = await Common().getUserId1();

          print("+++++++++++++++user_id1 : " + user_id1!);*/

          if (results.isNotEmpty) {
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content: Text("Login successfully"),
            ));

            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => DashboardScreen()));
          } else {
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content: Text("Please enter correct credentials"),
            ));
          }
        }).onError((error, stackTrace) {
          print(error);

          return null;
        });

        conn.close();
      });
    }
  }
}
