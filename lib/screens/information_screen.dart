import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/infos.dart';

class InfoScreen extends StatefulWidget {
  // final String id;
  // InfoScreen(this.id);
  static const routeName = '/infoscreen';
  @override
  State<InfoScreen> createState() => _InfoScreenState();
}

class _InfoScreenState extends State<InfoScreen> {
  var _isInit = true;
  var _isLoading = false;
  var id;
  @override
  void initState() {
    super.initState();
    if (_isInit) {
      setState(() {
        _isLoading = true;
      });
      //   Future.delayed(Duration(seconds: 2)).then((_) {
      //     Provider.of<Infos>(context, listen: false).fetchDetails();
      //   });
    }
  }

  @override
  Widget build(BuildContext context) {
    final detailId = ModalRoute.of(context)!.settings.arguments as String;
    final loadedInfo =
        Provider.of<Infos>(context, listen: false).findById(detailId);
    return Scaffold(
      appBar: AppBar(title: Text(loadedInfo.name)),
      body: SingleChildScrollView(
          child: Container(
        child: Column(
          children: [
            Card(
              margin: EdgeInsets.symmetric(horizontal: 15, vertical: 4),
              child: Padding(
                  padding: EdgeInsets.all(8),
                  child: Row(
                    children: [
                      Text('Name: '),
                      SizedBox(
                        width: 10,
                      ),
                      Container(
                        child: Text('${loadedInfo.name}'),
                      )
                    ],
                  )),
            ),
            Card(
              margin: EdgeInsets.symmetric(horizontal: 15, vertical: 4),
              child: Padding(
                  padding: EdgeInsets.all(8),
                  child: Row(
                    children: [
                      Text('Phone Number: '),
                      SizedBox(
                        width: 10,
                      ),
                      Container(
                        child: Text('${loadedInfo.phone}'),
                      )
                    ],
                  )),
            ),
            Card(
              margin: EdgeInsets.symmetric(horizontal: 15, vertical: 4),
              child: Padding(
                  padding: EdgeInsets.all(8),
                  child: Row(
                    children: [
                      Text('Address: '),
                      SizedBox(
                        width: 10,
                      ),
                      Container(
                        child: Text('${loadedInfo.address}'),
                      )
                    ],
                  )),
            ),
            Card(
              margin: EdgeInsets.symmetric(horizontal: 15, vertical: 4),
              child: Padding(
                  padding: EdgeInsets.all(8),
                  child: Row(
                    children: [
                      Text('Blood Group: '),
                      SizedBox(
                        width: 10,
                      ),
                      Container(
                        child: Text('${loadedInfo.bG}'),
                      ),
                    ],
                  )),
            ),
            Card(
              margin: EdgeInsets.symmetric(horizontal: 15, vertical: 4),
              child: Padding(
                  padding: EdgeInsets.all(8),
                  child: Row(
                    children: [
                      Text('Genotype: '),
                      SizedBox(
                        width: 10,
                      ),
                      Container(
                        child: Text('${loadedInfo.genotype}'),
                      )
                    ],
                  )),
            ),
            Card(
              margin: EdgeInsets.symmetric(horizontal: 15, vertical: 4),
              child: Padding(
                  padding: EdgeInsets.all(8),
                  child: Row(
                    children: [
                      Text('Next Of Kin Details: '),
                      SizedBox(
                        width: 10,
                      ),
                      Container(
                        child: Text('${loadedInfo.nextOfKin}'),
                      )
                    ],
                  )),
            )
          ],
        ),
      )),
    );
  }
}
