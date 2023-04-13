import 'package:flutter/material.dart';
import 'package:weigh_bridge/screens/dashboard.dart';
import 'package:weigh_bridge/screens/masters/bridgelocation_list_screen.dart';
import 'package:weigh_bridge/screens/masters/customer_list_screen.dart';
import 'package:weigh_bridge/screens/masters/department_list_screen.dart';
import 'package:weigh_bridge/screens/masters/driver_list_screen.dart';
import 'package:weigh_bridge/screens/masters/product_list_screen.dart';
import 'package:weigh_bridge/screens/masters/supplier_list_screen.dart';
import 'package:weigh_bridge/screens/masters/termscondition_list_screen.dart';
import 'package:weigh_bridge/screens/masters/transport_list_screen.dart';
import 'package:weigh_bridge/screens/masters/truck_list_screen.dart';
import 'package:weigh_bridge/screens/masters/unit_list_screen.dart';
import 'package:weigh_bridge/screens/masters/weigh_bridge_list_screen.dart';
import 'package:weigh_bridge/screens/report/invoice_report_screen.dart';
import 'package:weigh_bridge/screens/report/pending_report_screen.dart';
import 'package:weigh_bridge/screens/report/weighment_report_screen.dart';
import 'package:weigh_bridge/screens/weighment_screen.dart';

import '../shared_preference/UserPreferences.dart';
import '../util/colors.dart';
import 'login_screen.dart';
import 'masters/users.dart';

