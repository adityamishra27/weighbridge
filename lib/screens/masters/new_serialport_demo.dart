import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:serial_port_win32/serial_port_win32.dart';

class NewSerialportDemo extends StatefulWidget {
  @override
  State<NewSerialportDemo> createState() => _NewSerialportDemoState();
}

class _NewSerialportDemoState extends State<NewSerialportDemo> {
  var ports = <String>[];
  late SerialPort port;

  final sendData = Uint8List.fromList(List.filled(4, 1, growable: false));

  String data = '';

  void _getPortsAndOpen() {
    ports = SerialPort.getAvailablePorts();
    print(ports);
    if (ports.isNotEmpty) {
      port = SerialPort(ports[0],
          openNow: false, ReadIntervalTimeout: 1, ReadTotalTimeoutConstant: 2);
      port.open();
      print(port.isOpened);
      port.readBytesOnListen(9, (value) {
        data = value.toString();
        print(data);
        setState(() {});
      });
    }
    setState(() {});
    // setState(() {
    //   ports = SerialPort.getAvailablePorts();
    // });
  }

  void _send() {
    // print(sendData);
    // print(port.writeBytesFromUint8List(sendData));

    String buffer = "hello";
    // port.writeBytesFromString(buffer);

    print('Written Bytes : ${port.writeBytesFromString(buffer)}');

    port.readBytesOnListen(8, (value) => print(value.toString()));
// or
    port.readOnListenFunction = (value) {
      print(value);
    };
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: const Text("Serial Port"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              ports.toString(),
              style: Theme.of(context).textTheme.headline4,
            ),
            Text(data),
            ElevatedButton(
              onPressed: () {
                port.close();
              },
              child: const Text("close"),
            ),
            ElevatedButton(
              onPressed: () {
                _send();
              },
              child: const Text("write"),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _getPortsAndOpen,
        tooltip: 'GetPorts',
        child: const Icon(Icons.search),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
