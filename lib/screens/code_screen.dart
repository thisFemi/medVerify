import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class QRCode extends StatefulWidget {
  final String? myQR;
  const QRCode(this.myQR);
  static const routeName = '/qr_code';

  @override
  State<QRCode> createState() => _QRCodeState();
}

class _QRCodeState extends State<QRCode> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Generated QR"),
        ),
        body: Center(
          child: QrImage(
              data: widget.myQR,
              version: QrVersions.auto,
              size: 250.0,
              gapless: false),
        ));
  }
}
