import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:processmanagement/other/ConstantColor.dart';
import 'package:processmanagement/pages/cameraReadiness.dart';
import 'package:processmanagement/pages/processList.dart';

class FirstPage extends StatefulWidget {
  @override
  _FirstPageState createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  int n =22;

  void initState() {
    // TODO: implement initState
    super.initState();
  }


  final scaffoldState = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldState,
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
                stops: [
              0.5,
              0.7
            ],
                colors: [
              ConstantColor.FIRSTLINEARGRADIENT,
              ConstantColor.SECONDLINEARGRADIENT
            ])),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  SizedBox(
                    height: 40,
                  ),
                  GestureDetector(
                    onTap: () => {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => ProcessList()),
                      )
                    },
                    child: Container(
                      margin: EdgeInsets.only(top: 10),
                      padding: EdgeInsets.all(10),
                      // decoration: BoxDecoration(color:Color(0xff01292B),),
                      decoration: new BoxDecoration(
                          color: ConstantColor.CARD,
                          borderRadius: new BorderRadius.only(
                            topLeft: const Radius.circular(5.0),
                            topRight: const Radius.circular(5.0),
                            bottomRight: const Radius.circular(5.0),
                            bottomLeft: const Radius.circular(5.0),
                          )),
                      child: Column(
                        children: <Widget>[
                          Container(
                            padding: EdgeInsets.only(top: 20, bottom: 20),
                            child: Text(
                              "Business Project List (All)",
                              style: TextStyle(
                                  color: ConstantColor.BUTTONCOLORTEXT),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  // GestureDetector(
                  //   onTap: () => {
                  //     Navigator.push(
                  //       context,
                  //       MaterialPageRoute(builder: (context) => CameraReadiness()),
                  //     )
                  //   },
                  //   child: Container(
                  //     margin: EdgeInsets.only(top: 10),
                  //     padding: EdgeInsets.all(10),
                  //     // decoration: BoxDecoration(color:Color(0xff01292B),),
                  //     decoration: new BoxDecoration(
                  //         color: ConstantColor.CARD,
                  //         borderRadius: new BorderRadius.only(
                  //           topLeft: const Radius.circular(5.0),
                  //           topRight: const Radius.circular(5.0),
                  //           bottomRight: const Radius.circular(5.0),
                  //           bottomLeft: const Radius.circular(5.0),
                  //         )),
                  //     child: Column(
                  //       children: <Widget>[
                  //         Container(
                  //           padding: EdgeInsets.only(top: 20, bottom: 20),
                  //           child: Text(
                  //             "Camera Readiness",
                  //             style: TextStyle(
                  //                 color: ConstantColor.BUTTONCOLORTEXT),
                  //           ),
                  //         ),
                  //       ],
                  //     ),
                  //   ),
                  // )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

}
