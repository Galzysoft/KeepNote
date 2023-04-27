import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:keep_notes/constants/imports.dart';
import 'package:keep_notes/utils/databases.dart';

import 'state.dart';

class AddNotesLogic extends GetxController {
  final AddNotesState state = AddNotesState();
TextEditingController titleController=TextEditingController();
TextEditingController noteController=TextEditingController();

 Future <void> createNotes() async{

    if (titleController.text.isNotEmpty||noteController.text.isNotEmpty) {
      String dateTime=  DateFormat("mm:ss a").format(DateTime.now());

      DB!.execute(
          "INSERT INTO ${DatabaseConst.noteTable} (${DatabaseConst.noteTitle},${DatabaseConst.cateId},${DatabaseConst.noteDescription}, ${DatabaseConst.noteDateTime}) VALUES(?,?,?,?)",
          [
            titleController.text.isEmpty?"": titleController.text,
            0,
            noteController.text.isEmpty?"":noteController.text,
            dateTime
          ]).whenComplete(
          () {
            print('done inserting into ${DatabaseConst.noteTable}');
            titleController.clear();
           noteController.clear();

            selectAllNotes();
          });
    }
  }


  Future<void> selectAllNotes()async{
   var result= await DB!.rawQuery("SELECT * FROM ${DatabaseConst.noteTable}");
   print( 'result $result');
  }
}
