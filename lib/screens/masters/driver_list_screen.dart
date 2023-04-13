import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:weigh_bridge/models/DriverData.dart';
import 'package:weigh_bridge/models/TransportData.dart';
import 'package:weigh_bridge/models/DriverProvider.dart';
import 'package:weigh_bridge/models/TransportProvider.dart';

import '../../util/Common.dart';
import '../../util/colors.dart';
import '../../util/config.dart';
import '../../util/mysql_conn.dart';
import '../appbar.dart';

class DriverListScreen extends StatefulWidget {
  @override
  State<DriverListScreen> createState() => _DriverListScreenState();
}

class _DriverListScreenState extends State<DriverListScreen> {
  List<DriverData> driverData = [];
  List<TransportData> transportData = [];
  List<String> IDprof = <String>['Aadhar', 'Voter ID'];

  final transporternameController = TextEditingController();
  final drivernameController = TextEditingController();
  final contactnoController = TextEditingController();
  final licensenoController = TextEditingController();
  final validitydateController = TextEditingController();
  final dobController = TextEditingController();

  // final photoController = TextEditingController();

  // final voteraadharController = TextEditingController();
  final voteraadharnoController = TextEditingController();

  var driverData1;
  var transportData1;
  var db = Mysql();
  bool isLoading = false;
  bool visible = false;
  String? transporter_id = null;
  String? voter_aadhar_id = null;
  String? voter_aadhar_label = null;
  int? age = null;
  int? voteraadharid = 0;
  String? dob = null;
  String? validdate = null;

  @override
  void initState() {
    super.initState();
    getTransportData();
    getDriverData();
  }

  DateTime selectedDate = DateTime.now();

