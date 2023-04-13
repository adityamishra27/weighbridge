import 'dart:ui';

import 'package:flutter/material.dart';
//import 'package:scrollable_table_view/scrollable_table_view.dart';

import 'package:horizontal_data_table/horizontal_data_table.dart';
import 'package:provider/provider.dart';
import 'package:weigh_bridge/models/DashboardData.dart';
import 'package:weigh_bridge/models/DashboardProvider.dart';
import 'package:weigh_bridge/shared_preference/UserPreferences.dart';

import '../util/Common.dart';
import '../util/config.dart';
import '../util/colors.dart';
import '../util/mysql_conn.dart';
import 'dart:math' as math;

import 'drawer.dart';

class DashboardScreen extends StatefulWidget {
  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  List<PreviousWeighData> previousData = [];
  List<PendingWeighData> pendingData = [];

  var truckinward;
  var truckoutward;
  var trucktotal;
  var materialinward;
  var materialoutward;
  var materialtotal;
  var db = Mysql();
  bool isLoading = false;
  bool visible = false;
  var pendingData1;
  var previousData1;

  bool master_visible = false;
  bool weighment_visible = false;
  String user_name = "User";

  void initState() {
    super.initState();

    getUserData(); //method to get user details
    getCounts();
    getPendingData();
    getPreviousData();
  }

