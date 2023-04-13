import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:weigh_bridge/models/CustomerData.dart';
import 'package:weigh_bridge/models/CustomerProvider.dart';

import '../../util/Common.dart';
import '../../util/colors.dart';
import '../../util/config.dart';
import '../../util/mysql_conn.dart';
import '../appbar.dart';

class CustomerListScreen extends StatefulWidget {
  @override
  State<CustomerListScreen> createState() => _CustomerListScreenState();
}

class _CustomerListScreenState extends State<CustomerListScreen> {
  List<CustomerData> customerData = [];
  final customernameController = TextEditingController();
  final mobileController = TextEditingController();
  final gstnoController = TextEditingController();
  final addressController = TextEditingController();

  var customerData1;
  var db = Mysql();
  bool isLoading = false;
  bool visible = false;

  void initState() {
    super.initState();

    getCustomerData(); //method to get customer data
  }

  @override
  void dispose() {
    super.dispose();
    customernameController.dispose();
    mobileController.dispose();
    gstnoController.dispose();
    addressController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorSelect.white,
      appBar: appBar.getAppBar1("Customer Details", context),
      body: Center(
          child: Column(
        children: [
          const SizedBox(
            height: 5,
          ),
          Expanded(
            child: isLoading == false
                ? Consumer<CustomerProvider>(
                    builder: (context, provider, listTile) {
                      return ListView.builder(
                          itemCount: customerData.length!,
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
                                                      Icons.person,
                                                      size: 14,
                                                      color:
                                                          ColorSelect.iconColor,
                                                    ),
                                                  ),
                                                  TextSpan(
                                                      text:
                                                          " ${customerData[index].customer_name} ",
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
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: <Widget>[
                                        Expanded(
                                          flex: 1,
                                          child: Padding(
                                            padding: const EdgeInsets.all(0),
                                            child: RichText(
                                              text: TextSpan(
                                                children: [
                                                  const WidgetSpan(
                                                    child: Icon(
                                                      Icons.phone_android,
                                                      size: 14,
                                                      color:
                                                          ColorSelect.iconColor,
                                                    ),
                                                  ),
                                                  TextSpan(
                                                      text:
                                                          " ${customerData[index].contact_no}",
                                                      style: const TextStyle(
                                                        color: ColorSelect
                                                            .textColor,
                                                      ))
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 6.0,
                                        ),
                                        Expanded(
                                            flex: 1,
                                            child: RichText(
                                              text: TextSpan(
                                                children: [
                                                  const WidgetSpan(
                                                    child: Icon(
                                                      Icons.confirmation_number,
                                                      size: 14,
                                                      color:
                                                          ColorSelect.iconColor,
                                                    ),
                                                  ),
                                                  TextSpan(
                                                      text:
                                                          " GST :  ${customerData[index].gst_no}",
                                                      style: const TextStyle(
                                                          color: ColorSelect
                                                              .textColor))
                                                ],
                                              ),
                                            )),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 8.0,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: <Widget>[
                                        Expanded(
                                          flex: 1,
                                          child: Padding(
                                            padding: const EdgeInsets.all(0),
                                            child: RichText(
                                              text: TextSpan(
                                                children: [
                                                  const WidgetSpan(
                                                    child: Icon(
                                                      Icons.home,
                                                      size: 14,
                                                      color:
                                                          ColorSelect.iconColor,
                                                    ),
                                                  ),
                                                  TextSpan(
                                                      text:
                                                          " Address : ${customerData[index].address != "null" ? customerData[index].address : ""}",
                                                      style: const TextStyle(
                                                        color: ColorSelect
                                                            .textColor,
                                                      ))
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 6.0,
                                        ),
                                        // Expanded(
                                        //     flex: 1,
                                        //     child: RichText(
                                        //       text: TextSpan(
                                        //         children: [
                                        //           const WidgetSpan(
                                        //             child: Icon(
                                        //               Icons.home,
                                        //               size: 14,
                                        //               color:
                                        //                   ColorSelect.iconColor,
                                        //             ),
                                        //           ),
                                        //           TextSpan(
                                        //               text:
                                        //                   " Address : ${customerData[index].transporter_address}",
                                        //               style: const TextStyle(
                                        //                   color: ColorSelect
                                        //                       .textColor))
                                        //         ],
                                        //       ),
                                        //     )),
                                      ],
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

  //method to get customer data
  getCustomerData() async {
    setState(() {
      isLoading = true;
    });
    customerData = [];

    String sql =
        'select * from mst_customer where is_active=1 order by id desc';

    await db.getConnection().then((conn) async {
      await conn.query(sql).then((results) {
        //   print(results);
        for (var res in results) {
          //  print(res);
          CustomerData customerData2 = CustomerData(
              id: res['id'].toString(),
              customer_name: res['customer_name'].toString(),
              contact_no: res['contact_no'].toString(),
              gst_no: res['gst_no'].toString(),
              address: res['address'].toString(),
              created_by: res['created_by'].toString(),
              created_at: res['created_at'].toString(),
              updated_at: res['updated_at'].toString(),
              updated_by: res['updated_by'].toString(),
              company_id: res['company_id'].toString(),
              is_active: res['is_active'].toString());
          customerData.add(customerData2);
        }

        //print(departmentData);
        customerData1 = Provider.of<CustomerProvider>(context, listen: false);
        if (customerData.isNotEmpty) {
          customerData1.addDataList(customerData);
          setState(() {
            customerData = customerData;
            isLoading = false;
          });
        } else {
          customerData1.addDataList(customerData);
          setState(() {
            isLoading = false;
          });
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text("No customer details found"),
          ));
        }
      }).onError((error, stackTrace) {
        print(error);

        return null;
      });

      conn.close();
    });
  }

  //method to open edit alert dialog
  openAddAlertDialog() async {
    customernameController.text = "";
    mobileController.text = "";
    gstnoController.text = "";
    addressController.text = "";

    showDialog(
        context: context,
        barrierDismissible: true,
        builder: (ctx) => AlertDialog(
            title: const Text("Add Customer"), content: getAlertDialog(1, 0)));
  }

  getAlertDialog(int type, int index) {
    var btn_text = type == 1 ? "Submit" : "Update";
    return SizedBox(
      height: 300,
      width: 400,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(5, 5, 5, 0),
              child: TextField(
                  controller: customernameController,
                  //maxLength: 10,
                  inputFormatters: [
                    LengthLimitingTextInputFormatter(50),
                    FilteringTextInputFormatter.allow(RegExp("[a-z A-Z]")),
                  ],
                  decoration: InputDecoration(
                    prefixIcon: const Icon(
                      Icons.person,
                      color: ColorSelect.iconColor,
                    ),
                    filled: true,
                    fillColor: Colors.white,
                    labelText: "Customer Name *",
                    hintText: "Customer Name *",
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
            Padding(
              padding: const EdgeInsets.fromLTRB(5, 5, 5, 0),
              child: TextField(
                  controller: mobileController,
                  //maxLength: 10,
                  inputFormatters: [
                    LengthLimitingTextInputFormatter(10),
                    FilteringTextInputFormatter.allow(RegExp("[0-9]")),
                  ],
                  decoration: InputDecoration(
                    prefixIcon: const Icon(
                      Icons.phone_android,
                      color: ColorSelect.iconColor,
                    ),
                    filled: true,
                    fillColor: Colors.white,
                    labelText: "Contact Number *",
                    hintText: "Contact Number *",
                    contentPadding:
                        const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  keyboardType: TextInputType.number),
            ),
            const SizedBox(
              height: 5.0,
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(5, 5, 5, 0),
              child: TextField(
                  controller: gstnoController,
                  //maxLength: 10,
                  inputFormatters: [
                    LengthLimitingTextInputFormatter(15),
                    FilteringTextInputFormatter.allow(RegExp("[a-zA-Z0-9]")),
                  ],
                  decoration: InputDecoration(
                    prefixIcon: const Icon(
                      Icons.confirmation_number,
                      color: ColorSelect.iconColor,
                    ),
                    filled: true,
                    fillColor: Colors.white,
                    labelText: "GST Number *",
                    hintText: "GST Number *",
                    contentPadding:
                        const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  keyboardType: TextInputType.emailAddress),
            ),
            const SizedBox(
              height: 5.0,
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(5, 5, 5, 0),
              child: TextField(
                  controller: addressController,
                  //maxLength: 10,
                  inputFormatters: [
                    LengthLimitingTextInputFormatter(100),
                    FilteringTextInputFormatter.allow(RegExp("[a-zA-Z -.0-9]")),
                  ],
                  decoration: InputDecoration(
                    prefixIcon: const Icon(
                      Icons.home,
                      color: ColorSelect.iconColor,
                    ),
                    filled: true,
                    fillColor: Colors.white,
                    labelText: "Address",
                    hintText: "Address",
                    contentPadding:
                        const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  keyboardType: TextInputType.streetAddress),
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

  //method to add customer details
  submitDetails() async {
    String customername = customernameController.text.trim();
    String mobile = mobileController.text.trim();
    String gstno = gstnoController.text.trim();
    String address = addressController.text.trim();

    if (customername.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Enter customer name"),
      ));
    } else if (gstno.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Enter GST number"),
      ));
    } else if (mobile.isEmpty || mobile.length < 10) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Enter valid contact number"),
      ));
    } else {
      setState(() {
        visible = true;
      });

      String company_id = await Common().getCompanyId();
      String user_id = await Common().getUserId();
      String curdate_time = Common().getCurrentDateTime();
      String isactive = '1';

      await db.getConnection().then((conn) async {
        String sql =
            'insert into mst_customer (customer_name,contact_no,gst_no,address,created_at,created_by,company_id,is_active) values (?,?,?,?,?,?,?,?)';
        var last_id = 0;
        var result1 = await conn.query(sql, [
          customername,
          mobile,
          gstno,
          address,
          curdate_time,
          user_id,
          company_id,
          isactive
        ]);
        print('Inserted row id=${result1.insertId}');
        last_id = result1.insertId!;

        if (last_id != null) {
          CustomerData customerData2 = CustomerData(
              id: last_id.toString(),
              customer_name: customername,
              contact_no: mobile,
              gst_no: gstno,
              address: address,
              created_at: curdate_time,
              created_by: user_id,
              updated_at: "",
              updated_by: "",
              company_id: company_id,
              is_active: '1');

          // customerData.add(customerData2);
          customerData1.addData(customerData2);

          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text("Customer added successfully"),
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
    customernameController.text = customerData[index].customer_name;
    mobileController.text = customerData[index].contact_no;
    gstnoController.text = customerData[index].gst_no;
    addressController.text = customerData[index].address;

    showDialog(
        context: context,
        barrierDismissible: true,
        builder: (ctx) => AlertDialog(
            title: const Text("Edit Customer"),
            content: getAlertDialog(2, index)));
  }

  //method to update customer details
  updateDetails(int index) async {
    String? id = customerData[index].id;

    String customername = customernameController.text.trim();
    String mobile = mobileController.text.trim();
    String gstno = gstnoController.text.trim();
    String address = addressController.text.trim();

    if (customername.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Enter customer name"),
      ));
    } else if (gstno.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Enter GST number"),
      ));
    } else if (mobile.isEmpty || mobile.length < 10) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Enter valid contact number"),
      ));
    } else {
      setState(() {
        visible = true;
      });

      String user_id = await Common().getUserId();
      String curdate_time = Common().getCurrentDateTime();

      await db.getConnection().then((conn) async {
        String sql =
            'update mst_customer set customer_name=?,contact_no=?,gst_no=?,address=?,updated_at=?,updated_by=? where id=?';

        var result = conn.query(sql,
            [customername, mobile, gstno, address, curdate_time, user_id, id]);
        // print("result : ${result.insertId}");
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("Customer details updated successfully"),
        ));
        setState(() {
          visible = false;
        });
        customerData1.editData(index, customername, mobile, gstno, address);
        Navigator.of(context).pop();
      });
    }
  }

  //method to open alert dialog
  void openAlertDialog(int index) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (ctx) => AlertDialog(
                title: const Text(APP_NAME),
                content: const Text(
                    "Are you sure you want to delete this customer?"),
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
                      deleteCustomer(index); //method to delete department entry
                      //  Navigator.of(ctx).pop();
                    },
                  ),
                ]));
  }

  //method to delete customer entry
  deleteCustomer(int index) async {
    String? id = customerData[index].id;
    // print("++++++++++id : $id");

    String? user_id = await Common().getUserId();

    String curdate_time = Common().getCurrentDateTime();
    await db.getConnection().then((conn) async {
      String sql =
          'update mst_customer set updated_at=?,updated_by=?,is_active=0 where id=?';

      var result = conn.query(sql, [curdate_time, user_id, id]);
      // print("result : ${result.insertId}");
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Customer deleted successfully"),
      ));
      customerData1.removeData(index);
      Navigator.of(context).pop();
    });
  }
}
