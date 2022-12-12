import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:motsha_app/model/district_model.dart';


class GetDistrictList {
  static const Map<String, String> defaultHeader = {
    "Accept": "application/json",
  };

  Future<List<DistrictModel>> fetchDistrict() async {
    List<DistrictModel> districtListData = [];

    try {
      var link = "http://dof-demo.rdtl.xyz/api/address/get-district/10";
      var response =
      await http.get(Uri.parse(link), headers: await defaultHeader);
      print(response.statusCode);

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        DistrictModel districtData;
        for (var i in data) {
          districtData = DistrictModel.fromJson(i);
          districtListData.add(districtData);


        }

        print("wwwwwwwwwwwww");
        print(districtListData);
        return districtListData;
      } else {
        return districtListData;
      }
    } catch (e) {
      print(e);
      return districtListData;
    }
  }
}