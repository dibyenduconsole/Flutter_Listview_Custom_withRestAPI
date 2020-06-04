import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:listview_custom_with_rest_api/model/employee_data.dart';
import 'package:listview_custom_with_rest_api/model/employee_list.dart';
import 'package:listview_custom_with_rest_api/network/EndPoints.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // Future object to fetch response from API (Response in future)
  Future<EmplyeeList> employeeListFuture;

void _showcontent(String title, String message) {
      showDialog(
        context: context, barrierDismissible: false, // user must tap button!

        builder: (BuildContext context) {
          return new AlertDialog(
            title: new Text(title),
            content: new SingleChildScrollView(
              child: new ListBody(
                children: [
                  new Text(message),
                ],
              ),
            ),
            actions: [
              new FlatButton(
                child: new Text('Close'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }

    void callAPI() {
      // here first we are checking network connection
      isConnected().then((internet) {
        if (internet) {
          // set state while we fetch data from API
          setState(() {
            // calling API to show the data
            // you can also do it with any button click.
            employeeListFuture = getEmployeeListData();
            
          });
        } else {
          /*Display dialog with no internet connection message*/
          print("No Internet");
          _showcontent("No Internet",
              "Please check your network connection and try again");
        }
      });
    }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Employee List"),
        ),
        body: Container(
            padding: const EdgeInsets.all(16.0),
            child: Stack(
              fit: StackFit.expand,
              children: <Widget>[
                FutureBuilder<EmplyeeList>(
                    future: employeeListFuture,
                    builder: (context, snapshot) {
                      // to show progress loading view add switch statment to handle connnection states.
                      switch (snapshot.connectionState) {
                        case ConnectionState.waiting:
                          {
                            // here we are showing loading view in waiting state.
                            return loadingView();
                          }
                        case ConnectionState.active:
                          {
                            break;
                          }
                        case ConnectionState.done:
                          {
                            // in done state we will handle the snapshot data.
                            // if snapshot has data show list else set you message.
                            if (snapshot.hasData) {
                              // hasdata same as data!=null
                              if (snapshot.data.employeeList != null) {
                                if (snapshot.data.employeeList.length > 0) {
                                  // here inflate data list
                                  return ListView.builder(
                                      itemCount:
                                          snapshot.data.employeeList.length,
                                      itemBuilder: (context, index) {
                                        return generateColum(
                                            snapshot.data.employeeList[index]);
                                      });
                                } else {
                                  // display message for empty data message.
                                  return noDataView("No data found");
                                }
                              } else {
                                // display error message if your list or data is null.
                                return noDataView("No data found");
                              }
                            } else if (snapshot.hasError) {
                              // display your message if snapshot has error.
                              return noDataView("Something went wrong");
                            } else {
                              return noDataView("Something went wrong");
                            }
                            break;
                          }
                        case ConnectionState.none:
                          {
                            break;
                          }
                      }
                    }),
                Align(
                  alignment: Alignment.bottomRight,
                  child: FloatingActionButton(
                    child: Icon(
                      Icons.refresh,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      callAPI();
                    },
                  ),
                )
              ],
            )));
  }

  // Here we created row for the bear list.
  Widget generateColum(EmployeeDtata item) => Card(
        child: ListTile(
          leading: Image.network(item.avatar),
          onTap: () => {print("==${item.email}")},
          title: Text(
            item.first_name,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          ),
          subtitle:
              Text(item.email, style: TextStyle(fontWeight: FontWeight.w600)),
        ),
      );

  // Progress indicator widget to show loading.
  Widget loadingView() => Center(
        child: CircularProgressIndicator(
          backgroundColor: Colors.red,
        ),
      );

  // View to empty data message
  Widget noDataView(String msg) => Center(
        child: Text(
          msg,
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w800),
        ),
      );

  @override
  void initState() {
    

    callAPI();

    super.initState();
  }
}
