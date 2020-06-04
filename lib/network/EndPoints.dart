import 'dart:convert';
// get reponse from API
import 'package:http/http.dart' as http;
// to check internet connection
import 'package:connectivity/connectivity.dart';
import 'package:listview_custom_with_rest_api/model/employee_list.dart';

// API url
String url = "https://reqres.in/api/users?page=2";

// Here we are using http package to fetch data from API
// We defined retrun type BeerListModel
Future<EmplyeeList> getEmployeeListData() async {

  print("API call start");
  final response = await http.get(url,);
  print(response.body);
  var dd = json.decode(response.body)["data"];
  print("===FFF===");
  print(dd);
  /*var status = response.statusCode;
  var data = json.decode(response.body);
        var rest = data["data"] as List;*/
  //json.decode used to decode response.body(string to map)
  return EmplyeeList.fromJson(dd);
}


// method defined to check internet connectivity
Future<bool> isConnected() async {
  var connectivityResult = await (Connectivity().checkConnectivity());
  if (connectivityResult == ConnectivityResult.mobile) {
    return true;
  } else if (connectivityResult == ConnectivityResult.wifi) {
    return true;
  }
  return false;
}