  Future<void> _selectDate(BuildContext context, String type) async {
    DateTime currentDate = DateTime.now();
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: type == 'dob' ? DateTime(1950, 8) : DateTime.now(),
        lastDate: type == 'dob'
            ? DateTime.now()
            : DateTime(
                currentDate.year + 10, currentDate.month, currentDate.day));
    if (picked != null && picked != selectedDate) {
      if (type == "dob") {
        dobController.text = Common().getFormatDate(picked.toString());
        dob = Common().getFormatDate1(picked.toString());
        age = calculateAge(picked);
      } else {
        validitydateController.text = Common().getFormatDate(picked.toString());
        validdate = Common().getFormatDate1(picked.toString());
      }
    }
  }

  @override
  void dispose() {
    super.dispose();
    transporternameController.dispose();
    drivernameController.dispose();
    contactnoController.dispose();
    licensenoController.dispose();
    validitydateController.dispose();
    dobController.dispose();
    // photoController.dispose();
    // voteraadharController.dispose();
    voteraadharnoController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorSelect.white,
      appBar: appBar.getAppBar1("Driver Details", context),
      body: Center(
          child: Column(
        children: [
          const SizedBox(
            height: 5,
          ),
          Expanded(
            child: isLoading == false
                ? Consumer<DriverProvider>(
                    builder: (context, provider, listTile) {
                      return ListView.builder(
                          itemCount: driverData.length!,
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
                                                      Icons.drive_eta,
                                                      size: 14,
                                                      color:
                                                          ColorSelect.iconColor,
                                                    ),
                                                  ),
                                                  TextSpan(
                                                      text:
                                                          " Name : ${driverData[index].driver_name} ",
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
                                                      Icons.pin,
                                                      size: 14,
                                                      color:
                                                          ColorSelect.iconColor,
                                                    ),
                                                  ),
                                                  TextSpan(
                                                      text:
                                                          " Driver Code : ${driverData[index].driver_code}",
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
                                                      Icons.tty,
                                                      size: 14,
                                                      color:
                                                          ColorSelect.iconColor,
                                                    ),
                                                  ),
                                                  TextSpan(
                                                      text:
                                                          " Contact : ${driverData[index].contact_no}",
                                                      style: const TextStyle(
                                                          color: ColorSelect
                                                              .textColor))
                                                ],
                                              ),
                                            )),
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
                                                      Icons.garage,
                                                      size: 14,
                                                      color:
                                                          ColorSelect.iconColor,
                                                    ),
                                                  ),
                                                  TextSpan(
                                                      text:
                                                          " Transporter : ${driverData[index].transporter_name}",
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

  //method to get driver data
  getDriverData() async {
    setState(() {
      isLoading = true;
    });
    driverData = [];

    String sql =
        'select md.*, mt.transporter_name as transporter_name from mst_driver md left join mst_transporter mt on md.transporter_id = mt.id where md.is_active=1 order by md.id asc';

    await db.getConnection().then((conn) async {
      await conn.query(sql).then((results) {
        // print(results);
        for (var res in results) {
          //  print(res);
          DriverData driverData2 = DriverData(
              id: res['id'].toString(),
              transporter_id: res['transporter_id'].toString(),
              driver_code: res['driver_code'].toString(),
              driver_barcode: res['driver_barcode'].toString(),
              driver_name: res['driver_name'].toString(),
              contact_no: res['contact_no'].toString(),
              license_no: res['license_no'].toString(),
              validity_date: res['validity_date'].toString(),
              dob: res['dob'].toString(),
              age: res['age'].toString(),
              // photo: res['photo'].toString(),
              type: res['type'].toString(),
              aadhaar_no: res['aadhaar_no'].toString(),
              voter_id: res['voter_id'].toString(),
              transporter_name: res['transporter_name'].toString());
          driverData.add(driverData2);
        }

        //print(supplierData);
        driverData1 = Provider.of<DriverProvider>(context, listen: false);
        if (driverData.isNotEmpty) {
          driverData1.addDataList(driverData);
          setState(() {
            driverData = driverData;
            isLoading = false;
          });
        } else {
          driverData1.addDataList(driverData);
          setState(() {
            isLoading = false;
          });
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text("No driver details found"),
          ));
        }
      }).onError((error, stackTrace) {
        print(error);

        return null;
      });

      conn.close();
    });
  }

  getAlertDialog(int type, int index) {
    var btn_text = type == 1 ? "Submit" : "Update";
    return SizedBox(
      height: 320,
      width: 500,
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
                      child: Consumer<TransportProvider>(
                          builder: (context, provider, listTile) {
                        return Container(
                          height: 48,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                              color: Colors.grey,
                              style: BorderStyle.solid,
                            ),
                          ),
                          // padding: const EdgeInsets.fromLTRB(8, 10, 8, 0),
                          width: MediaQuery.of(context).size.width * 1,
                          child: DropdownButtonHideUnderline(
                            child: ButtonTheme(
                              alignedDropdown: true,
                              child: DropdownButton(
                                hint: const Text("Select Transporter *"),
                                value: transporter_id != null
                                    ? transporter_id
                                    : null,
                                items: transportData.map((item1) {
                                  return DropdownMenuItem(
                                    value:
                                        '${item1.id}/${item1.transporter_name}',
                                    child: Text(item1
                                        .transporter_name!), //value of item
                                  );
                                }).toList(),
                                onChanged: (String? newValue) {
                                  // var val = newValue!.substring(0, newValue!.indexOf('/'));
                                  // print("++++++++++newValue : " + newValue!);
                                  setState(() {
                                    transporter_id = newValue!;
                                    transporternameController.text = newValue!
                                        .substring(newValue!.indexOf('/') + 1);
                                  });
                                  //method to get block data
                                },
                                // style: Theme.of(context).textTheme.bodySmall,
                              ),
                            ),
                          ),
                        );
                      }),
                    ),
                  ),
                  const SizedBox(
                    width: 6.0,
                  ),
                  Expanded(
                    flex: 1,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(5, 5, 5, 0),
                      child: TextField(
                          controller: drivernameController,
                          //maxLength: 10,
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(50),
                            FilteringTextInputFormatter.allow(
                                RegExp("[a-zA-Z0-9 ]")),
                          ],
                          decoration: InputDecoration(
                            prefixIcon: const Icon(
                              Icons.emoji_transportation,
                              color: ColorSelect.iconColor,
                            ),
                            filled: true,
                            fillColor: Colors.white,
                            labelText: "Driver Name *",
                            hintText: "Driver Name *",
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
                          controller: contactnoController,
                          //maxLength: 10,
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(10),
                            FilteringTextInputFormatter.allow(RegExp("[0-9]")),
                          ],
                          decoration: InputDecoration(
                            prefixIcon: const Icon(
                              Icons.phone_iphone,
                              color: ColorSelect.iconColor,
                            ),
                            filled: true,
                            fillColor: Colors.white,
                            labelText: "Contact Number *",
                            hintText: "Contact Number *",
                            contentPadding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 5),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          keyboardType: TextInputType.name),
                    ),
                  ),
                  const SizedBox(
                    width: 6.0,
                  ),
                  Expanded(
                    flex: 1,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(5, 5, 5, 0),
                      child: TextField(
                          onTap: () => _selectDate(context, "dob"),
                          readOnly: true,
                          controller: dobController,
                          //maxLength: 10,
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(20),
                          ],
                          decoration: InputDecoration(
                            prefixIcon: const Icon(
                              Icons.event,
                              color: ColorSelect.iconColor,
                            ),
                            filled: true,
                            fillColor: Colors.white,
                            labelText: "Date Of Birth",
                            hintText: "Date Of Birth",
                            contentPadding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 5),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          keyboardType: TextInputType.number),
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
                          controller: licensenoController,
                          //maxLength: 10,
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(30),
                            FilteringTextInputFormatter.allow(
                                RegExp("[a-zA-Z0-9 ]")),
                          ],
                          decoration: InputDecoration(
                            prefixIcon: const Icon(
                              Icons.looks_one,
                              color: ColorSelect.iconColor,
                            ),
                            filled: true,
                            fillColor: Colors.white,
                            labelText: "License Number *",
                            hintText: "License Number *",
                            contentPadding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 5),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          keyboardType: TextInputType.name),
                    ),
                  ),
                  const SizedBox(
                    width: 6.0,
                  ),
                  Expanded(
                    flex: 1,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(5, 5, 5, 0),
                      child: TextField(
                          onTap: () => _selectDate(context, "valid"),
                          readOnly: true,
                          controller: validitydateController,
                          //maxLength: 10,
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(20),
                          ],
                          decoration: InputDecoration(
                            prefixIcon: const Icon(
                              Icons.event_available,
                              color: ColorSelect.iconColor,
                            ),
                            filled: true,
                            fillColor: Colors.white,
                            labelText: "Validity Date",
                            hintText: "Validity Date",
                            contentPadding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 5),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          keyboardType: TextInputType.number),
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
                      child: Consumer<TransportProvider>(
                          builder: (context, provider, listTile) {
                        return Container(
                          height: 48,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                              color: Colors.grey,
                              style: BorderStyle.solid,
                            ),
                          ),
                          // padding: const EdgeInsets.fromLTRB(8, 10, 8, 0),
                          width: MediaQuery.of(context).size.width * 1,
                          child: DropdownButtonHideUnderline(
                            child: ButtonTheme(
                              alignedDropdown: true,
                              child: DropdownButton(
                                hint: const Text("Select ID Proof"),
                                value: voter_aadhar_id != null
                                    ? voter_aadhar_id
                                    : null,
                                items: IDprof.map((item1) {
                                  return DropdownMenuItem(
                                    value: item1,
                                    child: Text(item1), //value of item
                                  );
                                }).toList(),
                                onChanged: (String? newValue) {
                                  // var val = newValue!.substring(0, newValue!.indexOf('/'));
                                  // print("++++++++++newValue : " + newValue!);
                                  setState(() {
                                    voter_aadhar_id = newValue!;
                                    voter_aadhar_label = '$newValue Number';
                                    if (newValue == 'Aadhar') {
                                      voteraadharid = 1;
                                    } else {
                                      voteraadharid = 2;
                                    }
                                  });
                                  //method to get block data
                                },
                                // style: Theme.of(context).textTheme.bodySmall,
                              ),
                            ),
                          ),
                        );
                      }),
                    ),
                  ),
                  const SizedBox(
                    width: 6.0,
                  ),
                  Expanded(
                    flex: 1,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(5, 5, 5, 0),
                      child: TextField(
                          controller: voteraadharnoController,
                          //maxLength: 10,
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(20),
                            FilteringTextInputFormatter.allow(
                                RegExp("[a-zA-Z0-9]")),
                          ],
                          decoration: InputDecoration(
                            prefixIcon: const Icon(
                              Icons.pin,
                              color: ColorSelect.iconColor,
                            ),
                            filled: true,
                            fillColor: Colors.white,
                            labelText: voter_aadhar_label ?? 'ID Proof Number',
                            hintText: voter_aadhar_label ?? 'ID Proof Number',
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
                      padding: const EdgeInsets.fromLTRB(5, 10, 5, 10),
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
                      padding: const EdgeInsets.fromLTRB(5, 10, 5, 10),
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
          );
        }),
      ),
    );
  }

  //method to open edit alert dialog
  openAddAlertDialog() async {
    transporternameController.text = "";
    drivernameController.text = "";
    contactnoController.text = "";
    licensenoController.text = "";
    validitydateController.text = "";
    dobController.text = "";
    // photoController.text = "";
    // voteraadharController.text = "";
    voteraadharnoController.text = "";
    transporter_id = null;
    voter_aadhar_id = null;
    voter_aadhar_label = null;
    age = null;
    voteraadharid = 0;
    dob = null;
    validdate = null;

    showDialog(
        context: context,
        barrierDismissible: true,
        builder: (ctx) => AlertDialog(
            title: const Text("Add Driver"), content: getAlertDialog(1, 0)));
  }

  //method to calculate age
  calculateAge(DateTime birthDate) {
    DateTime currentDate = DateTime.now();
    int age = currentDate.year - birthDate.year;
    int month1 = currentDate.month;
    int month2 = birthDate.month;
    if (month2 > month1) {
      age--;
    } else if (month1 == month2) {
      int day1 = currentDate.day;
      int day2 = birthDate.day;
      if (day2 > day1) {
        age--;
      }
    }
    return age;
  }

  //method to add driver details
  submitDetails() async {
    var transid = transporter_id != null
        ? transporter_id!.substring(0, transporter_id!.indexOf('/'))
        : '';
    String transportername = transporternameController.text.trim();
    String drivername = drivernameController.text.trim();
    String contactno = contactnoController.text.trim();
    String dobval = dobController.text.trim();
    String licenseno = licensenoController.text.trim();
    String validitydate = validitydateController.text.trim();
    // String? voteraadharid = voteraadharController.text.trim();
    // int? voteraadhar = voteraadharid != null ? 1 : 0;
    String voteraadharno = voteraadharnoController.text.trim();
    String? transporterid = transid;
    // String weighbridgelocation = weighbridgelocationController.text.trim();

    if (drivername.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Enter driver name"),
      ));
    } else if (contactno.isEmpty || contactno.length < 10) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Enter valid contact number"),
      ));
    } else if (dobval.isNotEmpty && age! < 18) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Select Valid Date Of Birth"),
      ));
    } else if (voteraadharid != 0 && voteraadharno.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Enter ID proof number"),
      ));
    } else if (transporterid.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Select transporter"),
      ));
    } else {
      setState(() {
        visible = true;
      });

      String company_id = await Common().getCompanyId();
      String user_id = await Common().getUserId();
      String curdate_time = Common().getCurrentDateTime();

      await db.getConnection().then((conn) async {
        String sql =
            'insert into mst_driver (transporter_id,driver_name,contact_no,license_no,validity_date,dob,age,type,aadhaar_no,voter_id,created_at,created_by,company_id,is_active) values (?,?,?,?,?,?,?,?,?,?,?,?,?,?)';
        var last_id = 0;
        var result1 = await conn.query(sql, [
          transporterid,
          drivername,
          contactno,
          licenseno,
          validdate,
          dob,
          age,
          voteraadharid,
          voteraadharid == 1 ? voteraadharno : "",
          voteraadharid == 2 ? voteraadharno : "",
          curdate_time,
          user_id,
          company_id,
          1
        ]);
        print('Inserted row id=${result1.insertId}');
        last_id = result1.insertId!;

        if (last_id != null) {
          String driver_code = "DRIV";
          if (last_id < 10) {
            driver_code = "${driver_code}0$last_id";
          } else {
            driver_code = driver_code + (last_id.toString());
          }

          String driver_barcode = "BAR$driver_code${Common().getDate()}";
          String sql =
              'update mst_driver set driver_code=?,driver_barcode=? where id=?';

          var result = conn.query(sql, [driver_code, driver_barcode, last_id]);

          DriverData driverData2 = DriverData(
              id: last_id.toString(),
              transporter_id: transporterid,
              driver_code: driver_code,
              driver_barcode: driver_barcode,
              driver_name: drivername,
              contact_no: contactno,
              license_no: licenseno,
              validity_date: validitydate,
              dob: dobval,
              age: age == null ? '' : age.toString(),
              // photo: "",
              type: voteraadharid.toString(),
              aadhaar_no: voteraadharid == 1 ? voteraadharno : "",
              voter_id: voteraadharid == 2 ? voteraadharno : "",
              transporter_name: transportername);

          driverData1.addData(driverData2);

          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text("Driver added successfully"),
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
    transporternameController.text = driverData[index].transporter_name;
    drivernameController.text = driverData[index].driver_name;
    contactnoController.text = driverData[index].contact_no;
    licensenoController.text = driverData[index].license_no;
    validitydateController.text = driverData[index].validity_date == 'null'
        ? ''
        : Common().getFormatDate3(driverData[index].validity_date.toString());
    dobController.text = driverData[index].dob == 'null'
        ? ''
        : Common().getFormatDate3(driverData[index].dob.toString());
    // photoController.text = "";
    // voteraadharController.text = "";
    voteraadharnoController.text = driverData[index].type == '1'
        ? driverData[index].aadhaar_no
        : driverData[index].voter_id;
    transporter_id =
        '${driverData[index].transporter_id}/${driverData[index].transporter_name}';
    voter_aadhar_id = driverData[index].type == '1'
        ? "Aadhar"
        : driverData[index].type == '2'
            ? "Voter ID"
            : null;
    voter_aadhar_label = driverData[index].type == '1'
        ? "Aadhar Number"
        : driverData[index].type == '2'
            ? "Voter ID Number"
            : null;
    age = int.parse(
        driverData[index].age == 'null' ? '0' : driverData[index].age);
    voteraadharid = driverData[index].type == '1'
        ? 1
        : driverData[index].type == '2'
            ? 2
            : 0;
    dob = driverData[index].dob;
    validdate = driverData[index].validity_date;

    showDialog(
        context: context,
        barrierDismissible: true,
        builder: (ctx) => AlertDialog(
            title: const Text("Edit Driver"),
            content: getAlertDialog(2, index)));
  }

  // //method to update supplier details
  updateDetails(int index) async {
    String? id = driverData[index].id;
    var transid = transporter_id != null
        ? transporter_id!.substring(0, transporter_id!.indexOf('/'))
        : '';
    String transportername = transporternameController.text.trim();
    String drivername = drivernameController.text.trim();
    String contactno = contactnoController.text.trim();
    String dobval = dobController.text.trim();
    String licenseno = licensenoController.text.trim();
    String validitydate = validitydateController.text.trim();
    // String? voteraadharid = voteraadharController.text.trim();
    // int? voteraadhar = voteraadharid != null ? 1 : 0;
    String voteraadharno = voteraadharnoController.text.trim();
    String? transporterid = transid;
    // String weighbridgelocation = weighbridgelocationController.text.trim();

    if (drivername.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Enter driver name"),
      ));
    } else if (contactno.isEmpty || contactno.length < 10) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Enter valid contact number"),
      ));
    } else if (dobval.isNotEmpty && age! < 18) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Select Valid Date Of Birth"),
      ));
    } else if (voteraadharid != 0 && voteraadharno.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Enter ID proof number"),
      ));
    } else if (transporterid.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Select transporter"),
      ));
    } else {
      setState(() {
        visible = true;
      });

      String user_id = await Common().getUserId();
      String curdate_time = Common().getCurrentDateTime();

      await db.getConnection().then((conn) async {
        String sql =
            'update mst_driver set transporter_id=?,driver_name=?,contact_no=?,license_no=?,validity_date=?,dob=?,age=?,type=?,aadhaar_no=?,voter_id=?,updated_at=?,updated_by=? where id=?';

        var result = conn.query(sql, [
          transporterid,
          drivername,
          contactno,
          licenseno,
          validdate ?? '',
          dob,
          age,
          voteraadharid,
          voteraadharid == 1 ? voteraadharno : "",
          voteraadharid == 2 ? voteraadharno : "",
          curdate_time,
          user_id,
          id
        ]);

        // print("result : ${result.last}");
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("Driver details updated successfully"),
        ));
        setState(() {
          visible = false;
        });
        driverData1.editData(
            index,
            transporterid,
            drivername,
            contactno,
            licenseno,
            validdate,
            dob,
            age.toString(),
            voteraadharid.toString(),
            voteraadharid == 1 ? voteraadharno : "",
            voteraadharid == 2 ? voteraadharno : "",
            transportername);
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
                content:
                    const Text("Are you sure you want to delete this driver ?"),
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
                      deleteDriver(index); //method to delete driver entry
                      //  Navigator.of(ctx).pop();
                    },
                  ),
                ]));
  }

  //method to delete driver entry
  deleteDriver(int index) async {
    String? id = driverData[index].id;
    // print("++++++++++id : $id");

    String? user_id = await Common().getUserId();

    String curdate_time = Common().getCurrentDateTime();
    await db.getConnection().then((conn) async {
      String sql =
          'update mst_driver set updated_at=?,updated_by=?,is_active=0 where id=?';

      var result = conn.query(sql, [curdate_time, user_id, id]);
      // print("result : ${result.insertId}");
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Driver deleted successfully"),
      ));
      driverData1.removeData(index);
      Navigator.of(context).pop();
    });
  }

  getTransportData() async {
    transportData = [];

    String sql =
        'select * from mst_transporter where is_active=1 order by transporter_name asc';

    await db.getConnection().then((conn) async {
      await conn.query(sql).then((results) {
        //   print(results);
        for (var res in results) {
          //  print(res);
          TransportData TransporterResponseModel = TransportData(
              id: res['id'].toString(),
              transporter_code: res['transporter_code'].toString(),
              transporter_name: res['transporter_name'].toString(),
              transporter_person: res['transporter_person'].toString(),
              transporter_contact: res['transporter_contact'].toString(),
              transporter_email: res['transporter_email'].toString(),
              transporter_address: res['transporter_address'].toString(),
              is_active: res['is_active'].toString());
          transportData.add(TransporterResponseModel);
        }

        transportData1 = Provider.of<TransportProvider>(context, listen: false);
        if (transportData.isNotEmpty) {
          transportData1.transportList(transportData);
          setState(() {
            transportData = transportData;
          });
        } else {
          transportData1.transportList(transportData);
        }
      }).onError((error, stackTrace) {
        print(error);
        return null;
      });

      conn.close();
    });
  }
}
