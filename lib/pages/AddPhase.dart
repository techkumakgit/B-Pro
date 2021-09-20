import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:processmanagement/Model/Phase.dart';
import 'package:processmanagement/Model/Process.dart';
import 'package:processmanagement/Model/User.dart';
import 'package:processmanagement/other/ConstantColor.dart';
import 'file:///C:/Users/apex/AndroidStudioProjects/processmanagement/lib/ui/CustomDialogBox.dart';
import 'package:processmanagement/other/URL.dart';
import 'package:http/http.dart' as http;
import 'package:processmanagement/pages/processBegin.dart';
class AddPhase extends StatefulWidget {
  final String name, id, description;

  AddPhase({ this.name,  this.id, this.description});

  @override
  _AddPhaseState createState() => _AddPhaseState(name: name, id: id, description: description);
}

class _AddPhaseState extends State<AddPhase> {
    int count = 0;
  bool isBool;
  _AddPhaseState({ this.name,  this.id, this.description});
  int _verticalGroupValue = 0 ;
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final userKeyDropDownFormField = new GlobalKey<FormState>();
  final stageKeyDropDownFormField = new GlobalKey<FormState>();
   List<User> users = [];
   List<User> stageLists = [];
   String selectedUserIds="";
   String selectedUserName="";
   String selectedStageName="";
   String selectedStageIds="";
   String name;
   String id;
   String description;
  TextEditingController phaseName = TextEditingController();
  TextEditingController phaseDescription = TextEditingController();
  int selectedRadio;
  int selectedRadioTile;
  Process process = new Process();
  List<Phase> phase = [];

  @override
  void initState() {
    super.initState();
    selectedUserIds = "";
    selectedStageName = "";
    selectedUserName = "";
    selectedStageIds = "";
    // selectedRadio = null;
    process.title = name;
    process.description = description;
    loadStage();
    loadUser();
  }

