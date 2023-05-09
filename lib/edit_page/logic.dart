import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:keep_notes/constants/imports.dart';
import 'package:keep_notes/homepage/model.dart';
import 'package:keep_notes/utils/databases.dart';

import 'state.dart';

class EditPageLogic extends GetxController {
  final EditPageState state = EditPageState();
 var totalList = RxList<NoteModel>();
  List<NoteModel> editList = [];

  Future deleteNoteList()async{
    try {
      editList.forEach((element) {
        deleteNote(id: int.parse(element.id!));

      });
      Get.showSnackbar(GetSnackBar(
        icon: Icon(Icons.delete),
        isDismissible: true,
        animationDuration: Duration(seconds: 1),
        forwardAnimationCurve: Curves.bounceInOut,
        borderRadius: 20,
        borderColor: Colors.white,
        duration: Duration(seconds: 4),
        title: "Delete",
        message: "Notes Deleted Successfully",
        backgroundColor: Colors.green,
      ));
    } on Exception catch (e) {
      Get.showSnackbar(GetSnackBar(
        isDismissible: true,
        animationDuration: Duration(seconds: 1),
        forwardAnimationCurve: Curves.bounceInOut,
        borderRadius: 20,
        borderColor: Colors.white,
        duration: Duration(seconds: 4),
        icon: Icon(Icons.delete),
        title: "Delete",
        message: "Notes Not Deleted",
        backgroundColor: Colors.red,
      )); // TODO
    }

  }

  Future deleteNote({required int id,}) async {
    try {

      DB!.execute(
          "DELETE FROM ${DatabaseConst.noteTable} WHERE ${DatabaseConst.noteId} = ?",
          [id]);
      editList.removeWhere((element) {

        return  element.id==id;
      });
      totalList.value.removeWhere((element) {

        return  element.id==id;
      });

      print("$id  is deleted");

    } on Exception catch (e) {
      print("$id  is not deleted");

      // TODO
    }
  }
}
