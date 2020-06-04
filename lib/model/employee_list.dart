import 'package:listview_custom_with_rest_api/model/employee_data.dart';

class EmplyeeList{
  List<EmployeeDtata> employeeList;

  EmplyeeList({this.employeeList});

  EmplyeeList.fromJson(List<dynamic> parsedJson){
    print("*****");
    print(parsedJson.length);
    employeeList=new List<EmployeeDtata>();
    print(employeeList.length);
    parsedJson.forEach((v){
      print("------");
       print(v);
      employeeList.add(EmployeeDtata.fromJson(v));
    });
  }
}