vimport 'dart:convert';
import 'dart:io';
import 'dart:io' as Io;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:processmanagement/other/ConstantColor.dart';
import 'package:processmanagement/other/URL.dart';

import 'AddPhase.dart';

class CreateProcess extends StatefulWidget {
  @override
  _CreateProcess createState() => _CreateProcess();
}

enum AppState {
  free,
  picked,
  cropped,
}

class _CreateProcess extends State<CreateProcess> {


  final _scaffoldKey = GlobalKey<ScaffoldState>();

  TextEditingController name = TextEditingController();
  TextEditingController description = TextEditingController();
  // TextEditingController amount = TextEditingController();
  TextEditingController _controller1 = TextEditingController();
  // final DateFormat dateFormat = DateFormat("yyyy-MM-dd");
  // final startDateFormKey = new GlobalKey<FormState>();
  //  var sYear;
  //  DateTime startDateSelected;
  //  var sDay;
  //  var  sMonth;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text("Business Process Detail"),
        backgroundColor: ConstantColor.APPBAR,
      ),
      body: Container(
          height: double.infinity,
          width: double.infinity,
          padding: new EdgeInsets.fromLTRB(40.0, 0, 40, 15),
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topRight,
                  end: Alignment.bottomRight,
                  stops: [0.5, 0.7],
                  colors: [ConstantColor.FIRSTLINEARGRADIENT, ConstantColor.SECONDLINEARGRADIENT])),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                SizedBox(
                  height: 30,
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Business Process Name : ',
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.grey[500],
                    ),
                  ),
                ),
                Container(
                    padding: EdgeInsets.only(top: 10),
                    child: Theme(
                      data: ThemeData(
                          backgroundColor: Colors.white,
                          hintColor: Colors.green),
                      child: TextField(
                          controller: name,
                          keyboardType: TextInputType.text,
                          style: TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                            hintStyle: TextStyle(
                                fontSize: 15, color: Colors.grey[400]),
                            hintText: 'Enter Name',
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                            ),
                            border: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                            ),
                          )),
                    )),
                SizedBox(height: 20,),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Business Process Description : ',
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.grey[500],
                    ),
                  ),
                ),
                Container(
                    padding: EdgeInsets.only(top: 10),
                    child: Theme(
                      data: ThemeData(
                          backgroundColor: Colors.white,
                          hintColor: Colors.green),
                      child: TextField(
                          controller: description,
                          keyboardType: TextInputType.multiline,
                          maxLines: null,
                          maxLength: 150,
                          style: TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                            counterStyle: TextStyle(color: Colors.grey),
                            hintStyle: TextStyle(
                                fontSize: 15, color: Colors.grey[400]),
                            hintText: 'Enter Description',
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                            ),
                            border: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                            ),
                          )),
                    )),
                SizedBox(
                  height: 30,
                ),
                // Align(
                //   alignment: Alignment.centerLeft,
                //   child: Text(
                //     'Amount',
                //     style: TextStyle(
                //       fontSize: 15,
                //       color: Colors.grey[500],
                //     ),
                //   ),
                // ),
                // Container(
                //     padding: EdgeInsets.only(top: 10),
                //     child: Theme(
                //       data: ThemeData(
                //           backgroundColor: Colors.white,
                //           hintColor: Colors.green),
                //       child: TextField(
                //           controller: amount,
                //           keyboardType: TextInputType.number,
                //           style: TextStyle(color: Colors.white),
                //           decoration: InputDecoration(
                //             hintStyle: TextStyle(
                //                 fontSize: 15, color: Colors.grey[400]),
                //             hintText: 'Enter Amount',
                //             enabledBorder: UnderlineInputBorder(
                //               borderSide: BorderSide(color: Colors.white),
                //             ),
                //             focusedBorder: UnderlineInputBorder(
                //               borderSide: BorderSide(color: Colors.white),
                //             ),
                //             border: UnderlineInputBorder(
                //               borderSide: BorderSide(color: Colors.white),
                //             ),
                //           )),
                //     )),
                // SizedBox(
                //   height: 30,
                // ),
                // Align(
                //   alignment: Alignment.centerLeft,
                //   child: Text(
                //     'Start Date',
                //     style: TextStyle(
                //       fontSize: 15,
                //       color: Colors.grey[500],
                //     ),
                //   ),
                // ),
                // Theme(
                //     data: ThemeData.dark().copyWith(
                //       colorScheme: ColorScheme.dark(
                //         primary: ConstantColor.UNSELECTED,
                //         onPrimary: Colors.white,
                //         surface: ConstantColor.UNSELECTED,
                //         onSurface: ConstantColor.SELECTED,
                //       ),
                //       dialogBackgroundColor: const Color(0xff827700),
                //     ),
                //     child: DateTimePicker(
                //       type: DateTimePickerType.date,
                //       dateMask: 'd MMM, yyyy',
                //       controller: _controller1,
                //       // initialValue: initialDate,
                //       firstDate: DateTime(2000),
                //       lastDate: DateTime(2100),
                //       decoration: InputDecoration(
                //           suffixIcon: Icon(Icons.arrow_drop_down),
                //           hintText: "Select Date"),
                //       //use24HourFormat: false,
                //       //locale: Locale('pt', 'BR'),
                //       selectableDayPredicate: (date) {
                //         if (date.weekday == 6 || date.weekday == 7) {
                //           return false;
                //         }
                //         return true;
                //       },
                //
                //       onChanged: (val) {
                //         setState(() => _valueChanged1 = val);
                //         String s = _controller1.text;
                //         var parts = s.split("-");
                //         print(parts);
                //         sYear = parts[0];
                //         sDay = parts[2];
                //         sMonth = parts[1];
                //       },
                //       validator: (val) {
                //         setState(() => _valueToValidate1 = val ?? '');
                //         return null;
                //       },
                //       onSaved: (val) =>
                //           setState(() => _valueSaved1 = val ?? ''),
                //     )),

                MaterialButton(
                  minWidth: double.infinity,
                  padding: EdgeInsets.only(top: 10, bottom: 10),
                  onPressed: () {
                    if (name.text.isEmpty) {
                      _showSnakBarMsg("Enter Name");
                      return ;
                    }
                    if (description.text.isEmpty) {
                      _showSnakBarMsg("Enter Name");
                      return ;

                    }
                    // if (_controller1.text.isEmpty) {
                    //     sYear = 2021;
                    //     sDay =28;
                    //     sMonth = 4;
                    // }
                    // if (imageFile == null) {
                    //     imageString = "";
                    //   // print(imageString);
                    // }
                    _addProcess();
                  },
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  disabledColor: Colors.grey,
                  disabledTextColor: Colors.white,
                  highlightColor: Colors.orangeAccent,
                  color: Colors.white,
                  elevation: 4.0,
                  child: Text("Create Process",
                    style: TextStyle(color: ConstantColor.BUTTONCOLORTEXT),),
                ),
              ],
            ),
          )),
    );
  }

  showLoaderDialog(BuildContext context){
    AlertDialog alert=AlertDialog(
      content: new Row(
        children: [
          CircularProgressIndicator(),
          Container(margin: EdgeInsets.only(left: 7),child:Text("Creating Process...",
            style: TextStyle(color: ConstantColor.BUTTONCOLORTEXT), )),
        ],),
    );
    showDialog(barrierDismissible: false,
      context:context,
      builder:(BuildContext context){
        return alert;
      },
    );
  }
  Future<bool> _addProcess() async {
    showLoaderDialog(context);
    var params = {
      "title": name.text,
      "desciption": description.text,
      // "image": imageString,
      // "day": sDay,
      // "month": sMonth,
      // "year": sYear,
      // "amount": amount.text,
    };

    http.Response response = await http.post(Uri.parse(URL.ADD_PROCESS),
        body: jsonEncode(params),
        headers: {"Content-Type": "application/json"});
    print(jsonEncode(params));
    var jsonResponse = jsonDecode(response.body);
    Navigator.pop(context);
    int processId = jsonResponse['id'];
    bool status = jsonResponse['status'];
    if (status) {
      _showSnakBarMsg("Process create successful!");
      _sendDataToSecondScreen(context, processId);
    } else {
      _showSnakBarMsg("Can't create process, Try again!");
    }
    return status;
  }
  void _showSnakBarMsg(String msg) {
    _scaffoldKey.currentState
        .
    // ignore: deprecated_member_use
    showSnackBar(new SnackBar(content: new Text(msg)));
  }

  void _sendDataToSecondScreen(BuildContext context, int processId) {
    Navigator.pop(context);
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => AddPhase(
            id: processId.toString(),
            name: name.text,
            description : description.text,
          ),
        ));

  }

}

class AlwaysDisabledFocusNode extends FocusNode {
  @override
  bool get hasFocus => false;
}
