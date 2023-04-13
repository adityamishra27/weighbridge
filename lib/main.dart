import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:weigh_bridge/models/DashboardProvider.dart';
//import 'package:window_size/window_size.dart';
import 'package:weigh_bridge/models/DepartmentProvider.dart';
import 'package:weigh_bridge/models/ProductWeightProvider.dart';
import 'package:weigh_bridge/models/SupplierProvider.dart';
import 'package:weigh_bridge/models/UnitProvider.dart';
import 'package:weigh_bridge/screens/dashboard.dart';
import 'package:weigh_bridge/screens/login_screen.dart';
import 'package:weigh_bridge/screens/masters/new_serialport_demo.dart';
import 'package:weigh_bridge/screens/masters/serialport_demo.dart';
import 'package:weigh_bridge/screens/masters/users.dart';
import 'package:weigh_bridge/shared_preference/UserPreferences.dart';
import 'package:weigh_bridge/util/Common.dart';
import 'package:weigh_bridge/util/colors.dart';
import 'package:weigh_bridge/util/config.dart';

import 'package:provider/provider.dart';
import 'package:weigh_bridge/util/mysql_conn.dart';

import 'models/BridgeLocationProvider.dart';
import 'models/CustomerProvider.dart';
import 'models/DriverProvider.dart';
import 'models/ProductProvider.dart';
import 'models/SerialNumberProvider.dart';
import 'models/TermsProvider.dart';
import 'models/TransportProvider.dart';
import 'models/TruckProvider.dart';
import 'models/UserProvider.dart';
import 'models/WeighBridgeProvider.dart';

