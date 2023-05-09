import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:keep_notes/constants/imports.dart';
import 'package:keep_notes/homepage/logic.dart';
import 'package:keep_notes/utils/databases.dart';

import 'state.dart';

class AddNotesLogic extends GetxController {
  final AddNotesState state = AddNotesState();
  TextEditingController titleController = TextEditingController();
  TextEditingController noteController = TextEditingController();
  var isCreateNotes = true.obs;
  final logic = Get.put(HomepageLogic());
  Future<void> createNotes() async {
    if (titleController.text.isNotEmpty || noteController.text.isNotEmpty) {
      // String dateTime=  DateFormat("mm:ss a").format(DateTime.now());
      String dateTime = DateTime.now().toString();

      DB!.execute(
          "INSERT INTO ${DatabaseConst.noteTable} (${DatabaseConst.noteTitle},${DatabaseConst.cateId},${DatabaseConst.noteDescription}, ${DatabaseConst.noteDateTime}) VALUES(?,?,?,?)",
          [
            titleController.text.isEmpty ? "" : titleController.text,
            0,
            noteController.text.isEmpty ? "" : noteController.text,
            dateTime
          ]).whenComplete(() {
        print('done inserting into ${DatabaseConst.noteTable}');
        logic.selectAllNotes();
        titleController.clear();
        noteController.clear();

        selectAllNotes();
      });
    }
  }

  Future<void> updateNotes({required int id}) async {
    DB!.execute(
        "UPDATE ${DatabaseConst.noteTable} SET ${DatabaseConst.noteTitle} = ?,${DatabaseConst.cateId} = ?,${DatabaseConst.noteDescription} = ? WHERE ${DatabaseConst.noteId} = ?",
        [titleController.text, 0, noteController.text,id]).whenComplete(() =>   logic.selectAllNotes());
  }

  Future<void> selectAllNotes() async {
    var result = await DB!.rawQuery("SELECT * FROM ${DatabaseConst.noteTable}");
    print('result $result');
  }
}
