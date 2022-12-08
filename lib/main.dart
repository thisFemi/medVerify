import 'package:flutter/material.dart';
import 'package:medverify/providers/infos.dart';

import 'package:medverify/screens/code_screen.dart';
import 'package:medverify/screens/generator_screen.dart';
import 'package:medverify/screens/information_screen.dart';
import 'package:medverify/screens/scan_screen.dart';
import 'package:provider/provider.dart';

import 'screens/homepage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  var _mydata = '';
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: Infos()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        routes: {
          MyHomePage.routeName: (ctx) => MyHomePage(),
          ScanQR.routeName: (ctx) => ScanQR(),
          QRGenerator.routeName: (ctx) => QRGenerator(),
          QRCode.routeName: (ctx) => QRCode(_mydata),
          InfoScreen.routeName: (ctx) => InfoScreen()
        },
        title: 'Group Project',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: MyHomePage(),
      ),
    );
  }
}
