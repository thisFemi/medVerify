import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'info.dart';

class Infos with ChangeNotifier {
  List<Info> _details = [];

  List<Info> get details {
    return [..._details];
  }

  Info findById(String id) {
    return _details.firstWhere((info) => info.phone == id);
  }

  Future<void> fetchDetails(String id) async {
    var url =
        'https://medverify-6a9e9-default-rtdb.firebaseio.com/details.json?orderBy="$id"';
    try {
      final response = await http.get(Uri.parse(
        url,
      ));
      final List<Info> loadedInfo = [];
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      if (extractedData == null) {
        return;
      }
      extractedData.forEach((infoId, infoData) {
        loadedInfo.add(Info(
            address: infoData['address'],
            bG: infoData['bloodGroup'],
            genotype: infoData['genotype'],
            id: infoId,
            name: infoData['name'],
            phone: infoData['phone'],
            nextOfKin: infoData['Next of Kin Contact']));
      });
      _details = loadedInfo;
      notifyListeners();
    } catch (error) {
      throw error;
    }
  }

  Future<void> addDetails(Info info) async {
    const url =
        'https://medverify-6a9e9-default-rtdb.firebaseio.com/details.json';
    try {
      final response = await http.post(Uri.parse(url),
          body: json.encode({
            'name': info.name,
            'address': info.address,
            'phone': info.phone,
            'bloodGroup': info.bG,
            'genotype': info.genotype,
            'Next of Kin Contact': info.nextOfKin,
            'creatorId': info.phone
          }));
      final newInfo = Info(
          address: info.address,
          bG: info.bG,
          genotype: info.genotype,
          id: json.decode(response.body)['phone'],
          name: info.name,
          phone: info.phone,
          nextOfKin: info.nextOfKin);
      _details.add(newInfo);
      notifyListeners();
    } catch (error) {
      throw error;
    }
  }

  Future<void> updateDetails(String? id, Info newInfo) async {
    final infoIndex = _details.indexWhere((record) => record.phone == id);
    if (infoIndex >= 0) {
      final url =
          'https://medverify-6a9e9-default-rtdb.firebaseio.com/details.json';
      await http.patch(Uri.parse(url),
          body: json.encode({
            'name': newInfo.name,
            'address': newInfo.address,
            'phone': newInfo.phone,
            'bloodGroup': newInfo.bG,
            'genotype': newInfo.genotype,
            'Next of Kin Contact': newInfo.nextOfKin,
          }));
      _details[infoIndex] = newInfo;
      notifyListeners();
    } else {
      null;
    }
  }
}
