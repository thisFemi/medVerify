import 'package:flutter/material.dart';
import 'package:medverify/screens/generator_screen.dart';
import 'package:medverify/screens/scan_screen.dart';

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});
  static const routeName = '/homepage';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(title: Text("medVerify")),
      body: Container(
        height: MediaQuery.of(context).size.height,
        child: SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(
                minHeight: (MediaQuery.of(context).size.height) -
                    AppBar().preferredSize.height -
                    kToolbarHeight),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CircleAvatar(
                    backgroundImage: AssetImage(
                      "assets/images/QR.jpg",
                    ),
                    foregroundColor: Colors.transparent,
                    backgroundColor: Colors.transparent,
                    radius: 150),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Hero(
                        tag: "Scan QR",
                        child: Container(
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
                                onPressed: () {
                                  Navigator.of(context)
                                      .pushNamed(ScanQR.routeName);
                                },
                                child: Text('Scan QR')))),
                    SizedBox(
                      width: 25,
                    ),
                    Container(
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
                            onPressed: () {
                              Navigator.of(context)
                                  .pushNamed(QRGenerator.routeName);
                            },
                            child: Text('Generate QR'))),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