class AppDrawer {
  static getAppDrawer(BuildContext context, bool master_visible,
      bool weighment_visible, String user_name) {
    return Drawer(
      child: Container(
        color: ColorSelect.colorPrimaryDark,
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: const BoxDecoration(
                color: Colors.white,
              ),
              child: Column(
                children: [
                  Image.asset(
                    'assets/images/logo2.png',
                    height: 110,
                    width: 150,
                  ),
                  const SizedBox(
                    height: 2,
                  ),
                  Center(
                    child: Text("Welcome $user_name",
                        style: const TextStyle(
                            color: ColorSelect.colorPrimary,
                            fontWeight: FontWeight.bold,
                            fontSize: 16)),
                  ),
                ],
              ),
            ),
            ListTile(
              leading: const Icon(
                Icons.home,
                color: ColorSelect.white,
              ),
              title: const Text(
                "Home",
                style: TextStyle(
                  color: ColorSelect.white,
                ),
              ),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => DashboardScreen()));
              },
            ),
            Visibility(
              visible: master_visible,
              child: ExpansionTile(
                collapsedIconColor: ColorSelect.white,
                iconColor: ColorSelect.white,
                leading: const Icon(
                  Icons.settings_applications,
                  color: ColorSelect.white,
                ),
                title: const Text(
                  "Masters",
                  style: TextStyle(
                    color: ColorSelect.white,
                  ),
                ),
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: ListTile(
                      dense: true,
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 5),
                      visualDensity:
                          const VisualDensity(horizontal: 0, vertical: -4),
                      title: const Text(
                        'Department',
                        style: TextStyle(
                          color: ColorSelect.white,
                        ),
                      ),
                      leading: const Icon(
                        Icons.location_city,
                        color: ColorSelect.white,
                        size: 18,
                      ),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => DepartmentListScreen()));
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: ListTile(
                      dense: true,
                      // minLeadingWidth: 10,
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 5),
                      visualDensity:
                          const VisualDensity(horizontal: 0, vertical: -4),
                      title: const Text(
                        'Transporter',
                        style: TextStyle(
                          color: ColorSelect.white,
                        ),
                      ),
                      leading: const Icon(
                        Icons.emoji_transportation,
                        color: ColorSelect.white,
                        size: 18,
                      ),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => TransportListScreen()));
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: ListTile(
                      dense: true,
                      // minLeadingWidth: 10,
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 5),
                      visualDensity:
                          const VisualDensity(horizontal: 0, vertical: -4),
                      title: const Text(
                        'Truck',
                        style: TextStyle(
                          color: ColorSelect.white,
                        ),
                      ),
                      leading: const Icon(
                        Icons.fire_truck,
                        color: ColorSelect.white,
                        size: 18,
                      ),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => TruckListScreen()));
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: ListTile(
                      dense: true,
                      // minLeadingWidth: 10,
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 5),
                      visualDensity:
                          const VisualDensity(horizontal: 0, vertical: -4),
                      title: const Text(
                        'Driver',
                        style: TextStyle(
                          color: ColorSelect.white,
                        ),
                      ),
                      leading: const Icon(
                        Icons.drive_eta_rounded,
                        color: ColorSelect.white,
                        size: 18,
                      ),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => DriverListScreen()));
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: ListTile(
                      dense: true,
                      // minLeadingWidth: 10,
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 5),
                      visualDensity:
                          const VisualDensity(horizontal: 0, vertical: -4),
                      title: const Text(
                        'Product',
                        style: TextStyle(
                          color: ColorSelect.white,
                        ),
                      ),
                      leading: const Icon(
                        Icons.production_quantity_limits,
                        color: ColorSelect.white,
                        size: 18,
                      ),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ProductListScreen()));
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: ListTile(
                      dense: true,
                      // minLeadingWidth: 10,
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 5),
                      visualDensity:
                          const VisualDensity(horizontal: 0, vertical: -4),
                      title: const Text(
                        'Supplier',
                        style: TextStyle(
                          color: ColorSelect.white,
                        ),
                      ),
                      leading: const Icon(
                        Icons.person_pin_sharp,
                        color: ColorSelect.white,
                        size: 18,
                      ),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SupplierListScreen()));
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: ListTile(
                      dense: true,
                      // minLeadingWidth: 10,
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 5),
                      visualDensity:
                          const VisualDensity(horizontal: 0, vertical: -4),
                      title: const Text(
                        'Customer',
                        style: TextStyle(
                          color: ColorSelect.white,
                        ),
                      ),
                      leading: const Icon(
                        Icons.supervised_user_circle_outlined,
                        color: ColorSelect.white,
                        size: 18,
                      ),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => CustomerListScreen()));
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: ListTile(
                      dense: true,
                      // minLeadingWidth: 10,
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 5),
                      visualDensity:
                          const VisualDensity(horizontal: 0, vertical: -4),
                      title: const Text(
                        'Unit',
                        style: TextStyle(
                          color: ColorSelect.white,
                        ),
                      ),
                      leading: const Icon(
                        Icons.ac_unit_sharp,
                        color: ColorSelect.white,
                        size: 18,
                      ),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => UnitListScreen()));
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: ListTile(
                      dense: true,
                      // minLeadingWidth: 10,
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 5),
                      visualDensity:
                          const VisualDensity(horizontal: 0, vertical: -4),
                      title: const Text(
                        'Weighbridge',
                        style: TextStyle(
                          color: ColorSelect.white,
                        ),
                      ),
                      leading: const Icon(
                        Icons.monitor_weight,
                        color: ColorSelect.white,
                        size: 18,
                      ),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => WeighBridgeListScreen()));
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: ListTile(
                      dense: true,
                      // minLeadingWidth: 10,
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 5),
                      visualDensity:
                          const VisualDensity(horizontal: 0, vertical: -4),
                      title: const Text(
                        'Bridge Location',
                        style: TextStyle(
                          color: ColorSelect.white,
                        ),
                      ),
                      leading: const Icon(
                        Icons.location_on,
                        color: ColorSelect.white,
                        size: 18,
                      ),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    BridgeLocationListScreen()));
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: ListTile(
                      dense: true,
                      // minLeadingWidth: 10,
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 5),
                      visualDensity:
                          const VisualDensity(horizontal: 0, vertical: -4),
                      title: const Text(
                        'Users',
                        style: TextStyle(
                          color: ColorSelect.white,
                        ),
                      ),
                      leading: const Icon(
                        Icons.supervised_user_circle_sharp,
                        color: ColorSelect.white,
                        size: 18,
                      ),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => UserListScreen()));
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: ListTile(
                      dense: true,
                      // minLeadingWidth: 10,
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 5),
                      visualDensity:
                          const VisualDensity(horizontal: 0, vertical: -4),
                      title: const Text(
                        'Terms and Conditions',
                        style: TextStyle(
                          color: ColorSelect.white,
                        ),
                      ),
                      leading: const Icon(
                        Icons.star,
                        color: ColorSelect.white,
                        size: 18,
                      ),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => TermsListScreen()));
                      },
                    ),
                  ),
                ],
              ),
            ),
            ExpansionTile(
              collapsedIconColor: ColorSelect.white,
              iconColor: ColorSelect.white,
              leading: const Icon(
                Icons.list_alt,
                color: ColorSelect.white,
              ),
              title: const Text(
                "Reports",
                style: TextStyle(
                  color: ColorSelect.white,
                ),
              ),
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: ListTile(
                    dense: true,
                    contentPadding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
                    visualDensity:
                        const VisualDensity(horizontal: 0, vertical: -4),
                    title: const Text(
                      'Weighment Report',
                      style: TextStyle(
                        color: ColorSelect.white,
                      ),
                    ),
                    leading: const Icon(
                      Icons.line_weight,
                      color: ColorSelect.white,
                      size: 18,
                    ),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => WeighmentReportScreen()));
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: ListTile(
                    dense: true,
                    // minLeadingWidth: 10,
                    contentPadding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
                    visualDensity:
                        const VisualDensity(horizontal: 0, vertical: -4),
                    title: const Text(
                      'Invoice Report',
                      style: TextStyle(
                        color: ColorSelect.white,
                      ),
                    ),
                    leading: const Icon(
                      Icons.request_page_outlined,
                      color: ColorSelect.white,
                      size: 18,
                    ),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => InvoiceReportScreen()));
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: ListTile(
                    dense: true,
                    // minLeadingWidth: 10,
                    contentPadding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
                    visualDensity:
                        const VisualDensity(horizontal: 0, vertical: -4),
                    title: const Text(
                      'Pending Report',
                      style: TextStyle(
                        color: ColorSelect.white,
                      ),
                    ),
                    leading: const Icon(
                      Icons.request_page_outlined,
                      color: ColorSelect.white,
                      size: 18,
                    ),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => PendingReportScreen()));
                    },
                  ),
                ),
              ],
            ),
            Visibility(
              visible: weighment_visible,
              child: ListTile(
                leading: const Icon(
                  Icons.monitor_weight,
                  color: ColorSelect.white,
                ),
                title: const Text(
                  "Weighment",
                  style: TextStyle(
                    color: ColorSelect.white,
                  ),
                ),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => WeighmentScreen()));
                },
              ),
            ),
            ListTile(
              leading: const Icon(
                Icons.logout,
                color: ColorSelect.white,
              ),
              title: const Text(
                "Logout",
                style: TextStyle(
                  color: ColorSelect.white,
                ),
              ),
              onTap: () {
                UserPreferences().removeUser();
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => LoginScreen()));
              },
            ),
          ],
        ),
      ),
    );
  }
}
