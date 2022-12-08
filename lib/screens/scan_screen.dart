import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
//import 'package:flutter_qr_bar_scanner/qr_bar_scanner_camera.dart';
import 'package:provider/provider.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'dart:io';
import '../providers/info.dart';
import '../providers/infos.dart';
import 'information_screen.dart';

class ScanQR extends StatefulWidget {
  const ScanQR({super.key});
  static const routeName = '/scanscreen';
  // final String title;
  @override
  State<ScanQR> createState() => _ScanQRState();
}

class _ScanQRState extends State<ScanQR> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  Barcode? result;
  QRViewController? controller;
  String qrData = "No Data Found";
  var data;
  bool hasdata = false;
  qrCallback(String? code) {
    setState(() {
      hasdata = false;
      qrData = code!;
    });
  }

  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller?.resumeCamera();
    } else if (Platform.isIOS) {
      controller?.pauseCamera();
    } else if (Platform.isWindows) {
      controller?.resumeCamera();
    }
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      hasdata = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    final info = Provider.of<Infos>(context, listen: false);
    return Hero(
        tag: 'scan QR',
        child: Scaffold(
            appBar: AppBar(
              title: Text('Verify Patient'),
            ),
            body: Column(
              children: <Widget>[
                Expanded(
                  flex: 5,
                  child: QRView(key: qrKey, onQRViewCreated: _onQrViewCreated),
                ),
                SizedBox(
                  height: 10,
                ),
                Expanded(
                    flex: 2,
                    child: Center(
                      child: (result != null)
                          ? Text('Data: ${result!.code}')
                          : Text('Scan a Code'),
                    )),
                Container(
                  margin: EdgeInsets.only(bottom: 20),
                  width: (MediaQuery.of(context).size.width / 2) - 45,
                  height: 50,
                  child: FlatButton(
                      hoverColor: Color.fromARGB(255, 127, 190, 241),
                      shape: RoundedRectangleBorder(
                          side: BorderSide(
                              color: Colors.blue,
                              style: BorderStyle.solid,
                              width: 1),
                          borderRadius: BorderRadius.circular(50)),
                      onPressed: () async {
                        Future.delayed(Duration(seconds: 2)).then((_) {
                          Provider.of<Infos>(context, listen: false)
                              .fetchDetails('${result?.code.toString()}');
                          Navigator.of(context).pushNamed(InfoScreen.routeName,
                              arguments:
                                  info.findById('${result?.code.toString()}'));
                        });
                      },
                      child: Text('Fetch Details',
                          style: TextStyle(
                            fontSize: 17,
                          ))),
                ),
              ],
            )

            //  hasdata
            //     ? Center(
            //         child: SizedBox(
            //             height: 100,
            //             width: 500,
            //             child: QRBarScannerCamera(
            //               onError: (context, error) => Text(
            //                 error.toString(),
            //                 textAlign: TextAlign.center,
            //                 style: TextStyle(color: Colors.red),
            //               ),
            //               qrCodeCallback: (code) {
            //                 qrCallback(code);
            //               },
            //             )),
            //       )
            //     : Container(
            //         width: double.infinity,
            //         child: Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            // crossAxisAlignment: CrossAxisAlignment.center,
            // children: [
            //   Row(
            //     mainAxisAlignment: MainAxisAlignment.center,
            //     children: [
            //       Flexible(
            //           child: Text(
            //         "Raw Data: ${(qrData)}",
            //         textAlign: TextAlign.center,
            //         style: TextStyle(fontSize: 20),
            //       )),
            //     ],
            //   ),
            // SizedBox(
            //   height: 15,
            // ),
            // Container(
            //   width: (MediaQuery.of(context).size.width / 2) - 45,
            //   height: 50,
            //   child: FlatButton(
            //       hoverColor: Color.fromARGB(255, 127, 190, 241),
            //       shape: RoundedRectangleBorder(
            //           side: BorderSide(
            //               color: Colors.blue,
            //               style: BorderStyle.solid,
            //               width: 1),
            //           borderRadius: BorderRadius.circular(50)),
            //       onPressed: () async {
            //         Future.delayed(Duration(seconds: 2))
            //             .then((_) {
            //           Provider.of<Infos>(context, listen: false)
            //               .fetchDetails(qrData);
            //           Navigator.of(context).pushNamed(
            //               InfoScreen.routeName,
            //               arguments: info.id);
            //         });
            //       },
            //       child: Text('Fetch Details',
            //           style: TextStyle(
            //             fontSize: 17,
            //           ))),
            // ),
            // ]))));
            ));
  }

  void _onQrViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scannedData) {
      setState(() {
        result = scannedData;
      });
    });
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}

// canLaunch(String qrData) {
// }
