import 'package:flutter/widgets.dart';

class Info with ChangeNotifier {
  final String? id;
  final String name;
  final String address;
  final String phone;
  final String bG;
  final String genotype;
  final String nextOfKin;
  Info(
      {required this.address,
      required this.bG,
      required this.genotype,
      required this.id,
      required this.name,
      required this.phone,
      required this.nextOfKin});
}