  //method to get user details
  getUserData() async {
    String? role_id = await Common().getRoleId();
    String? user_name1 = await UserPreferences().getUserName();

    if (role_id == "1") {
      setState(() {
        master_visible = true;
        weighment_visible = false;
        user_name = user_name1!;
      });
    } else {
      setState(() {
        master_visible = false;
        weighment_visible = true;
        user_name = user_name1!;
      });
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: ColorSelect.white,
        appBar: AppBar(
          title: const Text(
            APP_NAME,
            style: TextStyle(color: ColorSelect.white),
          ),
          iconTheme: const IconThemeData(color: ColorSelect.white),
        ),
        drawer: AppDrawer.getAppDrawer(
            context, master_visible, weighment_visible, user_name),
        body: SingleChildScrollView(
          child: isLoading == false
              ? Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(
                            height: 20,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.02,
                              ),
                              Expanded(
                                child: Container(
                                  // color: Color(0xFFff5733),
                                  alignment: Alignment.center,
                                  padding: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFff6d37),
                                    borderRadius: const BorderRadius.only(
                                        topLeft: Radius.circular(7),
                                        topRight: Radius.circular(7),
                                        bottomLeft: Radius.circular(7),
                                        bottomRight: Radius.circular(7)),
                                    boxShadow: [
                                      BoxShadow(
                                        color: const Color(0xFFffb99f)
                                            .withOpacity(0.7),
                                        spreadRadius: 3,
                                        blurRadius: 7,
                                        offset: const Offset(
                                            0, 3), // changes position of shadow
                                      ),
                                    ],
                                  ),
                                  child: InkWell(
                                    onTap: () {
                                      // openAlertDialog();
                                    },
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Transform(
                                          alignment: Alignment.center,
                                          transform: Matrix4.rotationY(math.pi),
                                          child: const Icon(
                                              Icons.local_shipping,
                                              size: 50,
                                              color: Colors.white),
                                        ),
                                        Text(truckinward ?? '0',
                                            maxLines: 1,
                                            style: const TextStyle(
                                                fontSize: 20,
                                                color: ColorSelect.white)),
                                        const Text("Today InWard Truck\n",
                                            maxLines: 1,
                                            style: TextStyle(
                                                fontSize: 20,
                                                color: ColorSelect.white,
                                                fontWeight: FontWeight.bold)),
                                        const SizedBox(
                                          height: 5.0,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.02,
                              ),
                              Expanded(
                                child: Container(
                                  // color: Color(0xFFff5733),
                                  alignment: Alignment.center,
                                  padding: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFe99e41),
                                    borderRadius: const BorderRadius.only(
                                        topLeft: Radius.circular(7),
                                        topRight: Radius.circular(7),
                                        bottomLeft: Radius.circular(7),
                                        bottomRight: Radius.circular(7)),
                                    boxShadow: [
                                      BoxShadow(
                                        color: const Color(0xFFfdd891)
                                            .withOpacity(0.7),
                                        spreadRadius: 3,
                                        blurRadius: 7,
                                        offset: const Offset(
                                            0, 3), // changes position of shadow
                                      ),
                                    ],
                                  ),
                                  child: InkWell(
                                    onTap: () {
                                      // openAlertDialog();
                                    },
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        const Icon(Icons.local_shipping,
                                            size: 50, color: Colors.white),
                                        Text(truckoutward ?? '0',
                                            maxLines: 1,
                                            style: const TextStyle(
                                                fontSize: 20,
                                                color: ColorSelect.white)),
                                        const Text("Today OutWard Truck\n",
                                            maxLines: 1,
                                            style: TextStyle(
                                                fontSize: 20,
                                                color: ColorSelect.white,
                                                fontWeight: FontWeight.bold)),
                                        const SizedBox(
                                          height: 5.0,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.02,
                              ),
                              Expanded(
                                child: Container(
                                  // color: Color(0xFFff5733),
                                  alignment: Alignment.center,
                                  padding: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFC70039),
                                    borderRadius: const BorderRadius.only(
                                        topLeft: Radius.circular(7),
                                        topRight: Radius.circular(7),
                                        bottomLeft: Radius.circular(7),
                                        bottomRight: Radius.circular(7)),
                                    boxShadow: [
                                      BoxShadow(
                                        color: const Color(0xFFf78aa9)
                                            .withOpacity(0.7),
                                        spreadRadius: 3,
                                        blurRadius: 7,
                                        offset: const Offset(
                                            0, 3), // changes position of shadow
                                      ),
                                    ],
                                  ),
                                  child: InkWell(
                                    onTap: () {
                                      // openAlertDialog();
                                    },
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        const Icon(Icons.directions_bus_filled,
                                            size: 50, color: Colors.white),
                                        Text(trucktotal ?? '0',
                                            maxLines: 1,
                                            style: const TextStyle(
                                                fontSize: 20,
                                                color: ColorSelect.white)),
                                        const Text("Total Truck\n",
                                            maxLines: 1,
                                            style: TextStyle(
                                                fontSize: 20,
                                                color: ColorSelect.white,
                                                fontWeight: FontWeight.bold)),
                                        const SizedBox(
                                          height: 5.0,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.02,
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.02,
                              ),
                              Expanded(
                                child: Container(
                                  // color: Color(0xFFff5733),
                                  alignment: Alignment.center,
                                  padding: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    color: const Color(0xFF69e3bf),
                                    borderRadius: const BorderRadius.only(
                                        topLeft: Radius.circular(7),
                                        topRight: Radius.circular(7),
                                        bottomLeft: Radius.circular(7),
                                        bottomRight: Radius.circular(7)),
                                    boxShadow: [
                                      BoxShadow(
                                        color: const Color(0xFFb9f2e5)
                                            .withOpacity(0.7),
                                        spreadRadius: 3,
                                        blurRadius: 7,
                                        offset: const Offset(
                                            0, 3), // changes position of shadow
                                      ),
                                    ],
                                  ),
                                  child: InkWell(
                                    onTap: () {
                                      // openAlertDialog();
                                    },
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Transform(
                                          alignment: Alignment.center,
                                          transform: Matrix4.rotationY(math.pi),
                                          child: const Icon(Icons.inventory_2,
                                              size: 50, color: Colors.white),
                                        ),
                                        Text(materialinward ?? '0',
                                            maxLines: 1,
                                            style: const TextStyle(
                                                fontSize: 20,
                                                color: ColorSelect.white)),
                                        const Text("Today InWard Material\n",
                                            maxLines: 1,
                                            style: TextStyle(
                                                fontSize: 20,
                                                color: ColorSelect.white,
                                                fontWeight: FontWeight.bold)),
                                        const SizedBox(
                                          height: 5.0,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.02,
                              ),
                              Expanded(
                                child: Container(
                                  // color: Color(0xFFff5733),
                                  alignment: Alignment.center,
                                  padding: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFeb5774),
                                    borderRadius: const BorderRadius.only(
                                        topLeft: Radius.circular(7),
                                        topRight: Radius.circular(7),
                                        bottomLeft: Radius.circular(7),
                                        bottomRight: Radius.circular(7)),
                                    boxShadow: [
                                      BoxShadow(
                                        color: const Color(0xFFf292af)
                                            .withOpacity(0.7),
                                        spreadRadius: 3,
                                        blurRadius: 7,
                                        offset: const Offset(
                                            0, 3), // changes position of shadow
                                      ),
                                    ],
                                  ),
                                  child: InkWell(
                                    onTap: () {
                                      // openAlertDialog();
                                    },
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        const Icon(Icons.analytics,
                                            size: 50, color: Colors.white),
                                        Text(materialoutward ?? '0',
                                            maxLines: 1,
                                            style: const TextStyle(
                                                fontSize: 20,
                                                color: ColorSelect.white)),
                                        const Text("Today OutWard Material\n",
                                            maxLines: 1,
                                            style: TextStyle(
                                                fontSize: 20,
                                                color: ColorSelect.white,
                                                fontWeight: FontWeight.bold)),
                                        const SizedBox(
                                          height: 5.0,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.02,
                              ),
                              Expanded(
                                child: Container(
                                  // color: Color(0xFFff5733),
                                  alignment: Alignment.center,
                                  padding: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    color: const Color(0xFF7da2f3),
                                    borderRadius: const BorderRadius.only(
                                        topLeft: Radius.circular(7),
                                        topRight: Radius.circular(7),
                                        bottomLeft: Radius.circular(7),
                                        bottomRight: Radius.circular(7)),
                                    boxShadow: [
                                      BoxShadow(
                                        color: const Color(0xFFa7cff6)
                                            .withOpacity(0.7),
                                        spreadRadius: 3,
                                        blurRadius: 7,
                                        offset: const Offset(
                                            0, 3), // changes position of shadow
                                      ),
                                    ],
                                  ),
                                  child: InkWell(
                                    onTap: () {
                                      // openAlertDialog();
                                    },
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        const Icon(Icons.space_dashboard,
                                            size: 50, color: Colors.white),
                                        Text(
                                            materialtotal.toString() != "null"
                                                ? materialtotal.toString()
                                                : "0",
                                            maxLines: 1,
                                            style: const TextStyle(
                                                fontSize: 20,
                                                color: ColorSelect.white)),
                                        const Text("Total Material Weighted\n",
                                            maxLines: 1,
                                            style: TextStyle(
                                                fontSize: 20,
                                                color: ColorSelect.white,
                                                fontWeight: FontWeight.bold)),
                                        const SizedBox(
                                          height: 5.0,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.02,
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.02,
                              ),
                              Expanded(
                                child: ScrollConfiguration(
                                  behavior: ScrollConfiguration.of(context)
                                      .copyWith(dragDevices: {
                                    PointerDeviceKind.touch,
                                    PointerDeviceKind.mouse,
                                  }),
                                  child: Column(
                                    children: [
                                      const Text(
                                        "Previous Weighment List",
                                        style: TextStyle(
                                            color: ColorSelect.colorPrimary,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16),
                                      ),
                                      const SizedBox(
                                        height: 5.0,
                                      ),
                                      Container(
                                        padding: const EdgeInsets.all(10),
                                        height:
                                            MediaQuery.of(context).size.width *
                                                0.28,
                                        // width: 500,
                                        decoration: BoxDecoration(
                                          border:
                                              Border.all(color: Colors.black),
                                          borderRadius: const BorderRadius.only(
                                              topLeft: Radius.circular(5),
                                              topRight: Radius.circular(5),
                                              bottomLeft: Radius.circular(5),
                                              bottomRight: Radius.circular(5)),
                                        ),

                                        child: HorizontalDataTable(
                                          leftHandSideColumnWidth: 100,
                                          rightHandSideColumnWidth: 700,
                                          isFixedHeader: true,
                                          headerWidgets:
                                              _getPreviousTitleWidget(),
                                          leftSideItemBuilder:
                                              _generatePreviousFirstColumnRow,
                                          rightSideItemBuilder:
                                              _generatePreviousRightHandSideColumnRow,
                                          itemCount: previousData.length,
                                          rowSeparatorWidget: const Divider(
                                            color: Colors.black54,
                                            height: 1.0,
                                            thickness: 0.0,
                                          ),
                                          leftHandSideColBackgroundColor:
                                              const Color(0xFFFFFFFF),
                                          rightHandSideColBackgroundColor:
                                              const Color(0xFFFFFFFF),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.02,
                              ),
                              Expanded(
                                child: ScrollConfiguration(
                                  behavior: ScrollConfiguration.of(context)
                                      .copyWith(dragDevices: {
                                    PointerDeviceKind.touch,
                                    PointerDeviceKind.mouse,
                                  }),
                                  child: Column(
                                    children: [
                                      const Text(
                                        "Pending Weighment List",
                                        style: TextStyle(
                                            color: ColorSelect.colorPrimary,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16),
                                      ),
                                      const SizedBox(
                                        height: 5.0,
                                      ),
                                      Container(
                                        padding: const EdgeInsets.all(10),
                                        height:
                                            MediaQuery.of(context).size.width *
                                                0.28,
                                        // width: 500,
                                        decoration: BoxDecoration(
                                          border:
                                              Border.all(color: Colors.black),
                                          borderRadius: const BorderRadius.only(
                                              topLeft: Radius.circular(5),
                                              topRight: Radius.circular(5),
                                              bottomLeft: Radius.circular(5),
                                              bottomRight: Radius.circular(5)),
                                        ),
                                        child: HorizontalDataTable(
                                          leftHandSideColumnWidth: 100,
                                          rightHandSideColumnWidth: 700,
                                          isFixedHeader: true,
                                          headerWidgets:
                                              _getPendingTitleWidget(),
                                          leftSideItemBuilder:
                                              _generatePendingFirstColumnRow,
                                          rightSideItemBuilder:
                                              _generatePendingRightHandSideColumnRow,
                                          itemCount: pendingData.length,
                                          rowSeparatorWidget: const Divider(
                                            color: Colors.black54,
                                            height: 1.0,
                                            thickness: 0.0,
                                          ),
                                          leftHandSideColBackgroundColor:
                                              const Color(0xFFFFFFFF),
                                          rightHandSideColBackgroundColor:
                                              const Color(0xFFFFFFFF),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.02,
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                        ],
                      ),
                    ),
                  ],
                )
              : const Padding(
                  padding: EdgeInsets.only(top: 10),
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                ),
        ));
  }

  getCounts() async {
    setState(() {
      isLoading = true;
    });
    TruckCounts(1, '');
    TruckCounts(2, '');
    TruckCounts('', 'truck_no');
    MaterialCounts(1, 'serial_no');
    MaterialCounts(2, 'serial_no');
    MaterialCounts('', '');

    setState(() {
      isLoading = false;
    });
  }

  TruckCounts(entrytype, groupby) async {
    String role_id = await Common().getRoleId();
    String company_id = await Common().getCompanyId();
    String location_id = await Common().getLocationId();
    String weighbridge_id = await Common().getWeighbridgeId();
    String curdate_date = Common().getCurrentDate();

    String sql =
        'SELECT count(wl.truck_no) as count FROM weighment_log wl WHERE ';
    if (entrytype != '') {
      sql += 'wl.Entrytype = "$entrytype" AND ';
    }
    if (role_id == 2) {
      sql += 'wl.location_id = "$location_id" AND ';
    } else if (role_id == 3) {
      sql +=
          'wl.location_id = "$location_id" AND wl.weighbridge_id = "$weighbridge_id" AND ';
    }
    sql +=
        'wl.company_id = "$company_id" AND cast(wl.created_at as date) BETWEEN "$curdate_date" AND "$curdate_date" ';
    if (groupby != '') {
      sql += 'GROUP BY wl.$groupby ';
    }
    sql += 'ORDER BY weighment_id DESC';

    await db.getConnection().then((conn) async {
      await conn.query(sql).then((results) {
        for (var res in results) {
          setState(() {
            if (entrytype == 1) {
              truckinward = res['count'].toString();
            } else if (entrytype == 2) {
              truckoutward = res['count'].toString();
            } else if (entrytype == '') {
              trucktotal = res['count'].toString();
            }
          });
        }
      }).onError((error, stackTrace) {
        print(error);
        return null;
      });
      conn.close();
    });
  }

  MaterialCounts(entrytype, groupby) async {
    String role_id = await Common().getRoleId();
    String company_id = await Common().getCompanyId();
    String location_id = await Common().getLocationId();
    String weighbridge_id = await Common().getWeighbridgeId();
    String curdate_date = Common().getCurrentDate();

    String sql =
        'SELECT sum(wl.net_weight) as sum FROM weighment_log wl JOIN (SELECT serial_no, MAX(log_id) log_id FROM weighment_log GROUP BY serial_no) as t2 ON wl.log_id = t2.log_id AND wl.serial_no = t2.serial_no WHERE ';
    if (entrytype == 1) {
      sql += 'wl.datetime_tare > wl.datetime_gross AND ';
    } else if (entrytype == 2) {
      sql += 'wl.datetime_tare < wl.datetime_gross AND ';
    } else if (entrytype == "") {
      sql += 'wl.datetime_gross != "" AND wl.datetime_tare != "" AND ';
    }
    if (role_id == 2) {
      sql += 'wl.location_id = "$location_id" AND ';
    } else if (role_id == 3) {
      sql +=
          'wl.location_id = "$location_id" AND wl.weighbridge_id = "$weighbridge_id" AND ';
    }
    sql +=
        'wl.company_id = "$company_id" AND cast(wl.created_at as date) BETWEEN "$curdate_date" AND "$curdate_date" ';
    if (groupby != '') {
      sql += 'GROUP BY wl.$groupby ';
    }
    sql += 'ORDER BY weighment_id DESC';

    await db.getConnection().then((conn) async {
      await conn.query(sql).then((results) {
        for (var res in results) {
          setState(() {
            if (entrytype == 1) {
              materialinward = res['sum'].toString();
            } else if (entrytype == 2) {
              materialoutward = res['sum'].toString();
            } else if (entrytype == '') {
              materialtotal = res['sum'];
            }
          });
        }
      }).onError((error, stackTrace) {
        // print(error);
        return null;
      });
      conn.close();
      // print(materialtotal);
    });
  }

  getPendingData() async {
    String company_id = await Common().getCompanyId();
    pendingData = [];

    String sql =
        'SELECT weighment_id, serial_no, truck_no, gross_weight, net_weight, tare_weight, remark FROM weighment WHERE (gross_weight =0 OR tare_weight =0) AND company_id = "$company_id"';

    await db.getConnection().then((conn) async {
      await conn.query(sql).then((results) {
        //   print(results);
        for (var res in results) {
          //  print(res);
          PendingWeighData pendingData2 = PendingWeighData(
              weighment_id: res['weighment_id'].toString(),
              serial_no: res['serial_no'].toString(),
              truck_no: res['truck_no'].toString(),
              gross_weight: res['gross_weight'].toString(),
              tare_weight: res['tare_weight'].toString(),
              net_weight: res['net_weight'].toString(),
              remark: res['remark'].toString());
          pendingData.add(pendingData2);
        }

        //print(productData);
        pendingData1 = Provider.of<DashboardProvider>(context, listen: false);
        if (pendingData.isNotEmpty) {
          pendingData1.addPendingDataList(pendingData);
          setState(() {
            pendingData = pendingData;
          });
        } else {
          pendingData1.addPendingDataList(pendingData);
        }
      }).onError((error, stackTrace) {
        //print(error);

        return null;
      });

      conn.close();
    });
  }

  getPreviousData() async {
    previousData = [];

    String sql =
        'SELECT serial_no, truck_no, remark, gross_weight, tare_weight, net_weight FROM view_weighment_log ORDER BY log_id DESC LIMIT 10';

    await db.getConnection().then((conn) async {
      await conn.query(sql).then((results) {
        //   print(results);
        for (var res in results) {
          //  print(res);
          PreviousWeighData previousData2 = PreviousWeighData(
              serial_no: res['serial_no'].toString(),
              truck_no: res['truck_no'].toString(),
              gross_weight: res['gross_weight'].toString(),
              tare_weight: res['tare_weight'].toString(),
              net_weight: res['net_weight'].toString(),
              remark: res['remark'].toString());
          previousData.add(previousData2);
        }

        //print(productData);
        previousData1 = Provider.of<DashboardProvider>(context, listen: false);
        if (previousData.isNotEmpty) {
          previousData1.addPreviousDataList(previousData);
          setState(() {
            previousData = previousData;
          });
        } else {
          previousData1.addPreviousDataList(previousData);
        }
      }).onError((error, stackTrace) {
        print(error);

        return null;
      });

      conn.close();
    });
  }

  List<Widget> _getPendingTitleWidget() {
    return [
      _getTitleItemWidget('Serial No.', 100),
      _getTitleItemWidget('Truck No.', 100),
      _getTitleItemWidget('Gross', 100),
      _getTitleItemWidget('Tare', 100),
      _getTitleItemWidget('Net', 100),
      _getTitleItemWidget('Remark', 200),
    ];
  }

  Widget _getTitleItemWidget(String label, double width) {
    return Container(
      width: width,
      height: 56,
      padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
      alignment: Alignment.centerLeft,
      child: Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
    );
  }

  Widget _generatePendingFirstColumnRow(BuildContext context, int index) {
    return Container(
      width: 100,
      height: 52,
      padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
      alignment: Alignment.centerLeft,
      child: Text(pendingData[index].serial_no.toString()),
    );
  }

  Widget _generatePendingRightHandSideColumnRow(
      BuildContext context, int index) {
    return Row(
      children: <Widget>[
        Container(
          width: 100,
          height: 52,
          padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
          alignment: Alignment.centerLeft,
          child: Text(pendingData[index].truck_no.toString()),
        ),
        Container(
          width: 100,
          height: 52,
          padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
          alignment: Alignment.centerLeft,
          child: Text(pendingData[index].gross_weight.toString()),
        ),
        Container(
          width: 100,
          height: 52,
          padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
          alignment: Alignment.centerLeft,
          child: Text(pendingData[index].tare_weight.toString()),
        ),
        Container(
          width: 100,
          height: 52,
          padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
          alignment: Alignment.centerLeft,
          child: Text(pendingData[index].net_weight.toString()),
        ),
        Container(
          width: 200,
          height: 52,
          padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
          alignment: Alignment.centerLeft,
          child: Text(pendingData[index].remark.toString()),
        ),
      ],
    );
  }

  List<Widget> _getPreviousTitleWidget() {
    return [
      _getTitleItemWidget('Serial No.', 100),
      _getTitleItemWidget('Truck No.', 100),
      _getTitleItemWidget('Gross', 100),
      _getTitleItemWidget('Tare', 100),
      _getTitleItemWidget('Net', 100),
      _getTitleItemWidget('Remark', 200),
    ];
  }

  Widget _generatePreviousFirstColumnRow(BuildContext context, int index) {
    return Container(
      width: 100,
      height: 52,
      padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
      alignment: Alignment.centerLeft,
      child: Text(previousData[index].serial_no.toString()),
    );
  }

  Widget _generatePreviousRightHandSideColumnRow(
      BuildContext context, int index) {
    return Row(
      children: <Widget>[
        Container(
          width: 100,
          height: 52,
          padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
          alignment: Alignment.centerLeft,
          child: Text(previousData[index].truck_no.toString()),
        ),
        Container(
          width: 100,
          height: 52,
          padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
          alignment: Alignment.centerLeft,
          child: Text(previousData[index].gross_weight.toString()),
        ),
        Container(
          width: 100,
          height: 52,
          padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
          alignment: Alignment.centerLeft,
          child: Text(previousData[index].tare_weight.toString()),
        ),
        Container(
          width: 100,
          height: 52,
          padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
          alignment: Alignment.centerLeft,
          child: Text(previousData[index].net_weight.toString()),
        ),
        Container(
          width: 200,
          height: 52,
          padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
          alignment: Alignment.centerLeft,
          child: Text(previousData[index].remark.toString()),
        ),
      ],
    );
  }
}
