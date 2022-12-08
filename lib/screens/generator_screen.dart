import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:medverify/providers/info.dart';
import 'package:medverify/providers/infos.dart';
import 'package:medverify/screens/code_screen.dart';
import 'package:provider/provider.dart';

import '../utils/validation_functions.dart';

class QRGenerator extends StatefulWidget {
  const QRGenerator({super.key});
  static const routeName = '/qrgenerator';

  @override
  State<QRGenerator> createState() => _QRGeneratorState();
}

class _QRGeneratorState extends State<QRGenerator> {
  final _phoneFocusNode = FocusNode();
  final _addressFocusNode = FocusNode();
  var _bGDropdownValue = '0+';
  var _genotypeDropdownValue = 'AA';
  final _bGFocusNode = FocusNode();
  final _genotypeFocusNode = FocusNode();
  final _nextOfKinFocusNode = FocusNode();
  final _formkey = GlobalKey<FormState>();
  var _editedInfo = Info(
      address: '',
      bG: '',
      genotype: '',
      id: null,
      name: '',
      phone: '',
      nextOfKin: '');

  var _initValues = {
    'name': '',
    'address': '',
    'bG': '',
    'genotype': '',
    'nextOfKin': '',
    'phone': ''
  };
  var _isInit = true;
  var _isLoading = false;
  bool _editForm = false;

