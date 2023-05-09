import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:keep_notes/customWidgets/noteCard.dart';
import 'package:keep_notes/homepage/logic.dart';

import 'logic.dart';

class EditPagePage extends StatefulWidget {
  @override
  State<EditPagePage> createState() => _EditPagePageState();
}

class _EditPagePageState extends State<EditPagePage> {
  final logic = Get.put(EditPageLogic());

  final state = Get
      .find<EditPageLogic>()
      .state;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.asset(
          height: Get.height,
          width: Get.width,
          "assets/back.jpeg",
          fit: BoxFit.cover,
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          bottomNavigationBar: ClipRRect(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20), topRight: Radius.circular(20)),
              child: BackdropFilter(
                filter: ImageFilter.blur(
                  sigmaX: 10,
                  sigmaY: 10,
                ),
                child: Container(
                    color: Colors.black.withOpacity(0.5),
                    height: 50,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: 20,
                        ),
                        IconButton(
                          onPressed: () {},
                          icon: Icon(
                            Icons.edit,
                            color: Colors.white,
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            showDialog<bool>(
                              context: context,
                              builder: (context) =>
                                  CupertinoAlertDialog(
                                      title: Text("Delete Note "),
                                      insetAnimationCurve: Curves.bounceInOut,
                                      insetAnimationDuration: Duration(
                                          seconds: 1),
                                      content:
                                      Text("Are you sure you want to delete"),
                                      actions: [
                                        TextButton(
                                          onPressed: () {
                                            Navigator.pop(context, false);
                                          },
                                          child: Text("No"),
                                        ),
                                        TextButton(
                                          onPressed: () {
                                            Navigator.pop(context, true);
                                          },
                                          child: Text("Yes"),
                                        ),
                                      ]),

                            ).then((value) {
                              if (value == true) {
                                logic.deleteNoteList().then((value) =>
                                    setState(() {}));
                              } else {}
                              return null;
                            });
                          },
                          color: Colors.white,
                          icon: Icon(
                            Icons.delete_forever,
                          ),
                        ),
                        SizedBox(
                          width: 20,
                        ),
                      ],
                    )),
              )),
          body: Obx(() {
            return ListView.builder(
              itemCount: logic.totalList.value.length,
              itemBuilder: (context, index) =>
                  NoteCard(
                      noteCardState: NoteCardState.ON_EDIT,
                      noteModel: logic.totalList.value[index],
                      onEdit: true),
            );
          }),
        ),
      ],
    );
  }
}
