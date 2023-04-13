import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:weigh_bridge/models/BridgeLocationData.dart';
import 'package:weigh_bridge/models/BridgeLocationProvider.dart';
import 'package:weigh_bridge/util/Common.dart';

import '../../util/colors.dart';
import '../../util/config.dart';
import '../../util/mysql_conn.dart';
import '../appbar.dart';

class BridgeLocationListScreen extends StatefulWidget {
  @override
  State<BridgeLocationListScreen> createState() =>
      _BridgeLocationListScreenState();
}

class _BridgeLocationListScreenState extends State<BridgeLocationListScreen> {
  List<BridgeLocationData> bridgelocationData = [];
  final nameController = TextEditingController();
  var bridgelocationData1;
  var db = Mysql();
  bool isLoading = false;
  bool visible = false;

  void initState() {
    super.initState();
    getBridgeLocationData();
  }

  @override
  void dispose() {
    super.dispose();
    nameController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorSelect.white,
      appBar: appBar.getAppBar1("Bridge Location Details", context),
      body: Center(
          child: Column(
        children: [
          const SizedBox(
            height: 5,
          ),
          Expanded(
            child: isLoading == false
                ? Consumer<BridgeLocationProvider>(
                    builder: (context, provider, listTile) {
                      return ListView.builder(
                          itemCount: bridgelocationData.length!,
                          itemBuilder: (BuildContext context, int index) {
                            return ListTile(
                              title: Container(
                                decoration: const BoxDecoration(
                                    boxShadow: <BoxShadow>[
                                      BoxShadow(
                                        color: Color(0xFFE0E0E0),
                                        offset: Offset(0.5, 0.5),
                                        blurRadius: 10.0,
                                      ),
                                    ],
                                    shape: BoxShape.rectangle,
                                    color: Color(0xFFFFFFFF),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(5))),
                                //  margin: const EdgeInsets.all(2),
                                padding: const EdgeInsets.all(8),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: <Widget>[
                                        Expanded(
                                          flex: 2,
                                          child: Padding(
                                            padding: const EdgeInsets.all(0),
                                            child: RichText(
                                              text: TextSpan(
                                                children: [
                                                  const WidgetSpan(
                                                    child: Icon(
                                                      Icons.monitor_weight,
                                                      size: 14,
                                                      color:
                                                          ColorSelect.iconColor,
                                                    ),
                                                  ),
                                                  TextSpan(
                                                      text:
                                                          " ${bridgelocationData[index].location_name}",
                                                      style: const TextStyle(
                                                          color: ColorSelect
                                                              .textColor,
                                                          fontWeight:
                                                              FontWeight.bold))
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 6.0,
                                        ),
                                        // Expanded(
                                        //   flex: 2,
                                        //   child: Padding(
                                        //     padding: const EdgeInsets.all(0),
                                        //     child: RichText(
                                        //       text: TextSpan(
                                        //         children: [
                                        //           const WidgetSpan(
                                        //             child: Icon(
                                        //               Icons.location_city,
                                        //               size: 14,
                                        //               color:
                                        //               ColorSelect.iconColor,
                                        //             ),
                                        //           ),
                                        //           TextSpan(
                                        //               text:
                                        //               " ${bridgelocationData[index].created_at}",
                                        //               style: const TextStyle(
                                        //                   color: ColorSelect
                                        //                       .textColor,
                                        //                   fontWeight:
                                        //                   FontWeight.bold))
                                        //         ],
                                        //       ),
                                        //     ),
                                        //   ),
                                        // ),
                                        const SizedBox(
                                          width: 6.0,
                                        ),
                                        Expanded(
                                            flex: 1,
                                            child: GestureDetector(
                                              onTap: () {
                                                openEditAlertDialog(index);
                                              },
                                              child: Container(
                                                alignment: Alignment.topRight,
                                                child: RichText(
                                                  text: const TextSpan(
                                                    children: [
                                                      WidgetSpan(
                                                        child: Icon(
                                                          Icons.edit,
                                                          size: 24,
                                                          color: ColorSelect
                                                              .iconColor,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            )),
                                        const SizedBox(
                                          width: 6.0,
                                        ),
                                        Expanded(
                                            flex: 1,
                                            child: Visibility(
                                              child: GestureDetector(
                                                onTap: () {
                                                  openAlertDialog(index);
                                                },
                                                child: Container(
                                                  alignment: Alignment.topRight,
                                                  child: RichText(
                                                    text: const TextSpan(
                                                      children: [
                                                        WidgetSpan(
                                                          child: Icon(
                                                            Icons.delete,
                                                            size: 24,
                                                            color:
                                                                ColorSelect.red,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            )),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 8.0,
                                    ),
                                  ],
                                ),
                              ),
                            );
                          });
                    },
                  )
                : const Padding(
                    padding: EdgeInsets.only(top: 10),
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  ),
          ),
        ],
      )),
      floatingActionButton: Visibility(
        child: FloatingActionButton(
          child: const Icon(
            Icons.add,
            color: ColorSelect.white,
            size: 30,
          ),
          onPressed: () {
            openAddAlertDialog();
          },
        ),
      ),
    );
  }

  //method to get Bridge Location data
  getBridgeLocationData() async {
    setState(() {
      isLoading = true;
    });
    bridgelocationData = [];

    String sql =
        'select * from mst_bridgelocation where is_active=1 order by id asc';

    await db.getConnection().then((conn) async {
      await conn.query(sql).then((results) {
        //   print(results);
        for (var res in results) {
          //  print(res);
          BridgeLocationData BridgeLocationResponseModel = BridgeLocationData(
              id: res['id'].toString(),
              location_name: res['location_name'].toString(),
              created_at:
                  DateFormat("dd-MM-yyyy").format(res['created_at']).toString(),
              created_by: res['created_by'].toString(),
              updated_at: res['updated_at'].toString(),
              updated_by: res['updated_by'].toString(),
              company_id: res['company_id'].toString(),
              is_active: res['is_active'].toString());
          bridgelocationData.add(BridgeLocationResponseModel);
        }

        //print(bridgelocationData);
        bridgelocationData1 =
            Provider.of<BridgeLocationProvider>(context, listen: false);
        if (bridgelocationData.isNotEmpty) {
          bridgelocationData1.addDataList(bridgelocationData);
          setState(() {
            bridgelocationData = bridgelocationData;
            isLoading = false;
          });
        } else {
          bridgelocationData1.addDataList(bridgelocationData);
          setState(() {
            isLoading = false;
          });
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text("No bridge location details found"),
          ));
        }
      }).onError((error, stackTrace) {
        print(error);
        return null;
      });

      conn.close();
    });
  }

  //method to open alert dialog
  void openAlertDialog(int index) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (ctx) => AlertDialog(
                title: const Text(APP_NAME),
                content: const Text(
                    "Are you sure you want to delete this bridge location?"),
                actions: <Widget>[
                  ElevatedButton(
                    child: const Text(
                      'No',
                      style: TextStyle(color: ColorSelect.white),
                    ),
                    onPressed: () {
                      Navigator.of(ctx).pop();
                    },
                  ),
                  ElevatedButton(
                    child: const Text(
                      'Yes',
                      style: TextStyle(color: ColorSelect.white),
                    ),
                    onPressed: () {
                      deleteBridgeLocation(
                          index); //method to delete bridge location entry
                      //  Navigator.of(ctx).pop();
                    },
                  ),
                ]));
  }

  //method to delete bridge location entry
  deleteBridgeLocation(int index) async {
    String? id = bridgelocationData[index].id;
    // print("++++++++++id : $id");

    String? user_id = await Common().getUserId();

    String curdate_time = Common().getCurrentDateTime();
    await db.getConnection().then((conn) async {
      String sql =
          'update mst_bridgelocation set updated_at=?,updated_by=?,is_active=0 where id=?';

      var result = conn.query(sql, [curdate_time, user_id, id]);
      // print("result : ${result.insertId}");
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Bridge Location deleted successfully"),
      ));
      bridgelocationData1.removeData(index);
      Navigator.of(context).pop();
    });
  }

  //method to open edit alert dialog
  openAddAlertDialog() async {
    nameController.text = "";

    showDialog(
        context: context,
        barrierDismissible: true,
        builder: (ctx) => AlertDialog(
            title: const Text("Add Bridge Location"),
            content: getAlertDialog(1, 0)));
  }

  //method to submit details
  submitDetails() async {
    String name = nameController.text.trim();
    if (name.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Enter Bridge Location name"),
      ));
    } else {
      setState(() {
        visible = true;
      });
      String company_id = await Common().getCompanyId();
      String? user_id = await Common().getUserId();
      String curdate_time = Common().getCurrentDateTime();

      await db.getConnection().then((conn) async {
        String sql =
            'insert into mst_bridgelocation (location_name,created_at,created_by,company_id) values (?,?,?,?)';

        var result1 =
            await conn.query(sql, [name, curdate_time, user_id, company_id]);
        print('Inserted row id=${result1.insertId}');
        var last_id = result1.insertId;

        if (last_id != null) {
          BridgeLocationData BridgeLocationResponseModel = BridgeLocationData(
              id: last_id.toString(),
              location_name: name,
              created_at: curdate_time,
              created_by: user_id ?? "",
              updated_at: "",
              updated_by: "",
              company_id: company_id,
              is_active: "1");
          // bridgelocationData.add(BridgeLocationResponseModel);
          bridgelocationData1.addData(BridgeLocationResponseModel);

          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text("Bridge location added successfully"),
          ));
        } else {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text("Please try after some time"),
          ));
        }
        setState(() {
          visible = false;
        });
        Navigator.of(context).pop();
      });
    }
  }

  //method to open edit alert dialog
  openEditAlertDialog(int index) async {
    nameController.text = bridgelocationData[index].location_name;

    showDialog(
        context: context,
        barrierDismissible: true,
        builder: (ctx) => AlertDialog(
            title: const Text("Edit Bridge Location"),
            content: getAlertDialog(2, index)));
  }

  //method to submit details
  updateDetails(int index) async {
    String? id = bridgelocationData[index].id;

    String name = nameController.text.trim();
    if (name.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Enter Bridge Location name"),
      ));
    } else {
      setState(() {
        visible = true;
      });
      String? user_id = await Common().getUserId();
      String? curdate_time = Common().getCurrentDateTime();

      await db.getConnection().then((conn) async {
        String sql =
            'update mst_bridgelocation set location_name=?,updated_at=?,updated_by=? where id=?';

        var result = conn.query(sql, [name, curdate_time, user_id, id]);
        // print("result : ${result.insertId}");
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("Bridge Location updated successfully"),
        ));
        setState(() {
          visible = false;
        });
        bridgelocationData1.editData(index, name);
        Navigator.of(context).pop();
      });
    }
  }

  //Add or Edit dialog box function
  getAlertDialog(int type, int index) {
    var btn_text = type == 1 ? "Submit" : "Update";
    return SizedBox(
      height: 125,
      width: 400,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(5, 5, 5, 0),
              child: TextField(
                  controller: nameController,
                  //maxLength: 10,
                  inputFormatters: [
                    LengthLimitingTextInputFormatter(50),
                    FilteringTextInputFormatter.allow(RegExp("[a-z A-Z 0-9]")),
                  ],
                  decoration: InputDecoration(
                    prefixIcon: const Icon(
                      Icons.monitor_weight,
                      color: ColorSelect.iconColor,
                    ),
                    filled: true,
                    fillColor: Colors.white,
                    labelText: "Bridge Location Name *",
                    hintText: "Bridge Location Name *",
                    contentPadding:
                        const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  keyboardType: TextInputType.name),
            ),
            const SizedBox(
              height: 5.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Expanded(
                  flex: 1,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(5, 20, 5, 10),
                    child: SizedBox(
                      height: 40, //height of button
                      width: double.infinity,
                      child: ElevatedButton(
                        child: const Text('Cancel',
                            style: TextStyle(
                              color: ColorSelect.white,
                            )),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 6.0,
                ),
                Expanded(
                  flex: 1,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(5, 20, 5, 10),
                    child: SizedBox(
                      height: 40, //height of button
                      width: double.infinity,
                      child: ElevatedButton(
                        child: Text(btn_text,
                            style: const TextStyle(
                              color: ColorSelect.white,
                            )),
                        onPressed: () {
                          type == 1
                              ? submitDetails()
                              : updateDetails(
                                  index); //method to add/edit user details
                        },
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 5.0,
            ),
            Visibility(
                visible: visible,
                child: Center(
                  child: Container(
                      margin: const EdgeInsets.only(bottom: 10),
                      child: const CircularProgressIndicator()),
                )),
          ],
        ),
      ),
    );
  }
}