  Future<void> _saveForm() async {
    final isValid = _formkey.currentState!.validate();
    if (!isValid) {
      return;
    }
    _formkey.currentState!.save();
    setState(() {
      _isLoading = true;
    });
    if (_editedInfo.id != null) {
      Provider.of<Infos>(context, listen: false)
          .updateDetails(_editedInfo.id, _editedInfo);
    } else {
      try {
        Center(child: CircularProgressIndicator());
        await Provider.of<Infos>(context, listen: false)
            .addDetails(_editedInfo);
      } catch (error) {
        await showDialog<void>(
            context: context,
            builder: (_) => AlertDialog(
                  title: Text('An Error Occured'),
                  content: Text('Something went wrong'),
                  actions: [
                    ElevatedButton(
                        onPressed: () => Navigator.of(context).pop(),
                        child: Text('Okay'))
                  ],
                ));
      }
    }
    setState(() {
      _isLoading = false;
    });
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => QRCode(_editedInfo.phone)));
  }

  void navigate() {
    // print(mycontroller.text);
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => QRCode(_editedInfo.id)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Patient Registration'),
      ),
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Container(
              padding: EdgeInsets.only(left: 10, right: 10, top: 20),
              child: SingleChildScrollView(
                child: Form(
                    key: _formkey,
                    child: ListView(
                      shrinkWrap: true,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: TextFormField(
                                initialValue: _initValues['name'],
                                decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(5),
                                        borderSide: BorderSide(
                                            color: Color.fromARGB(
                                                255, 70, 182, 201))),
                                    disabledBorder: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(5.00),
                                        borderSide: BorderSide(
                                            color: Color.fromARGB(
                                                255, 70, 182, 201))),
                                    errorStyle: TextStyle(
                                      color: Colors.red,
                                      fontSize: 15.0,
                                    ),
                                    prefixIcon: Icon(Icons.person),
                                    labelText: "Full Name",
                                    hintStyle: TextStyle(
                                        color: Colors.grey, fontSize: 15)),
                                textInputAction: TextInputAction.next,
                                onFieldSubmitted: (_) {
                                  FocusScope.of(context)
                                      .requestFocus(_phoneFocusNode);
                                },
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Please Enter Your Name';
                                  }
                                },
                                onSaved: (value) {
                                  _editedInfo = Info(
                                      address: _editedInfo.address,
                                      bG: _editedInfo.bG,
                                      genotype: _editedInfo.genotype,
                                      id: _editedInfo.id,
                                      name: value!,
                                      phone: _editedInfo.phone,
                                      nextOfKin: _editedInfo.nextOfKin);
                                },
                              ),
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            Expanded(
                              child: TextFormField(
                                initialValue: _initValues['name'],
                                decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(5),
                                        borderSide: BorderSide(
                                            color: Color.fromARGB(
                                                255, 70, 182, 201))),
                                    disabledBorder: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(5.00),
                                        borderSide: BorderSide(
                                            color: Color.fromARGB(
                                                255, 70, 182, 201))),
                                    errorStyle: TextStyle(
                                      color: Colors.red,
                                      fontSize: 15.0,
                                    ),
                                    prefixIcon: Icon(Icons.phone),
                                    labelText: "Phone Number",
                                    hintStyle: TextStyle(
                                        color: Colors.grey, fontSize: 15)),
                                textInputAction: TextInputAction.next,
                                onFieldSubmitted: (_) {
                                  FocusScope.of(context)
                                      .requestFocus(_addressFocusNode);
                                },
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Please Enter Your Phone Number';
                                  }
                                  if (!isValidPhone(value)) {
                                    return "Phone Number must be in the format +2348123456789 ";
                                  }
                                },
                                onSaved: (value) {
                                  _editedInfo = Info(
                                      address: _editedInfo.address,
                                      bG: _editedInfo.bG,
                                      genotype: _editedInfo.genotype,
                                      id: _editedInfo.id,
                                      name: _editedInfo.name,
                                      phone: value!,
                                      nextOfKin: _editedInfo.nextOfKin);
                                },
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: TextFormField(
                                initialValue: _initValues['address'],
                                maxLines: 2,
                                keyboardType: TextInputType.multiline,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(5),
                                      borderSide: BorderSide(
                                          color: Color.fromARGB(
                                              255, 70, 182, 201))),
                                  disabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(5.00),
                                      borderSide: BorderSide(
                                          color: Color.fromARGB(
                                              255, 70, 182, 201))),
                                  errorStyle: TextStyle(
                                    color: Colors.red,
                                    fontSize: 15.0,
                                  ),
                                  prefixIcon: Icon(Icons.location_on_sharp),
                                  labelText: "Address",
                                  hintStyle: TextStyle(
                                      color: Colors.grey, fontSize: 15),
                                ),
                                textInputAction: TextInputAction.next,
                                onFieldSubmitted: (_) {
                                  FocusScope.of(context)
                                      .requestFocus(_bGFocusNode);
                                },
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Please Enter Your Address';
                                  }
                                },
                                onSaved: (value) {
                                  _editedInfo = Info(
                                      address: value!,
                                      bG: _editedInfo.bG,
                                      genotype: _editedInfo.genotype,
                                      id: _editedInfo.id,
                                      name: _editedInfo.name,
                                      phone: _editedInfo.phone,
                                      nextOfKin: _editedInfo.nextOfKin);
                                },
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: DropdownButtonFormField(
                                // value: _bGDropdownValue,
                                decoration: InputDecoration(
                                  prefixIcon: Icon(Icons.bloodtype),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(5),
                                      borderSide: BorderSide(
                                          color: Color.fromARGB(
                                              255, 70, 182, 201))),
                                  disabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(5.00),
                                      borderSide: BorderSide(
                                          color: Color.fromARGB(
                                              255, 70, 182, 201))),
                                  labelText: 'Blood Group',
                                ),
                                items: [
                                  DropdownMenuItem(
                                      value: 'A+', child: Text('A-Positive')),
                                  DropdownMenuItem(
                                      value: 'A-', child: Text('A-Negative')),
                                  DropdownMenuItem(
                                      value: 'AB+', child: Text('AB-Postive')),
                                  DropdownMenuItem(
                                      value: 'Ab-', child: Text('AB-Negaive')),
                                  DropdownMenuItem(
                                      value: 'B+', child: Text('B-Positive')),
                                  DropdownMenuItem(
                                      value: 'B-', child: Text('B-Negative')),
                                  DropdownMenuItem(
                                      value: '0+', child: Text('0-Positive')),
                                  DropdownMenuItem(
                                      value: '0-', child: Text('0-Negative')),
                                ],
                                onChanged: (value) {
                                  setState(() {
                                    _bGDropdownValue = value as String;
                                  });
                                },
                                onSaved: (value) {
                                  _editedInfo = Info(
                                      address: _editedInfo.address,
                                      bG: value as String,
                                      genotype: _editedInfo.genotype,
                                      id: _editedInfo.id,
                                      name: _editedInfo.name,
                                      phone: _editedInfo.phone,
                                      nextOfKin: _editedInfo.nextOfKin);
                                },
                              ),
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            Expanded(
                              child: DropdownButtonFormField(
                                  decoration: InputDecoration(
                                    prefixIcon:
                                        Icon(Icons.health_and_safety_rounded),
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(5),
                                        borderSide: BorderSide(
                                            color: Color.fromARGB(
                                                255, 70, 182, 201))),
                                    disabledBorder: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(5.00),
                                        borderSide: BorderSide(
                                            color: Color.fromARGB(
                                                255, 184, 230, 238))),
                                    labelText: 'Genotype',
                                  ),
                                  items: [
                                    DropdownMenuItem(
                                        value: 'AA', child: Text('AA')),
                                    DropdownMenuItem(
                                        value: 'AC', child: Text('AC')),
                                    DropdownMenuItem(
                                        value: 'AS', child: Text('AS')),
                                    DropdownMenuItem(
                                        value: 'SS', child: Text('SS')),
                                  ],
                                  onChanged: (value) {
                                    setState(() {
                                      _genotypeDropdownValue = value as String;
                                    });
                                  },
                                  onSaved: (value) {
                                    setState(() {
                                      _editedInfo = Info(
                                          address: _editedInfo.address,
                                          bG: _editedInfo.bG,
                                          genotype: value as String,
                                          id: _editedInfo.id,
                                          name: _editedInfo.name,
                                          phone: _editedInfo.phone,
                                          nextOfKin: _editedInfo.nextOfKin);
                                    });
                                  }),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Expanded(
                          child: TextFormField(
                            initialValue: _initValues['nextOfKin'],
                            maxLines: 2,
                            keyboardType: TextInputType.multiline,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5),
                                  borderSide: BorderSide(
                                      color:
                                          Color.fromARGB(255, 70, 182, 201))),
                              disabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5.00),
                                  borderSide: BorderSide(
                                      color:
                                          Color.fromARGB(255, 70, 182, 201))),
                              errorStyle: TextStyle(
                                color: Colors.red,
                                fontSize: 15.0,
                              ),
                              prefixIcon: Icon(Icons.people),
                              labelText: "Next Of Kin Details",
                              hintStyle:
                                  TextStyle(color: Colors.grey, fontSize: 15),
                            ),
                            textInputAction: TextInputAction.next,
                            onFieldSubmitted: (_) {
                              FocusScope.of(context)
                                  .requestFocus(_phoneFocusNode);
                            },
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Kindly Fill your Next Of Kin Details';
                              }
                            },
                            onSaved: (value) {
                              _editedInfo = Info(
                                  address: _editedInfo.address,
                                  bG: _editedInfo.bG,
                                  genotype: _editedInfo.genotype,
                                  id: _editedInfo.id,
                                  name: _editedInfo.name,
                                  phone: _editedInfo.phone,
                                  nextOfKin: value!);
                            },
                          ),
                        ),
                        SizedBox(height: 30),
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
                                onPressed: () async {
                                  CircularProgressIndicator.adaptive();
                                  _saveForm();
                                },
                                child: Text('Generate Code'))),
                      ],
                    )),
              ),
            ),
    );
  }
}
