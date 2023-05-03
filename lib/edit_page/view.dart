import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:keep_notes/customWidgets/noteCard.dart';
import 'package:keep_notes/homepage/logic.dart';

import 'logic.dart';

class EditPagePage extends StatelessWidget {
  final logic = Get.put(EditPageLogic());

  final state = Get.find<EditPageLogic>().state;

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
        Scaffold(backgroundColor: Colors.transparent,
          body: ListView.builder(
            itemCount: logic.totalList.length,
            itemBuilder: (context, index) =>
                NoteCard(noteModel: logic.totalList[index]),
          ),
        ),
      ],
    );
  }
}
