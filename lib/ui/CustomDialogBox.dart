import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:processmanagement/Model/User.dart';
import 'package:processmanagement/other/ConstantColor.dart';

class CustomDialogBox extends StatefulWidget {
  final List<User> allUsers;
  final int maxUser;
  final void Function(String s, String selectedUserName) onUserSelect;
  final void Function() onUserLimitExceed;

  const CustomDialogBox(
      {
         this.allUsers,
         this.maxUser,
         this.onUserSelect,
         this.onUserLimitExceed});

  @override
  _CustomDialogBoxState createState() => _CustomDialogBoxState();
}

class _CustomDialogBoxState extends State<CustomDialogBox> {
   List<User> filterUser;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: contentBox(context),
    );
  }

  @override
  void initState() {
    super.initState();
    filterUser = widget.allUsers;
  }

  contentBox(context) {
    return Stack(
      children: <Widget>[
        Container(
            decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                      color: Colors.black,
                      offset: Offset(0, 10),
                      blurRadius: 10),
                ]),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12.0),
                      color: ConstantColor.SECONDLINEARGRADIENT),
                  child: SizedBox(
                    height: 52.0,
                    child: TextField(
                      onChanged: (text) {
                        setState(() {
                          filterUser = widget.allUsers
                              .where((u) => (u.userName
                              .toLowerCase()
                              .startsWith(text.toLowerCase())))
                              .toList();

                        });
                      },
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hoverColor: Colors.white,
                        focusedBorder: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        errorBorder: InputBorder.none,
                        disabledBorder: InputBorder.none,
                        prefixIcon: Icon(
                          Icons.short_text,
                          color: Colors.white,
                        ),
                        suffixIcon: Icon(
                          Icons.search,
                          color: Colors.white,
                        ),
                        contentPadding: EdgeInsets.fromLTRB(60, 15, 10, 10),
                        hintText: 'Search Here',
                        hintStyle: TextStyle(color: Colors.white),
                      ),
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                Container(margin:EdgeInsets.only(right: 15),child: Align(alignment:Alignment.topRight,child: Text("Choose Maximum ${widget.maxUser}"))),
                ListView.builder(
                    shrinkWrap: true,
                    itemCount: filterUser.length,
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          CheckboxListTile(
                            title: Text(filterUser[index].userName),
                            value: filterUser[index].isChecked,
                            activeColor: Colors.blueGrey[200],
                            checkColor: ConstantColor.SECONDLINEARGRADIENT,
                            onChanged: (val) {
                              setState(
                                    () {
                                  filterUser[index].isChecked = val;
                                },
                              );
                            },
                          ),
                        ],
                      );
                    }),
                GestureDetector(
                  onTap: () {
                    String selectedUserIds = "";
                    String selectedUserName = "";
                    int selectedUser = 0;
                    for (int i = 0; i < filterUser.length; i++) {
                      if (filterUser[i].isChecked) {
                        selectedUserIds =
                            selectedUserIds + filterUser[i].id.toString() + ",";
                        selectedUserName =
                            selectedUserName + filterUser[i].userName + ",";
                        ++selectedUser;
                      }
                    }

                    if (selectedUser > widget.maxUser) {
                      widget.onUserLimitExceed();
                      return;
                    }

                    widget.onUserSelect(
                        selectedUserIds.substring(
                            0, selectedUserIds.length - 1),
                        selectedUserName.substring(
                            0, selectedUserName.length - 1));
                    Navigator.pop(context);
                  },
                  child: Container(
                    padding: EdgeInsets.only(right: 20, bottom: 20, top: 10),
                    child: Align(
                        alignment: Alignment.centerRight,
                        child: Text(
                          "Done",
                          style: TextStyle(
                              fontSize: 18, color: ConstantColor.SECONDLINEARGRADIENT),
                          textAlign: TextAlign.end,
                        )),
                  ),
                ),
              ],
            )),
      ],
    );
  }

  Future<List<User>> changeUserData(List<User> userSearchList) async {
    return userSearchList;
  }
}