void main() {
  /* WidgetsFlutterBinding.ensureInitialized();
  if (Platform.isWindows || Platform.isLinux || Platform.isMacOS) {
    setWindowTitle('Weighing Bridge');
    setWindowMinSize(const Size(1300, 600));
    setWindowMaxSize(Size.infinite);
  }*/

  runApp(
    MultiProvider(providers: [
      ChangeNotifierProvider(create: (_) => DepartmentProvider()),
      ChangeNotifierProvider(create: (_) => TransportProvider()),
      ChangeNotifierProvider(create: (_) => UnitProvider()),
      ChangeNotifierProvider(create: (_) => SerialNumberProvider()),
      ChangeNotifierProvider(create: (_) => DashboardProvider()),
      ChangeNotifierProvider(create: (_) => BridgeLocationProvider()),
      ChangeNotifierProvider(create: (_) => CustomerProvider()),
      ChangeNotifierProvider(create: (_) => SupplierProvider()),
      ChangeNotifierProvider(create: (_) => ProductProvider()),
      ChangeNotifierProvider(create: (_) => TruckProvider()),
      ChangeNotifierProvider(create: (_) => TermsProvider()),
      ChangeNotifierProvider(create: (_) => WeighBridgeProvider()),
      ChangeNotifierProvider(create: (_) => DashboardProvider()),
      ChangeNotifierProvider(create: (_) => DriverProvider()),
      ChangeNotifierProvider(create: (_) => UserProvider()),
      ChangeNotifierProvider(create: (_) => ProductWeightProvider()),
    ], child: const MyApp()),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: ColorSelect.colorCustom,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var db = Mysql();
  final hostController = TextEditingController();
  final userController = TextEditingController();
  final passController = TextEditingController();
  final dbnameController = TextEditingController();

  void initState() {
    super.initState();

    Timer(
        const Duration(seconds: 2),
        () => {
              checkDBConnection(),

              /*   Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => DashboardScreen()))*/
            });
  }

  @override
  void dispose() {
    super.dispose();

    hostController.dispose();
    userController.dispose();
    passController.dispose();
    dbnameController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorSelect.white,
      body: Center(
        child: Container(
          width: MediaQuery.of(context).size.width * 0.95,
          height: MediaQuery.of(context).size.height * 0.70,
          padding: const EdgeInsets.all(10.0),
          child: Center(
              child: Container(
            width: MediaQuery.of(context).size.width * 0.95,
            height: MediaQuery.of(context).size.height * 0.70,
            padding: const EdgeInsets.all(10.0),
            child: Center(
              child: Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/images/logo2.png',
                      height: 200,
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    const Text(APP_NAME,
                        style: TextStyle(
                            color: ColorSelect.colorPrimary,
                            fontWeight: FontWeight.bold,
                            fontSize: 30)),
                  ],
                ),
              ),
            ),
          )),
        ),
      ),
    );
  }

  checkDBConnection() async {
    try {
      var conn = await db.getConnection();

      String user_id = await Common().getUserId();
      if (user_id != null && user_id != '') {
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => DashboardScreen()));
      } else {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => LoginScreen()));
      }
    } catch (ex) {
      showDialog(
          context: context,
          barrierDismissible: false,
          builder: (ctx) => AlertDialog(
              title: const Text(APP_NAME), content: getAlertDialog()));
    }
  }

  getAlertDialog() {
    return Container(
      height: 355,
      width: 300,
      child: SingleChildScrollView(
        child: StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Expanded(
                    flex: 1,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(5, 5, 5, 0),
                      child: TextField(
                          controller: hostController,
                          //maxLength: 10,
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(20),
                            FilteringTextInputFormatter.allow(RegExp("[0-9.]")),
                          ],
                          decoration: InputDecoration(
                            prefixIcon: const Icon(
                              Icons.important_devices,
                              color: ColorSelect.iconColor,
                            ),
                            filled: true,
                            fillColor: Colors.white,
                            labelText: "Host Name *",
                            hintText: "Host Name *",
                            contentPadding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 5),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          keyboardType: TextInputType.name),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Expanded(
                    flex: 1,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(5, 5, 5, 0),
                      child: TextField(
                          controller: userController,
                          //maxLength: 10,
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(30),
                            FilteringTextInputFormatter.allow(
                                RegExp("[a-zA-Z0-9_]")),
                          ],
                          decoration: InputDecoration(
                            prefixIcon: const Icon(
                              Icons.person,
                              color: ColorSelect.iconColor,
                            ),
                            filled: true,
                            fillColor: Colors.white,
                            labelText: "User Name *",
                            hintText: "User Name *",
                            contentPadding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 5),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          keyboardType: TextInputType.name),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Expanded(
                    flex: 1,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(5, 5, 5, 0),
                      child: TextField(
                          controller: passController,
                          //maxLength: 10,
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(30),
                          ],
                          decoration: InputDecoration(
                            prefixIcon: const Icon(
                              Icons.key,
                              color: ColorSelect.iconColor,
                            ),
                            filled: true,
                            fillColor: Colors.white,
                            labelText: "Password *",
                            hintText: "Password *",
                            contentPadding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 5),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          keyboardType: TextInputType.name),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Expanded(
                    flex: 1,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(5, 5, 5, 0),
                      child: TextField(
                          controller: dbnameController,
                          //maxLength: 10,
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(30),
                            FilteringTextInputFormatter.allow(
                                RegExp("[a-zA-Z0-9_]")),
                          ],
                          decoration: InputDecoration(
                            prefixIcon: const Icon(
                              Icons.dashboard,
                              color: ColorSelect.iconColor,
                            ),
                            filled: true,
                            fillColor: Colors.white,
                            labelText: "Database Name *",
                            hintText: "Database Name *",
                            contentPadding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 5),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          keyboardType: TextInputType.name),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Expanded(
                    flex: 1,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(5, 10, 5, 0),
                      child: SizedBox(
                        height: 40, //height of button
                        width: double.infinity,
                        child: ElevatedButton(
                          child: const Text("Submit",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: ColorSelect.white,
                              )),
                          onPressed: () {
                            submitDetails();
                          },
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: const <Widget>[
                  Expanded(
                    flex: 1,
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(5, 10, 5, 10),
                      child: SizedBox(
                        height: 40, //height of button
                        width: double.infinity,
                        child: Text(
                            "Application is not connected to the database. Please fill the database details. ",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: ColorSelect.red,
                            )),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          );
        }),
      ),
    );
  }

  submitDetails() {
    String hostname = hostController.text.trim();
    String username = userController.text.trim();
    String password = passController.text.trim();
    String dbname = dbnameController.text.trim();

    if (hostname.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Enter Host Name"),
      ));
    } else if (username.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Enter User Name"),
      ));
    } else if (password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Enter Password"),
      ));
    } else if (dbname.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Enter Database Name"),
      ));
    } else {
      UserPreferences().saveDBHost(hostname);
      UserPreferences().saveDBUser(username);
      UserPreferences().saveDBPassword(password);
      UserPreferences().saveDBName(dbname);
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (BuildContext context) => super.widget));
    }
  }
}