  Future<List<User>> loadUser() async {
    final response = await http.get(Uri.parse(URL.USERSLIST));

    var responseData = json.decode(response.body);

    //Creating a list to store input data;
    for (var singleUser in responseData) {
      User user = User(
          id: singleUser["id"],
          userName: singleUser["name"],
          isChecked: false);
          users.add(user);

    }
    setState(() {
      responseData = users;
    });
    return users;
  }
  Future<List<User>> loadStage() async {
    final response = await http.get(Uri.parse(URL.STAGE_TYPE_LIST));

    var responseData = json.decode(response.body);

    //Creating a list to store input data;
    for (var singleUser in responseData) {
      User stageList = User(
          id: singleUser["id"],
          userName: singleUser["name"],
          isChecked: false);
      stageLists.add(stageList);

    }
    setState(() {
      responseData = stageLists;
    });
    return stageLists;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text("No. Of Entities"),
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
                  colors: [ConstantColor.FIRSTLINEARGRADIENT,ConstantColor.SECONDLINEARGRADIENT])),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                SizedBox(height: 30,),
                Align(
                  alignment: Alignment.center,
                  child: Text(
                    "Business Process ID : " + id,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.white,
                    ),

                  ),

                ),
                SizedBox(height: 5,),
                Align(
                  alignment: Alignment.center,
                  child: Text(
                    'Business Process Name : '+name,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.white,
                    ),
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                SizedBox(height: 5,),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Stage : '+ "${count+1}",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                    ),
                  ),
                ),
                SizedBox(height: 30,),
                Align(
                   alignment: Alignment.centerLeft,
                   child:
                   Text(
                  'Stage Name',
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.grey[500],
                  ),
                ),
            ),
                Container(
                    padding: EdgeInsets.only(
                        bottom: 20, ),
                    child: Theme(
                      data: ThemeData(
                          backgroundColor: Colors.white,
                          hintColor: Colors.green),
                      child: TextField(
                          maxLength: 20,
                          // ignore: deprecated_member_use
                          maxLengthEnforced: true,
                          controller: phaseName,

                          style: TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                            counterText: "",
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
                SizedBox(height:5,),
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
                    child: Theme(
                      data: ThemeData(
                          backgroundColor: Colors.white,
                          hintColor: Colors.green),
                      child: TextField(
                          controller: phaseDescription,
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
                Align(alignment: Alignment.centerLeft,
                 child:Text(
                  'Users Involved:',
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.grey[500],
                  ),
                ),
                ),
                SizedBox(height:2,),
                Center(
                  child: Form(
                    key: userKeyDropDownFormField,
                    child: GestureDetector(
                      onTap: () {
                        showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return CustomDialogBox(
                                allUsers: users,
                                maxUser: users.length,
                                onUserSelect:
                                    (selectedUserIds, selectedUserName) {
                                  this.selectedUserIds = selectedUserIds;
                                  this.selectedUserName = selectedUserName;
                                  setState(() {
                                    this.selectedUserName = selectedUserName;
                                    this.selectedUserIds = selectedUserIds;
                                    // checkedUser = [selectedUserName + selectedUserIds].toList();
                                  });
                                },
                                onUserLimitExceed: () {},
                              );
                            });
                      },
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.transparent,
                              ),
                              margin: EdgeInsets.only(top: 10, bottom: 10),
                              child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    selectedUserName == ""
                                        ? "Select User"
                                        : selectedUserName,
                                    style: TextStyle(
                                        color: selectedUserName == ""
                                            ? Colors.grey[500]
                                            : Colors.white,
                                        fontSize: 15),
                                  )),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Divider(
                  color: Colors.white,
                ),
                SizedBox(height: 10,),
                Align(alignment: Alignment.centerLeft,
                  child:Text(
                    'Stage Type : ',
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.grey[500],
                    ),
                  ),
                ),
                SizedBox(height: 2,),
                Center(
                  child: Form(
                    key: stageKeyDropDownFormField,
                    child: GestureDetector(
                      onTap: () {
                        showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return CustomDialogBox(
                                allUsers: stageLists,
                                maxUser: 1,
                                onUserSelect:
                                    (selectedUserIds, selectedUserName) {
                                  this.selectedStageIds = selectedUserIds;
                                  this.selectedStageName = selectedUserName;
                                  setState(() {
                                    this.selectedStageName = selectedUserName;
                                    this.selectedStageIds = selectedUserIds;
                                    // checkedUser = [selectedUserName + selectedUserIds].toList();
                                  });
                                },
                                onUserLimitExceed: () {      _showSnakBarMsg(
                                    "You can't chose more then one Stage type!");},
                              );
                            });
                      },
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.transparent,
                              ),
                              margin: EdgeInsets.only(top: 10, bottom: 10),
                              child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    selectedStageName == ""
                                        ? "Select Stage"
                                        : selectedStageName,
                                    style: TextStyle(
                                        color: selectedStageName == ""
                                            ? Colors.grey[500]
                                            : Colors.white,
                                        fontSize: 15),
                                  )),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Divider(
                  color: Colors.white,
                ),
                SizedBox(height: 10,),
                Align(alignment: Alignment.centerLeft,
                  child:Text(
                    'Document Required : ',
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.grey[500],
                    ),
                  ),
                ),
                SizedBox(height: 2,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    new Radio(
                      value: 0,
                      groupValue: _verticalGroupValue,
                      onChanged: (val) {
                          print("Radio $val");
                          setSelectedRadio(val);
                          },

                    ),
                    new Text(
                      'None',
                      style: new TextStyle(fontSize: 16.0),
                    ),
                    new Radio(
                      value: 1,
                      groupValue: _verticalGroupValue,
                      onChanged: (val) {
                        print("Radio $val");
                        setSelectedRadio(val);
                      },
                    ),
                    new Text(
                      'Single',
                      style: new TextStyle(
                        fontSize: 16.0,
                      ),
                    ),
                    new Radio(
                      value: 2,
                      groupValue: _verticalGroupValue,
                      onChanged: (val) {
                        print("Radio $val");
                        setSelectedRadio(val);
                      },

                    ),
                    new Text(
                      'Many',
                      style: new TextStyle(fontSize: 16.0),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                MaterialButton(
                  minWidth: double.infinity,
                  padding: EdgeInsets.only(top: 10, bottom: 10),
                  onPressed: () {
                    setState(() {        if(phaseName.text.isEmpty)
                    {
                      _showSnakBarMsg("Enter Stage Name");
                      return;
                    }else if(selectedUserName.isEmpty)
                    {
                      _showSnakBarMsg("Select User");
                    }else if(selectedStageName.isEmpty)
                    {
                      _showSnakBarMsg("Select Stage");
                    }
                    else{
                      _addPhase();
                    }});
                  },
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  disabledColor: Colors.grey,
                  disabledTextColor: Colors.white,
                  highlightColor: Colors.orangeAccent,
                  color: Colors.white,
                  elevation: 4.0,
                  child: Text("Create Stage",
                    style: TextStyle(color: ConstantColor.BUTTONCOLORTEXT),),
                ),
                MaterialButton(
                  minWidth: double.maxFinite,
                  onPressed: () async {
                     showExitDialog();
                  },
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  disabledColor: Colors.grey,
                  disabledTextColor: Colors.white,
                  highlightColor: Colors.orangeAccent,
                  color: Colors.white,
                  elevation: 4.0,
                  child: Text(
                    'Finish',
                    style: TextStyle(color: ConstantColor.BUTTONCOLORTEXT),
                  ),
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

  Future<bool> _addPhase() async {
    showLoaderDialog(context);
    var params = {
      "process_name_id": id,
      "title": phaseName.text,
      "phase_members": selectedUserIds,
      "stage_id": selectedStageIds,
      "document_count": selectedRadio,
      "description": phaseDescription.text,
    };

    http.Response response = await http.post(Uri.parse(URL.ADD_PHASE),
        body: jsonEncode(params),
        headers: {"Content-Type": "application/json"});
    print(jsonEncode(params));
    var jsonResponse = jsonDecode(response.body);
    Navigator.pop(context);
    bool status = jsonResponse['status'];
    if (status) {
      count = count +1;
      selectedRadio = 0;
      _verticalGroupValue = 0;
      setState(() {
          phaseName.text  = "";
          phaseDescription.text  = "";
          selectedUserIds = "";
          selectedStageName = "";
          selectedUserName = "";
          selectedStageIds = "";
      });
      //
      // Phase phase = new Phase();
      // // phase.processNameId = id;
      // phase.title = phaseName.text;

      _showSnakBarMsg("Stage $count create successful!");
    } else {
      _showSnakBarMsg("Can't create stage, Try again!");
    }
    return status;
  }
  void _showSnakBarMsg(String msg) {
    _scaffoldKey.currentState
        .
    // ignore: deprecated_member_use
    showSnackBar(new SnackBar(content: new Text(msg)));
  }
  setSelectedRadio(int val) {
    setState(() {
      selectedRadio = val;
      _verticalGroupValue = selectedRadio;
    });
  }
  void _sendDataToProjectOverallDetailedStatusScreen(BuildContext context) {

      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProcessBegin(),
          ));

  }


  void showExitDialog() {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text("Complete"),
          content: Text("Are your sure you add all milestone?"),
          actions: [
            // ignore: deprecated_member_use
            FlatButton(
              onPressed: () async {
                _sendDataToProjectOverallDetailedStatusScreen(context);
              },
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
              disabledColor: Colors.grey,
              disabledTextColor: Colors.white,
              highlightColor: Colors.orangeAccent,
              color: Colors.white,
              child: Text(
                'Yes',
                style: TextStyle(color: Colors.green[900]),
              ),
            ),
          ],
        ));
  }


}
