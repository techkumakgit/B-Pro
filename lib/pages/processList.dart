import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:processmanagement/Model/Phase.dart';
import 'package:processmanagement/Model/PhaseMember.dart';
import 'package:processmanagement/Model/Process.dart';
import 'package:processmanagement/other/ConstantColor.dart';
import 'package:processmanagement/other/Constants.dart';
import 'package:processmanagement/other/RoleConstant.dart';
import 'package:processmanagement/other/URL.dart';
import 'package:processmanagement/pages/processBegin.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProcessList extends StatefulWidget {
  @override
  _ProcessListState createState() => _ProcessListState();
}

class _ProcessListState extends State<ProcessList> {
  ProcessList processListObject = new ProcessList();
  Future<List<Process>> futureData;
  bool active = false;
  bool inactive = false;
  bool all = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadProcess();
    load();
  }

  int role = -1;

  load() async {
    final prefs = await SharedPreferences.getInstance();
    role = prefs.getInt(Constant.USER_ROLE) ?? -1;
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text("Business Process List (All)"),
        backgroundColor: ConstantColor.APPBAR,
        centerTitle: false,
        actions: <Widget>[
          Visibility(
              visible: role == RoleConstant.CREATOR,
              child: IconButton(
                  icon: Icon(
                    Icons.add,
                    color: Colors.white,
                  ),
                  onPressed: () =>
                      Navigator.pushNamed(context, '/CreateProcess')))
        ],
      ),
      body: SafeArea(
        child: Container(
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
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        all = true;
                        active = false;
                        inactive = false;
                        futureData = changeData(allProcessList);
                        setState(() {});
                      },
                      child: Container(
                        padding: EdgeInsets.only(top: 8, bottom: 8),
                        margin: EdgeInsets.only(top: 10, right: 5),
                        decoration: BoxDecoration(
                          color: all
                              ? ConstantColor.SELECTED
                              : ConstantColor.UNSELECTED,
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(5),
                            bottomRight: Radius.circular(5),
                            topLeft: Radius.circular(5),
                            topRight: Radius.circular(5),
                          ),
                        ),
                        child: Text(
                          "All",
                          style: TextStyle(color: Colors.white),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        all = false;
                        active = true;
                        inactive = false;
                        futureData = changeData(activeProcessList);
                        setState(() {});
                      },
                      child: Container(
                        padding: EdgeInsets.only(top: 8, bottom: 8),
                        margin: EdgeInsets.only(top: 10, right: 5),
                        decoration: BoxDecoration(
                          color: active
                              ? ConstantColor.SELECTED
                              : ConstantColor.UNSELECTED,
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(5),
                            bottomRight: Radius.circular(5),
                            topLeft: Radius.circular(5),
                            topRight: Radius.circular(5),
                          ),
                        ),
                        child: Text(
                          "Active",
                          style: TextStyle(color: Colors.white),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        all = false;
                        active = false;
                        inactive = true;
                        futureData = changeData(inActiveProcessList);
                        setState(() {});
                      },
                      child: Container(
                        padding: EdgeInsets.only(top: 8, bottom: 8),
                        margin: EdgeInsets.only(top: 10, right: 5),
                        decoration: BoxDecoration(
                          color: inactive
                              ? ConstantColor.SELECTED
                              : ConstantColor.UNSELECTED,
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(5),
                            bottomRight: Radius.circular(5),
                            topLeft: Radius.circular(5),
                            topRight: Radius.circular(5),
                          ),
                        ),
                        child: Text(
                          "In-Active",
                          style: TextStyle(color: Colors.white),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              FutureBuilder<List<Process>>(
                future: futureData,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    if (snapshot.data.length > 0) {
                      List<Process> data = snapshot.data;
                      return Flexible(
                        child: ListView.builder(
                            shrinkWrap: true,
                            itemCount: data.length,
                            itemBuilder: (BuildContext context, int index) {
                              return GestureDetector(
                                onTap: () => {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => ProcessBegin(
                                          myObject: data[index],
                                        ),
                                      ))
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
                                      Row(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Expanded(
                                            child: Text("Process ID : " +
                                                data[index].id.toString()),
                                          ),
                                          Expanded(
                                            flex: 1,
                                            child: Container(
                                              alignment: Alignment.center,
                                              margin: EdgeInsets.only(left: 20),
                                              padding: EdgeInsets.only(
                                                  top: 3, bottom: 3),
                                              decoration: BoxDecoration(
                                                color: data[index]
                                                            .status
                                                            .idInt ==
                                                        3
                                                    ? ConstantColor.COMPLETE
                                                    : data[index]
                                                                .status
                                                                .idInt ==
                                                            1
                                                        ? ConstantColor
                                                            .NOT_STARTED
                                                        : data[index]
                                                                    .status
                                                                    .idInt ==
                                                                2
                                                            ? ConstantColor
                                                                .IN_PROGRESS
                                                            : Colors.white,
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                              ),
                                              child: Column(
                                                children: [
                                                  Text(
                                                    // "in progress",
                                                    data[index]
                                                        .status
                                                        .name
                                                        .toString()
                                                        .replaceAll("_", " ")
                                                        .toUpperCase(),
                                                    style: TextStyle(
                                                      fontSize: 11,
                                                      color: Colors.black,
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),

                                          // Expanded(
                                          //   child: Align(
                                          //     alignment: Alignment.centerRight,
                                          //     child: Text("Amount : " +
                                          //         data[index]
                                          //             .amount
                                          //             .toString()),
                                          //   ),
                                          // ),
                                        ],
                                      ),
                                      Align(
                                        alignment: Alignment.centerLeft,
                                        child: Text("Process Name :" +
                                            data[index].title),
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Row(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Expanded(
                                            child: Text(
                                              "Start Time : " + "${data[index].startDate == null ? "- - -" : data[index].startDate}",
                                              style: TextStyle(fontSize: 13),
                                            ),
                                          ),
                                          Expanded(
                                              child: Align(
                                            alignment: Alignment.centerRight,
                                            child: Text(
                                              "End Time : " +
                                                  "${data[index].endDate == null ? "- - -" : data[index].endDate}",
                                              style: TextStyle(fontSize: 13),
                                            ),
                                          )),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 4,
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            }),
                      );
                    } else {
                      return Expanded(
                          child: Center(
                              child: Text(
                        "Process list is empty\nClick on + to add new one",
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      )));
                    }
                  }
                  // By default show a loading spinner.
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<Process> activeProcessList = [];
  List<Process> inActiveProcessList = [];
  List<Process> allProcessList = [];

  loadProcess() async {
    final response = await http.get(Uri.parse(URL.PROCESS_LIST));
    var responseData = json.decode(response.body);
    for (var singleProcess in responseData) {
      Process process = Process.fromJson(singleProcess);
      var phaseList = singleProcess["phases"];
      process.phase = [];
      for (var singlePhase in phaseList) {
        Phase phase = Phase.fromJson(singlePhase);
        phase.phaseMember = [];
        var phaseMember = singlePhase["phase_member"];
        for (var singlePhaseMember in phaseMember) {
          phase.phaseMember.add(PhaseMember.fromJson(singlePhaseMember));
        }
        process.phase.add(phase);
      }
      if (process.status.idInt == 1) {
        inActiveProcessList.add(process);
      } else if (process.status.idInt == 2) {
        activeProcessList.add(process);
      }
      allProcessList.add(process);
    }

    futureData = changeData(allProcessList);
    setState(() {});
  }

  Future<List<Process>> changeData(List<Process> list) async {
    return list;
  }
}
