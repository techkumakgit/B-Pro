import 'dart:convert';
import 'dart:io';
import 'dart:io' as Io;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:processmanagement/Constant/StageConstant.dart';
import 'package:processmanagement/Constant/StatusConstant.dart';
import 'package:processmanagement/Model/Phase.dart';
import 'package:processmanagement/Model/Process.dart';
import 'package:processmanagement/other/ConstantColor.dart';
import 'package:processmanagement/other/Constants.dart';
import 'package:processmanagement/other/URL.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProcessBegin extends StatefulWidget {
  final Process myObject;

  ProcessBegin({this.myObject});

  @override
  _ProcessBeginState createState() => _ProcessBeginState();
}

class _ProcessBeginState extends State<ProcessBegin> {
  int userId;
  bool attachment = false;
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  File imageFile;
  String imageString;
  String _valueChanged1 = '';
  String _valueToValidate1 = '';
  String _valueSaved1 = '';
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _clicked = false;
  VoidCallback continueCallBack;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    load();
    fibonacci();
  }
  load() async {
    final prefs = await SharedPreferences.getInstance();
    userId = prefs.getInt(Constant.USER_ID) ?? -1;
    // print(userId);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        elevation: 0,
        title: Text("Process Execution"),
        backgroundColor: ConstantColor.APPBAR,
        centerTitle: false,
        leading: new IconButton(
          icon: new Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
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
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Expanded(
                    child: Text(
                      "Process ID : " + widget.myObject.id.toString(),
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    ),
                  ),
                ],
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Process Name : " + widget.myObject.title,
                  style: TextStyle(fontSize: 15, color: Colors.white),
                ),
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Process Description : " + widget.myObject.description,
                  style: TextStyle(fontSize: 15, color: Colors.white),
                ),
              ),
            SizedBox(height: 10,),
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: <Widget>[
              Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Start Time : " + "${widget.myObject.startDate == null ? "- - -" : widget.myObject.startDate}",
                style: TextStyle(fontSize: 15, color: Colors.white),
              ),
            ),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "End Time : " +
                      "${widget.myObject.endDate == null ? "- - -" : widget.myObject.endDate}",
                  style: TextStyle(fontSize: 15, color: Colors.white),
                ),
              ),],),




              SizedBox(
                height: 10,
              ),
              Align(
                alignment: Alignment.bottomLeft,
                child: Text(
                  "Process Work Flow",
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
              Flexible(
                  fit: FlexFit.tight,
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      shrinkWrap: true,
                      itemCount: widget.myObject.phase.length,
                      itemBuilder: (BuildContext context, int index) {
                        return GestureDetector(
                            onTap: () async =>
                            widget.myObject.phase[index].status.idInt == StatusConstant.IN_PROGRESS ? await
                            stageDetail(widget.myObject.phase[index], context, index) : null,
                            child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Container(
                                      width: 200,
                                      margin: EdgeInsets.only(top: 10),
                                      decoration: new BoxDecoration(
                                          color: ConstantColor.CARD,
                                          borderRadius: new BorderRadius.only(
                                            topLeft: const Radius.circular(5.0),
                                            topRight:
                                                const Radius.circular(5.0),
                                            bottomRight:
                                                const Radius.circular(5.0),
                                            bottomLeft:
                                                const Radius.circular(5.0),
                                          )),
                                      padding: EdgeInsets.all(10),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: <Widget>[
                                          Text(
                                            "Stage ID : " +
                                                widget.myObject.phase[index].id
                                                    .toString(),
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 11),
                                          ),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          Wrap(
                                            children: [
                                              Text(
                                                "Stage Name : " +
                                                    widget.myObject.phase[index]
                                                        .title,
                                                style: TextStyle(
                                                    color: Colors.black),
                                                textAlign: TextAlign.center,
                                                maxLines: 1,
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Align(
                                            alignment: Alignment.centerLeft,
                                            child: Text(
                                              "Start Time : " +
                                                  "${widget.myObject.phase[index].startTime == "" ? "- - -" : widget.myObject.phase[index].startTime}",
                                              style: TextStyle(
                                                  fontSize: 13,
                                                  color: Colors.black),
                                            ),
                                          ),
                                          Align(
                                            alignment: Alignment.centerLeft,
                                            child: Text(
                                              "End Time : " +
                                                  "${widget.myObject.phase[index].endTime == "" ? "- - -" : widget.myObject.phase[index].endTime}",
                                              style: TextStyle(
                                                  fontSize: 13,
                                                  color: Colors.black),
                                            ),
                                          ),
                                          Container(
                                            alignment: Alignment.center,
                                            margin: EdgeInsets.only(top: 15),
                                            padding: EdgeInsets.only(
                                                top: 3,
                                                bottom: 3,
                                                left: 15,
                                                right: 15),
                                            decoration: BoxDecoration(
                                              color: widget
                                                          .myObject
                                                          .phase[index]
                                                          .status
                                                          .idInt ==
                                                      StatusConstant.COMPLETE
                                                  ? ConstantColor.COMPLETE
                                                  : widget.myObject.phase[index]
                                                              .status.idInt ==
                                                          StatusConstant
                                                              .NOT_STARTED
                                                      ? ConstantColor
                                                          .NOT_STARTED
                                                      : widget
                                                                  .myObject
                                                                  .phase[index]
                                                                  .status
                                                                  .idInt ==
                                                              StatusConstant
                                                                  .IN_PROGRESS
                                                          ? ConstantColor
                                                              .IN_PROGRESS
                                                          : widget
                                                                      .myObject
                                                                      .phase[
                                                                          index]
                                                                      .status
                                                                      .idInt ==
                                                                  StatusConstant
                                                                      .REJECTED
                                                              ? ConstantColor
                                                                  .REJECTED
                                                              : widget
                                                                          .myObject
                                                                          .phase[
                                                                              index]
                                                                          .status
                                                                          .idInt ==
                                                                      StatusConstant
                                                                          .WAITING
                                                                  ? ConstantColor
                                                                      .WAITING
                                                                  : Colors.grey,
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                            ),
                                            child: Text(
                                              // "in progress",
                                              widget.myObject.phase[index]
                                                  .status.name
                                                  .toString()
                                                  .replaceAll("_", " ")
                                                  .toUpperCase(),
                                              style: TextStyle(
                                                fontSize: 13,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                        ],
                                      )),
                                  Visibility(
                                      visible: index !=
                                          widget.myObject.phase.length - 1,
                                      child: RotatedBox(
                                          quarterTurns: 3,
                                          child: Container(
                                              margin: EdgeInsets.only(
                                                right: 60,
                                              ),
                                              child: Icon(
                                                Icons.arrow_downward_sharp,
                                                color: Colors.white,
                                                size: 40,
                                              )))),
                                ]));
                      }))
            ],
          ),
        ),
      ),
    );
  }
  Future<void> showMember(Phase phase, BuildContext context) async {
    StateSetter _setState;

    return await showDialog<ImageSource>(
        context: context,
        builder: (context) {
          // VoidCallback continueCallBack = () => {
          //   showMember(phase, context),
          //   // code on continue comes here
          // };
          return StatefulBuilder(builder: (context, StateSetter setState) {
            _setState = setState;
            return Dialog(
              shape: RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(10)),
              backgroundColor: ConstantColor.UNSELECTED,
              child: Wrap(
                children: <Widget>[
                  Container(

                    margin: EdgeInsets.only(top: 18, bottom: 15),
                    child: Align(
                      alignment: Alignment.center,
                      child: Text(
                        phase.title,
                        style: TextStyle(color: Colors.white, fontSize: 18),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  ListView.builder(
                      shrinkWrap: true,
                      itemCount: phase.phaseMember.length,
                      itemBuilder:
                          (BuildContext context, int phaseMemberIndex) {
                        return Wrap(
                          children: <Widget>[
                            Row(
                              children: [
                                Expanded(
                                    child: Wrap(
                                      children: [
                                        Row(
                                          children: <Widget>[
                                            Container(
                                              padding: EdgeInsets.only(
                                                left: 15,
                                              ),
                                              // margin: EdgeInsets.only(top: 7,),
                                              child: Text(
                                                "User ID : " +
                                                    phase
                                                        .phaseMember[
                                                    phaseMemberIndex]
                                                        .id
                                                        .toString(),
                                                textAlign: TextAlign.left,
                                                style: TextStyle(
                                                  fontSize: 13,
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Container(
                                          margin: EdgeInsets.only(left: 15),
                                          child: Text(
                                            "User Name : " +
                                                phase
                                                    .phaseMember[phaseMemberIndex]
                                                    .name,
                                            textAlign: TextAlign.left,
                                            style: TextStyle(
                                              fontSize: 13,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      ],
                                    )),
                                Visibility(
                                    visible: userId ==
                                        phase
                                            .phaseMember[phaseMemberIndex].id,
                                    child: Expanded(
                                        child: Wrap(
                                          children: [
                                            phase.phaseMember[phaseMemberIndex]
                                                .isApproved
                                                ? Center(
                                              child: Text(
                                                "Approved",
                                                style: TextStyle(
                                                    color: Colors.green,
                                                    fontWeight:
                                                    FontWeight.bold),
                                                textAlign: TextAlign.center,
                                              ),
                                            )
                                                : Row(
                                              children: <Widget>[
                                                Visibility(
                                                  visible: phase.stage.id ==
                                                      StageConstant
                                                          .APPROVEL,
                                                  child: Container(
                                                    height: 30,
                                                    width: 60,
                                                    margin: EdgeInsets.only(
                                                        left: 15),
                                                    // padding: EdgeInsets.only(
                                                    //     top: 4,
                                                    //     bottom: 4,
                                                    //     left: 10,
                                                    //     right: 10),
                                                    decoration:
                                                    new BoxDecoration(
                                                        color:
                                                        ConstantColor
                                                            .CARD,
                                                        borderRadius:
                                                        new BorderRadius
                                                            .only(
                                                          topLeft:
                                                          const Radius
                                                              .circular(
                                                              5.0),
                                                          topRight:
                                                          const Radius
                                                              .circular(
                                                              5.0),
                                                          bottomRight:
                                                          const Radius
                                                              .circular(
                                                              5.0),
                                                          bottomLeft:
                                                          const Radius
                                                              .circular(
                                                              5.0),
                                                        )),
                                                    child: TextButton(
                                                      onPressed: () {
                                                        updatePhaseMemberStatus(
                                                            phase
                                                                .phaseMember[
                                                            phaseMemberIndex]
                                                                .id,
                                                            phase.id,
                                                            false,
                                                            phase
                                                                .documentCount);
                                                      },
                                                      child: Text(
                                                        'Reject',
                                                        style: TextStyle(
                                                            fontSize: 12),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                Visibility(
                                                  visible: phase.stage.id ==
                                                      StageConstant
                                                          .APPROVEL,
                                                  child: Container(
                                                    height: 30,
                                                    width: 65,
                                                    margin: EdgeInsets.only(
                                                        left: 5),
                                                    // padding: EdgeInsets.only(
                                                    //     top: 4,
                                                    //     bottom: 4,
                                                    //     left: 10,
                                                    //     right: 10),
                                                    decoration:
                                                    new BoxDecoration(
                                                        color:
                                                        ConstantColor
                                                            .CARD,
                                                        borderRadius:
                                                        new BorderRadius
                                                            .only(
                                                          topLeft:
                                                          const Radius
                                                              .circular(
                                                              5.0),
                                                          topRight:
                                                          const Radius
                                                              .circular(
                                                              5.0),
                                                          bottomRight:
                                                          const Radius
                                                              .circular(
                                                              5.0),
                                                          bottomLeft:
                                                          const Radius
                                                              .circular(
                                                              5.0),
                                                        )),
                                                    child: TextButton(
                                                      onPressed: () {
                                                        updatePhaseMemberStatus(
                                                            phase
                                                                .phaseMember[
                                                            phaseMemberIndex]
                                                                .id,
                                                            phase.id,
                                                            true,
                                                            phase
                                                                .documentCount);
                                                        setState(() {
                                                          attachment = true;
                                                        });
                                                      },
                                                      child: Text(
                                                        'Approve',
                                                        style: TextStyle(
                                                            fontSize: 12),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                Visibility(
                                                  visible: phase.stage.id ==
                                                      StageConstant.PROCESS,
                                                  child: Container(
                                                    height: 30,
                                                    width: 68,
                                                    margin: EdgeInsets.only(
                                                        left: 15),
                                                    // padding: EdgeInsets.only(
                                                    //     top: 4,
                                                    //     bottom: 4,
                                                    //     left: 10,
                                                    //     right: 10),
                                                    decoration:
                                                    new BoxDecoration(
                                                        color:
                                                        ConstantColor
                                                            .CARD,
                                                        borderRadius:
                                                        new BorderRadius
                                                            .only(
                                                          topLeft:
                                                          const Radius
                                                              .circular(
                                                              5.0),
                                                          topRight:
                                                          const Radius
                                                              .circular(
                                                              5.0),
                                                          bottomRight:
                                                          const Radius
                                                              .circular(
                                                              5.0),
                                                          bottomLeft:
                                                          const Radius
                                                              .circular(
                                                              5.0),
                                                        )),
                                                    child: TextButton(
                                                      onPressed: () =>
                                                          updatePhaseMemberStatus(
                                                              phase
                                                                  .phaseMember[
                                                              phaseMemberIndex]
                                                                  .id,
                                                              phase.id,
                                                              true,
                                                              phase
                                                                  .documentCount),
                                                      child: Text(
                                                        'Processed',
                                                        style: TextStyle(
                                                            fontSize: 12),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            attachment
                                                ? Center(
                                                child: TextButton(
                                                  onPressed: () async {
                                                    Navigator.pop(context, ImageSource.gallery);
                                                    _setState((){});
                                                    // _pickImage();
                                                    },
                                                  child: Container(
                                                    height: 20,
                                                    width: 120,
                                                    margin:
                                                    EdgeInsets.only(top: 3),
                                                    child: imageFile != null ? Image.file(imageFile) :
                                                    Text("Add Attachment",
                                                      style: TextStyle(
                                                          color: Colors
                                                              .white),
                                                    )
                                                  ),
                                                ))
                                                : Container()
                                            // Container(
                                            //   margin: EdgeInsets.only(top: 20),
                                            //   height: 100,
                                            //   width: 100,
                                            //   child: Center(child: imageFile != null ? Image.file(imageFile) : Container(),),
                                            // ),
                                          ],
                                        ))),
                              ],
                            ),
                            Divider(
                              thickness: 1,
                              color: Colors.grey,
                            ),
                          ],
                        );
                      }),
                  Container(
                    margin: EdgeInsets.only(bottom: 30),
                  )
                ],
              ),
              );

          });
        }).then((ImageSource source) async {
      if (source != null) {
        final pickedFile = await ImagePicker().getImage(source: source);
        setState(() => imageFile = File(pickedFile.path));
        showMember(phase, context);
      }
    });
  }
  Future<void> stageDetail(Phase phase,  BuildContext context,int index) async {
    StateSetter _setState;
    return await showDialog<ImageSource>(
        context: context,
        builder: (context) {
          // VoidCallback continueCallBack = () => {
          //   showMember(phase, context),
          //   // code on continue comes here
          // };
          return StatefulBuilder(builder: (context, StateSetter setState) {
            _setState = setState;
            return Dialog(
              shape: RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(10)),
              backgroundColor: ConstantColor.UNSELECTED,
              child: Wrap(
                children: <Widget>[
                  Container(

                    margin: EdgeInsets.only(top: 18, bottom: 4),
                    child: Align(
                      alignment: Alignment.center,
                      child: Text(
                        "Stage Name : "+phase.title,
                        style: TextStyle(color: Colors.white, fontSize: 16),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  Container(

                    margin: EdgeInsets.only(top: 1, bottom: 1, left: 15),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Phase ID : "+phase.id.toString(),
                        style: TextStyle(color: Colors.white, fontSize: 15),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  Container(

                    margin: EdgeInsets.only(top: 1, bottom: 10, left: 15),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Description : "+phase.description,
                        style: TextStyle(color: Colors.white, fontSize: 15),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(top: 3, bottom: 1,left: 15),
                      child: Align(
                        alignment: Alignment.centerRight,
                        child:  Text(
                          "Previous Stage : \n" + "${(index-1) < 0 ? "- - -" :  widget.myObject.phase[index-1].title}" ,
                          style: TextStyle(color: Colors.white, fontSize: 15),
                          textAlign: TextAlign.center,
                        )
                      ),
                    ),
                    Container(

                      margin: EdgeInsets.only(top: 3, bottom: 1, right: 15),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Next Stage : \n"+ "${(index+1) > widget.myObject.phase.length ? "- - -" :  widget.myObject.phase[index+1].title}" ,
                          style: TextStyle(color: Colors.white, fontSize: 15),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ],),
                Row(
                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                 children: [
                 Container(

                   margin: EdgeInsets.only(top: 15, bottom: 1, left: 15),
                   child: Align(
                     alignment: Alignment.centerLeft,
                     child: Text(
                       "Start Time : \n" + "${phase.startTime == ""? "- - -" : phase.startTime}",
                       style: TextStyle(color: Colors.white, fontSize: 15),
                       textAlign: TextAlign.center,
                     ),
                   ),
                 ),
                 Container(
                   margin: EdgeInsets.only(top: 15, bottom: 1, right: 15),
                   child: Align(
                     alignment: Alignment.centerRight,
                     child: Text(
                       "End Time : \n" + "${phase.endTime == "" ? "- - -" : phase.endTime}",
                       style: TextStyle(color: Colors.white, fontSize: 15),
                       textAlign: TextAlign.center,
                     ),
                   ),
                 ),
               ],),
                  // Divider(
                  //   thickness: 1,
                  //   color: Colors.grey,
                  // ),

                  ListView.builder(
                      shrinkWrap: true,
                      itemCount: phase.phaseMember.length,
                      itemBuilder:
                          (BuildContext context, int phaseMemberIndex) {
                        return Wrap(
                          children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                // Expanded(
                                //     child: Wrap(
                                //       children: [
                                //         Row(
                                //           children: <Widget>[
                                //             Container(
                                //               padding: EdgeInsets.only(
                                //                 left: 15,
                                //               ),
                                //               // margin: EdgeInsets.only(top: 7,),
                                //               child: Text(
                                //                 "User Id : " +
                                //                     phase
                                //                         .phaseMember[
                                //                     phaseMemberIndex]
                                //                         .id
                                //                         .toString(),
                                //                 textAlign: TextAlign.left,
                                //                 style: TextStyle(
                                //                   fontSize: 13,
                                //                   color: Colors.white,
                                //                 ),
                                //               ),
                                //             ),
                                //           ],
                                //         ),
                                //         Container(
                                //           margin: EdgeInsets.only(left: 15),
                                //           child: Text(
                                //             "User Name : " +
                                //                 phase
                                //                     .phaseMember[phaseMemberIndex]
                                //                     .name,
                                //             textAlign: TextAlign.left,
                                //             style: TextStyle(
                                //               fontSize: 13,
                                //               color: Colors.white,
                                //             ),
                                //           ),
                                //         ),
                                //       ],
                                //     )),
                                SizedBox(width: 165,),
                                Visibility(
                                   visible: userId ==
                                       phase
                                           .phaseMember[phaseMemberIndex].id,
                                   child: Expanded(
                                       child: Wrap(
                                         children: [
                                           Container(height: 15,),

                                           phase.phaseMember[phaseMemberIndex]
                                               .isApproved
                                               ? Center(
                                             child: Text(
                                               "Approved",
                                               style: TextStyle(
                                                   color: Colors.green,
                                                   fontWeight:
                                                   FontWeight.bold),
                                               textAlign: TextAlign.center,
                                             ),
                                           )
                                               : Row(
                                             children: <Widget>[
                                               Visibility(
                                                 visible: phase.stage.id == StageConstant.APPROVEL,
                                                 child: Container(
                                                   height: 30,
                                                   width: 60,
                                                   margin: EdgeInsets.only(
                                                       left: 15),

                                                   decoration:
                                                   new BoxDecoration(
                                                       color:
                                                       ConstantColor
                                                           .CARD,
                                                       borderRadius:
                                                       new BorderRadius
                                                           .only(
                                                         topLeft:
                                                         const Radius
                                                             .circular(
                                                             5.0),
                                                         topRight:
                                                         const Radius
                                                             .circular(
                                                             5.0),
                                                         bottomRight:
                                                         const Radius
                                                             .circular(
                                                             5.0),
                                                         bottomLeft:
                                                         const Radius
                                                             .circular(
                                                             5.0),
                                                       )),
                                                   child: TextButton(
                                                     onPressed: () {
                                                       updatePhaseMemberStatus(
                                                           phase
                                                               .phaseMember[
                                                           phaseMemberIndex]
                                                               .id,
                                                           phase.id,
                                                           false,
                                                           phase
                                                               .documentCount);
                                                     },
                                                     child: Text(
                                                       'Reject',
                                                       style: TextStyle(
                                                           fontSize: 12),
                                                     ),
                                                   ),
                                                 ),
                                               ),
                                               Visibility(
                                                 visible: phase.stage.id ==
                                                     StageConstant
                                                         .APPROVEL,
                                                 child: Container(
                                                   height: 30,
                                                   width: 65,
                                                   margin: EdgeInsets.only(
                                                       left: 5),
                                                   // padding: EdgeInsets.only(
                                                   //     top: 4,
                                                   //     bottom: 4,
                                                   //     left: 10,
                                                   //     right: 10),
                                                   decoration:
                                                   new BoxDecoration(
                                                       color:
                                                       ConstantColor
                                                           .CARD,
                                                       borderRadius:
                                                       new BorderRadius
                                                           .only(
                                                         topLeft:
                                                         const Radius
                                                             .circular(
                                                             5.0),
                                                         topRight:
                                                         const Radius
                                                             .circular(
                                                             5.0),
                                                         bottomRight:
                                                         const Radius
                                                             .circular(
                                                             5.0),
                                                         bottomLeft:
                                                         const Radius
                                                             .circular(
                                                             5.0),
                                                       )),
                                                   child: TextButton(
                                                     onPressed: () {
                                                       updatePhaseMemberStatus(
                                                           phase
                                                               .phaseMember[
                                                           phaseMemberIndex]
                                                               .id,
                                                           phase.id,
                                                           true,
                                                           phase
                                                               .documentCount);
                                                       setState(() {
                                                         attachment = true;
                                                       });
                                                     },
                                                     child: Text(
                                                       'Approve',
                                                       style: TextStyle(
                                                           fontSize: 12),
                                                     ),
                                                   ),
                                                 ),
                                               ),
                                               Visibility(
                                                 visible: phase.stage.id ==
                                                     StageConstant.PROCESS,
                                                 child: Container(
                                                   height: 30,
                                                   width: 68,
                                                   margin: EdgeInsets.only(
                                                       left: 15),
                                                   // padding: EdgeInsets.only(
                                                   //     top: 4,
                                                   //     bottom: 4,
                                                   //     left: 10,
                                                   //     right: 10),
                                                   decoration:
                                                   new BoxDecoration(
                                                       color:
                                                       ConstantColor
                                                           .CARD,
                                                       borderRadius:
                                                       new BorderRadius
                                                           .only(
                                                         topLeft:
                                                         const Radius
                                                             .circular(
                                                             5.0),
                                                         topRight:
                                                         const Radius
                                                             .circular(
                                                             5.0),
                                                         bottomRight:
                                                         const Radius
                                                             .circular(
                                                             5.0),
                                                         bottomLeft:
                                                         const Radius
                                                             .circular(
                                                             5.0),
                                                       )),
                                                   child: TextButton(
                                                     onPressed: () =>
                                                         updatePhaseMemberStatus(
                                                             phase
                                                                 .phaseMember[
                                                             phaseMemberIndex]
                                                                 .id,
                                                             phase.id,
                                                             true,
                                                             phase
                                                                 .documentCount),
                                                     child: Text(
                                                       'Processed',
                                                       style: TextStyle(
                                                           fontSize: 12),
                                                     ),
                                                   ),
                                                 ),
                                               ),
                                             ],
                                           ),
                                           SizedBox(
                                             height: 10,
                                           ),
                                           attachment
                                               ? Center(
                                               child: TextButton(
                                                 onPressed: () async {
                                                   Navigator.pop(context, ImageSource.gallery);
                                                   _setState((){});
                                                   // _pickImage();
                                                 },
                                                 child: Container(
                                                     height: 20,
                                                     width: 120,
                                                     margin:
                                                     EdgeInsets.only(top: 3),
                                                     child: imageFile != null
                                                         ? Image.file(imageFile) :
                                                     Text("Add Attachment",
                                                       style: TextStyle(
                                                           color: Colors
                                                               .white),
                                                     )
                                                 ),
                                               ))
                                               : Container()
                                           // Container(
                                           //   margin: EdgeInsets.only(top: 20),
                                           //   height: 100,
                                           //   width: 100,
                                           //   child: Center(child: imageFile != null ? Image.file(imageFile) : Container(),),
                                           // ),
                                         ],
                                       )
                                   )
                             ),
                              ],
                            ),
                            // Divider(
                            //   thickness: 1,
                            //   color: Colors.grey,
                            // ),
                          ],
                        );
                      }),
                  Container(
                    margin: EdgeInsets.only(bottom: 30),
                  )
                ],
              ),
              );

          });
        }).then((ImageSource source) async {
      if (source != null) {
        final pickedFile = await ImagePicker().getImage(source: source);
        setState(() => imageFile = File(pickedFile.path));
        showMember(phase, context);
      }
    });
  }
// sendtonext(phase)
// {
//   Navigator.push(+0
//       context,
//       MaterialPageRoute(
//         builder: (context) => ImagePickDialog(
//           phase :phase,
//         ),
//       ));
// }
  updatePhaseMemberStatus(
      int userId, int phaseId, bool b, int documentCount) async {
    if (documentCount > 0) {
      return;
    }

    showLoaderDialog(context);
    var params = {
      "memberId": userId,
      "phaseId": phaseId,
      "processId": widget.myObject.id,
      "status": b,
    };

    http.Response response = await http.post(
        Uri.parse(URL.UPDATE_PHASE_MEMEBER_STATUS),
        body: jsonEncode(params),
        headers: {"Content-Type": "application/json"});
    // print(jsonEncode(params));

    var jsonResponse = jsonDecode(response.body);
    Navigator.pop(context);

    bool status = jsonResponse['status'];
    if (status) {
      _showSnakBarMsg("Update Successfully!");
    } else {
      _showSnakBarMsg("Can Not Update!!");
    }
    return status;
  }

  showLoaderDialog(BuildContext context) {
    AlertDialog alert = AlertDialog(
      content: new Row(
        children: [
          CircularProgressIndicator(),
          Container(
              margin: EdgeInsets.only(left: 7),
              child: Text(
                "Creating Process...",
                style: TextStyle(color: ConstantColor.BUTTONCOLORTEXT),
              )),
        ],
      ),
    );
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  Future<void> _pickImage() async {
    final pickedImage =
    await ImagePicker().getImage(source: ImageSource.gallery);
    imageFile = pickedImage != null ? File(pickedImage.path) : null;

    if (imageFile != null) {
      final bytes = Io.File(pickedImage.path).readAsBytesSync();

      imageString = base64Encode(bytes);
      // print(imageString);
      setState(() {});
    }
  }

  void _showSnakBarMsg(String msg) {
    _scaffoldKey.currentState
        .
    // ignore: deprecated_member_use
    showSnackBar(new SnackBar(content: new Text(msg)));
  }
  int n = 10;
  int temp = 0;
  int x=10;
  int a = 0, b = 1, c, i;
  fibonacci()
  {

    if( n == 0)
      return a;
    for (i = 2; i <= n; i++)
    {
      c = a + b;
      a = b;
      b = c;
    }
    print(n);

  }
}
// class ImagePickDialog extends StatefulWidget {
//   final Process myObject;
//   final Phase phase;
//
//   ImagePickDialog({this.myObject, this.phase});
//   @override
//   _ImagePickDialogState createState() => _ImagePickDialogState(phase:phase);
// }
//
// class _ImagePickDialogState extends State<ImagePickDialog> {
//   _ImagePickDialogState({this.phase});
//   Phase phase;
//   int userId;
//   bool attachment = false;
//   final _scaffoldKey = GlobalKey<ScaffoldState>();
//   File imageFile;
//   String imageString;
//   String _valueChanged1 = '';
//
//   String _valueToValidate1 = '';
//   String _valueSaved1 = '';
//   final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
//   @override
//   Widget build(BuildContext context) {
//     return Dialog(
//       shape: RoundedRectangleBorder(
//           borderRadius: new BorderRadius.circular(10)),
//       backgroundColor: ConstantColor.UNSELECTED,
//       child: Form(key: _formKey,child:
//       Wrap(
//         children: <Widget>[
//           Container(
//
//             margin: EdgeInsets.only(top: 18, bottom: 15),
//             child: Align(
//               alignment: Alignment.center,
//               child: Text(
//                 phase.title,
//                 style: TextStyle(color: Colors.white, fontSize: 18),
//                 textAlign: TextAlign.center,
//               ),
//             ),
//           ),
//           ListView.builder(
//               shrinkWrap: true,
//               itemCount: phase.phaseMember.length,
//               itemBuilder:
//                   (BuildContext context, int phaseMemberIndex) {
//                 return Wrap(
//                   children: <Widget>[
//                     Row(
//                       children: [
//                         Expanded(
//                             child: Wrap(
//                               children: [
//                                 Row(
//                                   children: <Widget>[
//                                     Container(
//                                       padding: EdgeInsets.only(
//                                         left: 15,
//                                       ),
//                                       // margin: EdgeInsets.only(top: 7,),
//                                       child: Text(
//                                         "User Id : " +
//                                             phase
//                                                 .phaseMember[
//                                             phaseMemberIndex]
//                                                 .id
//                                                 .toString(),
//                                         textAlign: TextAlign.left,
//                                         style: TextStyle(
//                                           fontSize: 13,
//                                           color: Colors.white,
//                                         ),
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                                 Container(
//                                   margin: EdgeInsets.only(left: 15),
//                                   child: Text(
//                                     "User Name : " +
//                                         phase
//                                             .phaseMember[phaseMemberIndex]
//                                             .name,
//                                     textAlign: TextAlign.left,
//                                     style: TextStyle(
//                                       fontSize: 13,
//                                       color: Colors.white,
//                                     ),
//                                   ),
//                                 ),
//                               ],
//                             )),
//                         Visibility(
//                             visible: userId ==
//                                 phase
//                                     .phaseMember[phaseMemberIndex].id,
//                             child: Expanded(
//                                 child: Wrap(
//                                   children: [
//                                     phase.phaseMember[phaseMemberIndex]
//                                         .isApproved
//                                         ? Center(
//                                       child: Text(
//                                         "Approved",
//                                         style: TextStyle(
//                                             color: Colors.green,
//                                             fontWeight:
//                                             FontWeight.bold),
//                                         textAlign: TextAlign.center,
//                                       ),
//                                     )
//                                         : Row(
//                                       children: <Widget>[
//                                         Visibility(
//                                           visible: phase.stage.id ==
//                                               StageConstant
//                                                   .APPROVEL,
//                                           child: Container(
//                                             height: 30,
//                                             width: 60,
//                                             margin: EdgeInsets.only(
//                                                 left: 15),
//                                             // padding: EdgeInsets.only(
//                                             //     top: 4,
//                                             //     bottom: 4,
//                                             //     left: 10,
//                                             //     right: 10),
//                                             decoration:
//                                             new BoxDecoration(
//                                                 color:
//                                                 ConstantColor
//                                                     .CARD,
//                                                 borderRadius:
//                                                 new BorderRadius
//                                                     .only(
//                                                   topLeft:
//                                                   const Radius
//                                                       .circular(
//                                                       5.0),
//                                                   topRight:
//                                                   const Radius
//                                                       .circular(
//                                                       5.0),
//                                                   bottomRight:
//                                                   const Radius
//                                                       .circular(
//                                                       5.0),
//                                                   bottomLeft:
//                                                   const Radius
//                                                       .circular(
//                                                       5.0),
//                                                 )),
//                                             child: TextButton(
//                                               onPressed: () {
//                                                 updatePhaseMemberStatus(
//                                                     phase
//                                                         .phaseMember[
//                                                     phaseMemberIndex]
//                                                         .id,
//                                                     phase.id,
//                                                     false,
//                                                     phase
//                                                         .documentCount);
//                                               },
//                                               child: Text(
//                                                 'Reject',
//                                                 style: TextStyle(
//                                                     fontSize: 12),
//                                               ),
//                                             ),
//                                           ),
//                                         ),
//                                         Visibility(
//                                           visible: phase.stage.id ==
//                                               StageConstant
//                                                   .APPROVEL,
//                                           child: Container(
//                                             height: 30,
//                                             width: 65,
//                                             margin: EdgeInsets.only(
//                                                 left: 5),
//                                             // padding: EdgeInsets.only(
//                                             //     top: 4,
//                                             //     bottom: 4,
//                                             //     left: 10,
//                                             //     right: 10),
//                                             decoration:
//                                             new BoxDecoration(
//                                                 color:
//                                                 ConstantColor
//                                                     .CARD,
//                                                 borderRadius:
//                                                 new BorderRadius
//                                                     .only(
//                                                   topLeft:
//                                                   const Radius
//                                                       .circular(
//                                                       5.0),
//                                                   topRight:
//                                                   const Radius
//                                                       .circular(
//                                                       5.0),
//                                                   bottomRight:
//                                                   const Radius
//                                                       .circular(
//                                                       5.0),
//                                                   bottomLeft:
//                                                   const Radius
//                                                       .circular(
//                                                       5.0),
//                                                 )),
//                                             child: TextButton(
//                                               onPressed: () {
//                                                 updatePhaseMemberStatus(
//                                                     phase
//                                                         .phaseMember[
//                                                     phaseMemberIndex]
//                                                         .id,
//                                                     phase.id,
//                                                     true,
//                                                     phase
//                                                         .documentCount);
//                                                 setState(() {
//                                                   attachment = true;
//                                                 });
//                                               },
//                                               child: Text(
//                                                 'Approve',
//                                                 style: TextStyle(
//                                                     fontSize: 12),
//                                               ),
//                                             ),
//                                           ),
//                                         ),
//                                         Visibility(
//                                           visible: phase.stage.id ==
//                                               StageConstant.PROCESS,
//                                           child: Container(
//                                             height: 30,
//                                             width: 68,
//                                             margin: EdgeInsets.only(
//                                                 left: 15),
//                                             // padding: EdgeInsets.only(
//                                             //     top: 4,
//                                             //     bottom: 4,
//                                             //     left: 10,
//                                             //     right: 10),
//                                             decoration:
//                                             new BoxDecoration(
//                                                 color:
//                                                 ConstantColor
//                                                     .CARD,
//                                                 borderRadius:
//                                                 new BorderRadius
//                                                     .only(
//                                                   topLeft:
//                                                   const Radius
//                                                       .circular(
//                                                       5.0),
//                                                   topRight:
//                                                   const Radius
//                                                       .circular(
//                                                       5.0),
//                                                   bottomRight:
//                                                   const Radius
//                                                       .circular(
//                                                       5.0),
//                                                   bottomLeft:
//                                                   const Radius
//                                                       .circular(
//                                                       5.0),
//                                                 )),
//                                             child: TextButton(
//                                               onPressed: () =>
//                                                   updatePhaseMemberStatus(
//                                                       phase
//                                                           .phaseMember[
//                                                       phaseMemberIndex]
//                                                           .id,
//                                                       phase.id,
//                                                       true,
//                                                       phase
//                                                           .documentCount),
//                                               child: Text(
//                                                 'Processed',
//                                                 style: TextStyle(
//                                                     fontSize: 12),
//                                               ),
//                                             ),
//                                           ),
//                                         ),
//                                       ],
//                                     ),
//                                     SizedBox(
//                                       height: 10,
//                                     ),
//                                     attachment
//                                         ? Center(
//                                         child: TextButton(
//                                           onPressed: () => {setState(() {
//                                             _pickImage();
//                                           }),
//                                             // Navigator.pop(context),
//
//                                           },
//                                           child: Container(
//                                             height: 20,
//                                             width: 120,
//                                             margin:
//                                             EdgeInsets.only(top: 3),
//                                             child: imageFile != null
//                                                 ? Image.file(imageFile)
//                                                 : Text(
//                                               "Add Attachment",
//                                               style: TextStyle(
//                                                   color: Colors
//                                                       .white),
//                                             ),
//                                           ),
//                                         ))
//                                         : Container()
//                                     // Container(
//                                     //   margin: EdgeInsets.only(top: 20),
//                                     //   height: 100,
//                                     //   width: 100,
//                                     //   child: Center(child: imageFile != null ? Image.file(imageFile) : Container(),),
//                                     // ),
//                                   ],
//                                 ))),
//                       ],
//                     ),
//                     Divider(
//                       thickness: 1,
//                       color: Colors.grey,
//                     ),
//                   ],
//                 );
//               }),
//           Container(
//             margin: EdgeInsets.only(bottom: 30),
//           )
//         ],
//       ),
//       ),);
//   }
//
//
//   updatePhaseMemberStatus(
//       int userId, int phaseId, bool b, int documentCount) async {
//     if (documentCount > 0) {
//       return;
//     }
//
//     showLoaderDialog(context);
//     var params = {
//       "memberId": userId,
//       "phaseId": phaseId,
//       "processId": widget.myObject.id,
//       "status": b,
//     };
//
//     http.Response response = await http.post(
//         Uri.parse(URL.UPDATE_PHASE_MEMEBER_STATUS),
//         body: jsonEncode(params),
//         headers: {"Content-Type": "application/json"});
//     print(jsonEncode(params));
//
//     var jsonResponse = jsonDecode(response.body);
//     Navigator.pop(context);
//
//     bool status = jsonResponse['status'];
//     if (status) {
//       _showSnakBarMsg("Update Successfully!");
//     } else {
//       _showSnakBarMsg("Can Not Update!!");
//     }
//     return status;
//   }
//
//   showLoaderDialog(BuildContext context) {
//     AlertDialog alert = AlertDialog(
//       content: new Row(
//         children: [
//           CircularProgressIndicator(),
//           Container(
//               margin: EdgeInsets.only(left: 7),
//               child: Text(
//                 "Creating Process...",
//                 style: TextStyle(color: ConstantColor.BUTTONCOLORTEXT),
//               )),
//         ],
//       ),
//     );
//     showDialog(
//       barrierDismissible: false,
//       context: context,
//       builder: (BuildContext context) {
//         return alert;
//       },
//     );
//   }
//
//   Future _pickImage() async {
//     final pickedImage =
//     await ImagePicker().getImage(source: ImageSource.gallery);
//     imageFile = pickedImage != null ? File(pickedImage.path) : null;
//
//     if (imageFile != null) {
//       final bytes = Io.File(pickedImage.path).readAsBytesSync();
//
//       imageString = base64Encode(bytes);
//       print(imageString);
//       setState(() {});
//     }
//   }
//
//   void _showSnakBarMsg(String msg) {
//     _scaffoldKey.currentState
//         .
//     // ignore: deprecated_member_use
//     showSnackBar(new SnackBar(content: new Text(msg)));
//   }
// }
