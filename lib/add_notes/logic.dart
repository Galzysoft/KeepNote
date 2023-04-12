import 'package:get/get.dart';
import 'package:keep_notes/constants/imports.dart';
import 'package:keep_notes/utils/databases.dart';

import 'state.dart';

class AddNotesLogic extends GetxController {
  final AddNotesState state = AddNotesState();

  void createNotes({String? title, String? description, String? dateTimes}) {
    DB!.execute(
        "INSERT INTO ${DatabaseConst.noteTable} (${DatabaseConst.noteTitle},${DatabaseConst.noteDescription}, ${DatabaseConst.noteDateTime}) VALUES(?,?,?)",
        [
          title,
          description,
          dateTimes
        ]).whenComplete(
        () {
          print('done inserting into ${DatabaseConst.noteTable}');
          selectAllNotes();
        });
  }
Future<void> selectAllNotes()async{
   var result= await DB!.rawQuery("SELECT * FROM ${DatabaseConst.noteTable}");
   print( 'result $result');
  }
}
